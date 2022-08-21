import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/home_view/Home_Scrren.dart';
import 'package:e_commers/home_view/products/MainScreenProducts.dart';
import 'package:e_commers/home_view/products/UpdateProdact.dart';
import 'package:e_commers/moodels/Prodact.dart';
import 'package:e_commers/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllProdact extends StatelessWidget {
  Prodact prodact;
  String catId;
  ViewAllProdact(this.prodact, this.catId);
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestorProveder>(builder: (context, provider, child) {
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
                    AppRouter.NavigateToWidget(MainScreenProducts(catId));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: prodact.imag,
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
                  AppRouter.NavigateToWidget(MainScreenProducts(catId));
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
                      prodact.name,
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
                      .productNameConteoller
                      .text = prodact.name;

                  Provider.of<FirestorProveder>(context, listen: false)
                      .productDescConteoller
                      .text = prodact.description;

                  Provider.of<FirestorProveder>(context, listen: false)
                      .productPriceConteoller
                      .text = prodact.price.toString();

                  Provider.of<FirestorProveder>(context, listen: false)
                      .productQuantityConteoller
                      .text = prodact.quantity.toString();

                  AppRouter.NavigateToWidget(
                      UpdateProdactScreen(catId, prodact));
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
                      .deleteProduct(prodact, catId);
                  Provider.of<FirestorProveder>(context, listen: false)
                      .listproducts
                      .remove(catId);
                  Navigator.of(dialogContext).pop();
                  AppRouter.NavigateWithReplacemtnToWidget(
                      MainScreenProducts(catId));
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
