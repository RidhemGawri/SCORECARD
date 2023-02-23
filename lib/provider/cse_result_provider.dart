import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/sem_model.dart';

class ResultService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List semester = [];
  bool semloading = false;

  changesem(value) {
    semloading = value;
    notifyListeners();
  }

  getSemData(rollno, branch) async {
    changesem(true);
    try {
      var ref = await _firebaseFirestore
          .collection(branch)
          .doc(rollno)
          .collection(rollno)
          .orderBy("title", descending: false)
          .get();
      semester = ref.docs.map((e) => SemItem.fromJson(e.data())).toList();
      print(semester);
      changesem(false);
    } catch (e) {
      semester = [];
      changesem(false);
    }
  }



}

final resultProvider = ChangeNotifierProvider(
  (ref) {
    return ResultService();
  },
);
