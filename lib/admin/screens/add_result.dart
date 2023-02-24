import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:resultproject/services/toast_service.dart';
import 'package:resultproject/widgets/large_button.dart';

import '../../config/config.dart';
import '../../provider/add_result_provider.dart';
import '../../widgets/text_field_button.dart';

class AddResultScreen extends ConsumerWidget {
  String branch;

  AddResultScreen({Key? key, required this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresprovider = ref.watch(addProvider);
    return Scaffold(
      appBar: AppBar(title: Text(branch)),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: addresprovider.addDataForm,
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
                            i.toString().isNotEmpty
                                ? addresprovider.addDataForm
                                    .control('img')
                                    .value = i
                                : '';
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            var i = await addresprovider.getImage(
                                context, ImageSource.camera);
                            i.toString().isNotEmpty
                                ? addresprovider.addDataForm
                                    .control('img')
                                    .value = i
                                : '';
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
              child: addresprovider.addDataForm.control('img').isNotNull
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      height: 200.0,
                      child: Image.file(addresprovider.file!))
                  : Center(
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
                        child: const Center(child: Text("Choose Image")),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReactiveTextField(
                  formControlName: "rollno",
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                      labelText: "Enter Roll number",
                      border: OutlineInputBorder()
                      // hintText: "whatever you want",
                      ),
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        "Roll no can't be Empty",
                    ValidationMessage.minLength: (error) =>
                        "Roll no is not correct",
                    ValidationMessage.maxLength: (error) =>
                        "Roll no is not correct"
                  }),
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
                  addresprovider.addDataForm.control('semester').value =
                      newValue;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: addresprovider.imload
                  ? const Center(child: CircularProgressIndicator())
                  : Button(
                      buttoncolor: Colors.black,
                      title: "Save",
                      titlecolor: Colors.white,
                      onTap: () {
                        if (addresprovider.addDataForm.valid) {
                          print('valid');
                          addresprovider.uploadimage(
                              addresprovider.addDataForm
                                  .control('rollno')
                                  .value,
                              context,
                              addresprovider.addDataForm.control('img').value,
                              addresprovider.addDataForm
                                  .control('semester')
                                  .value,
                              branch);
                        } else {
                          showErrorToast(
                              context: context,
                              message: "Fill the detail first");
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
  "SEMESTER I",
  "SEMESTER II",
  "SEMESTER III",
  "SEMESTER IV",
  "SEMESTER V",
  "SEMESTER VI",
  "SEMESTER VII",
  "SEMESTER VIII",
];

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Row(
      children: [
        const CircularProgressIndicator(color: Colors.black),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text(
              "uploading...",
              style: TextStyle(color: Colors.black),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}
