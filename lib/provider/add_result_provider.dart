import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../admin/screens/add_result.dart';
import '../services/toast_service.dart';

class AddResult extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String? sem = '';
  String img = '';
  FormGroup addDataForm = FormGroup({
    "rollno": FormControl(validators: [
      Validators.required,
      Validators.minLength(8),
      Validators.maxLength(8)
    ]),
    'semester': FormControl(validators: [
      Validators.required,
    ]),
    'img': FormControl(validators: [Validators.required]),
  });

  changeSem(value) {
    sem = value;
    print(sem);
    notifyListeners();
  }

  uploadToDatabase(branch, rollno, image, semester, context) {
    try {
      _firebaseFirestore
          .collection(branch)
          .doc(rollno)
          .collection(rollno)
          .doc(semester)
          .set({"img": image, "title": semester});
      addDataForm.control('rollno').reset();
      addDataForm.control('img').reset();
      showSuccessToast(message: "Success", context: context);
    } catch (e) {
      print(e);
    }
  }

  File? imageFile;
  bool imload = false;

  changeLoad(value) {
    imload = value;
    notifyListeners();
  }

  //uplaod image
  uploadimage(rollno, context, image, sem, branch) async {
    var imageUrl = '';
    changeLoad(true);
    // showLoaderDialog(context);
    try {
      Reference reference =
          await FirebaseStorage.instance.ref(branch).child(rollno + sem);
      UploadTask uploadTask = reference.putFile(File(image));
      TaskSnapshot snapshot = await uploadTask;
      if (snapshot.state == TaskState.success) {
        imageUrl = await snapshot.ref.getDownloadURL();
        await uploadToDatabase(branch, rollno, imageUrl, sem, context);

      }
    } catch (e) {
      imageUrl = '';
      showErrorToast(context: context, message: "Failed to upload");
      print(e);
    }
    changeLoad(false);
  }

//pick image
  var uplaodedImage = '';
File? file;
  getImage(context, source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        // changeImageLoading(true);
        print('img picked');
        file=File(pickedFile.path);
        uplaodedImage = (pickedFile.path);
        Navigator.pop(context);
        print(uplaodedImage);
      } else {
        uplaodedImage = '';
        showErrorToast(message: "Failed to pick image", context: context);
      }
    } catch (e) {
      uplaodedImage = '';
      print(e);
    } finally {
      notifyListeners();
      // changeImageLoading(false);
    }
    return uplaodedImage;
  }
}

final addProvider = ChangeNotifierProvider((ref) {
  return AddResult();
});
