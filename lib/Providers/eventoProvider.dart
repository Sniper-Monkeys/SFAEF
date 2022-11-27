import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/evento.dart';

class ResponsableProvider with ChangeNotifier {
  Evento? _responsable;
  Evento get responsable => _responsable!;

  Future<void> fetchResponsable(String id) async {
    await FirebaseFirestore.instance
        .collection('responsables')
        .doc(id)
        .get()
        .then((value) {
      _responsable = Evento.fromFirebase(value.data());
      notifyListeners();
    });
    return null;
  }
}
