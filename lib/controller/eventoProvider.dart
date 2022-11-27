import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/evento.dart';

class EventoProvider with ChangeNotifier {
  Evento _responsable = Evento(
      idEvento: '',
      idUsuario: '',
      nombre: TextEditingController(),
      tipo: TextEditingController(),
      descripcion: TextEditingController(),
      objetivos: TextEditingController(),
      contYEstructura: TextEditingController(),
      costo: TextEditingController(),
      cupo: TextEditingController(),
      experiencias: TextEditingController(),
      duracion: TextEditingController(),
      evaluacion: TextEditingController(),
      referencias: TextEditingController(),
      materialApoyo: TextEditingController(),
      utilidad: TextEditingController(),
      reqParticipacion: TextEditingController(),
      reqAcreditacion: TextEditingController(),
      condicionesOperativas: TextEditingController(),
      dispRecursos: TextEditingController(),
      codigoInv: TextEditingController(),
      estatus: 'En Espera',
      modalidad: TextEditingController(),
      expInstructores: TextEditingController(),
      documentos: []);
  Evento get responsable => _responsable;
  // controlador para agregar un nuevo evento formativo
  int index = 0;
  int get getIndex => index;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  TextEditingController nombreEvento = TextEditingController();

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

  Future<bool> attachfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      if (fileBytes != null) {
        try {
          await FirebaseStorage.instance
              .ref('uploads/$fileName')
              .putData(fileBytes)
              .then((value) async {
            await value.ref.getDownloadURL().then((value) {
              responsable.documentos.add(value);
            });
          });
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  Future<bool> addEvento() async {
    // generar un id aleatorio de 6 digitos
    String id = (100000 + Random().nextInt(900000)).toString();
    // REVISAR SI EXISTE
    bool existe = await FirebaseFirestore.instance
        .collection('evento')
        .doc(id)
        .get()
        .then((value) => value.exists);
    if (!existe) {
      bool confirm = await FirebaseFirestore.instance
          .collection('evento')
          .doc(id)
          .set(_responsable.toMap())
          .then((value) => true)
          .onError((error, stackTrace) => false);
      return confirm;
    } else {
      return false;
    }
  }
}
