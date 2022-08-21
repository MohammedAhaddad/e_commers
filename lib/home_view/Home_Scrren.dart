import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commers/Data/FirestorHelper.dart';
import 'package:e_commers/Data/storageHelper.dart';
import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/home_view/Screen/AddScreen.dart';
import 'package:e_commers/home_view/Screen/ViewAllCategory.dart';
import 'package:e_commers/home_view/products/MainScreenProducts.dart';
import 'package:e_commers/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_Scrren extends StatelessWidget {
  late int index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 192, 214, 194),
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: const Color.fromARGB(255, 200, 208, 214),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.language),
          ),
          IconButton(
              onPressed: () {
                Provider.of<Auth_Provider>(context, listen: false).signlnOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Consumer<FirestorProveder>(
        builder: (context, provider, x) {
          return provider.catogeries == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.11,
                      child: ListView(
                        children: [
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                AppRouter.NavigateToWidget(MainScreenProducts(
                                    provider.catogeries[0].catId));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true),
                                    // ignore: unnecessary_null_comparison
                                    items: Provider.of<FirestorProveder>(
                                            context)
                                        .photos
                                        .map((e) => CachedNetworkImage(
                                              imageUrl: e.url,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )),
                            ),
                          ),
                          const Divider(),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.catogeries.length,
                                itemBuilder: (context, index) {
                                  index = index;
                                  return ViewAllCategory(
                                      provider.catogeries[index], index);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 140, 235, 143),
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()))
        },
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    ));
  }
}
