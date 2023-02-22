import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../services/toast_service.dart';

class AddResult extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String? sem = '';
  String img = '';

  changeSem(value) {
    sem = value;
    print(sem);
    notifyListeners();
  }

  uploadToDatabase(branch,rollno,image,semester) {
    _firebaseFirestore
        .collection(branch)
        .doc(rollno)
        .collection(rollno)
        .doc(semester)
        .set({
      "img":image,
      "title":semester
    });
  }

  File? imageFile;

  //uplaod image
  uploadimage(rollno, context, image, sem) async {
    var imageUrl = '';
    try {
      Reference reference =
          await FirebaseStorage.instance.ref('papers').child(rollno + sem);
      UploadTask uploadTask = reference.putFile(File(image));
      TaskSnapshot snapshot = await uploadTask;
      if (snapshot.state == TaskState.success) {
        // print("success");
        Navigator.pop(context);
        showSuccessToast(
            message: "Nice! Your Image has been Selected Successfully",
            context: context);
      }
      imageUrl = await snapshot.ref.getDownloadURL();
      print(imageUrl);
    } catch (e) {
      imageUrl = '';
      print(e);
    }
    return imageUrl;
  }

//pick image
  var uplaodedImage = '';

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
