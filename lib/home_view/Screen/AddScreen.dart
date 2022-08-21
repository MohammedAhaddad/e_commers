import 'package:e_commers/Provider/FirestorProveder.dart';
import 'package:e_commers/widget/Bootm.dart';
import 'package:e_commers/widget/Dailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Screen"),
      ),
      body: Consumer<FirestorProveder>(builder: (context, provider, x) {
        return Container(
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
                      backgroundImage: FileImage(provider.selectedImage!)),
              const SizedBox(height: 20),
              TextFormField(
                controller: provider.categoryNameConteoller,
                decoration: const InputDecoration(
                    hintText: "Catogory Name",
                    labelText: "Catogory Name",
                    icon: Icon(Icons.add_business)),
              ),
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
                          ),
                        );
                      },
                    );
                    await provider.addNewCategory();
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop();
                  }),
                  txt: 'Add new Category')
            ],
          ),
        );
      }),
    );
  }
}
