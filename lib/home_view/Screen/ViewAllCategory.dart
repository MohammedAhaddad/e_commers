// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/home_view/Home_Scrren.dart';
import 'package:e_commers/home_view/Screen/UpdatCatogry.dart';
import 'package:e_commers/home_view/products/MainScreenProducts.dart';
import 'package:e_commers/moodels/Catgory.dart';
import 'package:e_commers/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class ViewAllCategory extends StatelessWidget {
  Catgory catgory;
  int index;
  ViewAllCategory(this.catgory, this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestorProveder>(builder: (context, provider, x) {
      return SafeArea(
          child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height / 60),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15.0),
                color: Color.fromARGB(255, 191, 203, 212)),
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width / 1.02,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                //color: Colors.white,
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    AppRouter.NavigateToWidget(
                        MainScreenProducts(provider.catogeries[index].catId));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: catgory.ImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 300,
              ),
              FlatButton(
                onPressed: () {
                  //
                  //  AppRouter.NavigateToWidget();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      catgory.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )

              //Update
              ,
              SizedBox(
                height: MediaQuery.of(context).size.height / 300,
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<FirestorProveder>(context, listen: false)
                      .categoryNameConteoller
                      .text = catgory.name;
                  AppRouter.NavigateToWidget(UpdatCatogry(catgory));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )

              //delete
              ,
              SizedBox(
                height: MediaQuery.of(context).size.height / 300,
              ),
              FlatButton(
                onPressed: () async {
                  late BuildContext dialogContext;
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = context;
                        return Dialog(
                            child: SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('Loading'),
                              ],
                            ),
                          ),
                        ));
                      });

                  await Provider.of<FirestorProveder>(context, listen: false)
                      .deleteCategory(catgory);
                  Navigator.of(dialogContext).pop();
                  AppRouter.NavigateWithReplacemtnToWidget(Home_Scrren());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "delete",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ])),
      ]));
    });
  }
}
