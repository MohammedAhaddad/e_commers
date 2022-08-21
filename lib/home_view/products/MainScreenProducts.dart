import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/home_view/products/AddProdactScreen.dart';
import 'package:e_commers/home_view/products/ViewAllProdact.dart';
import 'package:e_commers/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreenProducts extends StatelessWidget {
  String catId;
  MainScreenProducts(this.catId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 192, 214, 194),
            appBar: AppBar(
              title: const Text("Prodact"),
              backgroundColor: const Color.fromARGB(255, 200, 208, 214),
              actions: [
                IconButton(
                    onPressed: () {
                      Provider.of<Auth_Provider>(context, listen: false)
                          .signlnOut();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            body: Consumer<FirestorProveder>(builder: (context, provider, x) {
              return provider.listproducts == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      child: ListView.builder(
                          itemCount: provider.listproducts.length,
                          itemBuilder: (context, index) {
                            return ViewAllProdact(
                              provider.listproducts[index],
                              catId,
                            );
                          }),
                    );
            }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 140, 235, 143),
              onPressed: () {
                AppRouter.NavigateToWidget(AddProdactScreen(catId));
              },
              child: const Icon(Icons.add, color: Colors.white, size: 35),
            )));
  }
}
