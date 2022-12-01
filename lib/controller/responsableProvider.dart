import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/responsable.dart';

class ResponsableProvider with ChangeNotifier {
  Responsable? _responsable;
  Responsable? get responsable => _responsable;

  Future<Responsable?> fetchResponsable(String id) async {
    if (_responsable != null) {
      return _responsable;
    }
    Responsable? responsable = await FirebaseFirestore.instance
        .collection('responsable')
        .where('uid', isEqualTo: id)
        .get()
        .then((value) {
      if (value.docs.first.exists) {
        return Responsable.fromFirebase(value.docs.first.data());
      } else {
        return null;
      }
    });
    if (responsable != null) {
      _responsable = responsable;
      notifyListeners();
    }
    return responsable;
  }
}
