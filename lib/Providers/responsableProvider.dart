import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/responsable.dart';

class ResponsableProvider with ChangeNotifier{
  Responsable? _responsable;
  Responsable get responsable => _responsable!;


  Future<void> fetchResponsable(String id) async {
    await FirebaseFirestore.instance
        .collection('responsables')
        .doc(id)
        .get()
        .then((value) {
      _responsable = Responsable.fromFirebase(value.data());
      notifyListeners();
    });
    return null;
  }
}
