import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resultproject/services/toast_service.dart';
import 'package:resultproject/widgets/large_button.dart';

import '../../config/config.dart';
import '../../provider/add_result_provider.dart';
import '../../widgets/text_field_button.dart';

class AddResultScreen extends ConsumerWidget {
  String branch;

  AddResultScreen({Key? key, required this.branch}) : super(key: key);

  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresprovider = ref.watch(addProvider);
    return Scaffold(
      appBar: AppBar(title: Text(branch)),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 170.0,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1.0, 1.0),
                                color: Colors.black,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(children: [
                        GestureDetector(
                          child: Card(
                            child: ListTile(
                              title: const Text(" Pick Image From Gallery",
                                  style: TextStyle(color: Colors.black)),
                              tileColor: Colors.white,
                              leading: Icon(
                                Icons.browse_gallery,
                                color: AppConfig.primaryColor,
                              ),
                            ),
                          ),
                          onTap: () async {
                            var i = await addresprovider.getImage(
                                context, ImageSource.gallery);
                            // showLoaderDialog(context);
                            // i.toString().isEmpty
                            //     ? ''
                            //     : authprovider.updateProfile
                            //     .control('img')
                            //     .value =
                            // await authprovider.uploadimage(
                            //     authprovider.updateProfile
                            //         .control('email')
                            //         .value,
                            //     context,
                            //     i);
                            // Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            var i = await addresprovider.getImage(
                                context, ImageSource.camera);
                            // showLoaderDialog(context);
                            // i.toString().isEmpty
                            //     ? ''
                            //     : authprovider.updateProfile
                            //     .control('img')
                            //     .value =
                            // await authprovider.uploadimage(
                            //     authprovider.updateProfile
                            //         .control('email')
                            //         .value,
                            //     context,
                            //     i);
                            // Navigator.pop(context);
                          },
                          child: Card(
                            child: ListTile(
                              title: const Text(" Pick Image From Camera",
                                  style: TextStyle(color: Colors.black)),
                              tileColor: Colors.white,
                              leading: Icon(Icons.camera,
                                  color: AppConfig.primaryColor),
                            ),
                          ),
                        ),
                      ]),
                    );
                  },
                );
              },
              child: Center(
                child: Container(
                  height: 150.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: -2.0, //extend the shadow
                      )
                    ],
                  ),
                  child:  Center(
                      child: addresprovider.uplaodedImage.isEmpty ? const Text("Choose Image") :const Text("Image Selected Successfully")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "roll number can't be empty";
                    } else if (value.length != 8) {
                      return 'Roll number is not correct';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Enter Roll number",
                      border: OutlineInputBorder()
                      // hintText: "whatever you want",
                      )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                elevation: 5,
                value: allSem[0],
                hint: const Text('Select Item',
                    style: TextStyle(color: Colors.grey)),
                icon:
                    const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: allSem.map((items) {
                  return DropdownMenuItem<String>(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  addresprovider.changeSem(newValue);
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Button(
                  buttoncolor: Colors.black,
                  title: "Save",
                  titlecolor: Colors.white,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      print('valid');
                      print(controller.text);
                      print(addresprovider.sem);
                      print(addresprovider.uplaodedImage);
                    } else {
                      showErrorToast(message: "Fill the form first",context: context);
                    }
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

List allSem = [
  "SEM I",
  "SEM II",
  "SEM III",
  "SEM IV",
  "SEM V",
  "SEM VI",
  "SEM VII",
  "SEM VIII",
];
