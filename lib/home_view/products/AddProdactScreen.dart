import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/widget/Bootm.dart';
import 'package:e_commers/widget/Dailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProdactScreen extends StatelessWidget {
  String catId;
  AddProdactScreen(this.catId);
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestorProveder>(builder: (context, provider, x) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 192, 214, 194),
              appBar: AppBar(
                title: const Text("add new Prodact"),
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
              body: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color.fromARGB(255, 191, 203, 212)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        provider.selectedImage == null
                            ? InkWell(
                                onTap: () {
                                  provider.selectIimg();
                                },
                                child: const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      "assets/logo/0df034d772936774c8e220749fc5c121.png"),
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(provider.selectedImage!)),
                        const SizedBox(height: 20),

                        TextFormField(
                          controller: provider.productNameConteoller,
                          decoration: const InputDecoration(
                              hintText: "Product Name",
                              labelText: "Product Name",
                              icon: Icon(Icons.inventory_2)),
                        ),

                        TextFormField(
                          controller: provider.productDescConteoller,
                          decoration: const InputDecoration(
                              hintText: "product description",
                              labelText: "product description",
                              icon: Icon(Icons.description)),
                        ),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: provider.productPriceConteoller,
                          decoration: const InputDecoration(
                              hintText: "Product Price",
                              labelText: "Product Price",
                              icon: Icon(Icons.price_change)),
                        ),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: provider.productQuantityConteoller,
                          decoration: const InputDecoration(
                              hintText: "Product Quantity",
                              labelText: "Product Quantity",
                              icon: Icon(Icons.production_quantity_limits)),
                        ),

                        ////////////////////////////////
                        const SizedBox(height: 20),
                        const SizedBox(height: 30),
                        DefultBigButton(
                            ontab: (() async {
                              if (provider.selectedImage == null) {
                                Dailog.showDailog(
                                  'Image Reqiured ,please select image for category',
                                );
                                return;
                              }

                              late BuildContext dialogContext;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  dialogContext = context;
                                  return Dialog(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
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
                                    ),
                                  );
                                },
                              );
                              await provider.addNewProduct(catId);
                              Navigator.of(dialogContext).pop();
                              Navigator.of(context).pop();
                            }),
                            txt: 'Add new Category')
                      ],
                    ),
                  ),
                ],
              )));
    });
  }
}
