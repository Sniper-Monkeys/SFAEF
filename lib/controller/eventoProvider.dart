import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/evento.dart';

class EventoProvider with ChangeNotifier {
  bool isloading = false;
  GlobalKey<FormState> form1Key = GlobalKey<FormState>();
  GlobalKey<FormState> form2Key = GlobalKey<FormState>();

  final Evento _responsable = Evento(
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
      documentos: [],
      guardadoEl: DateTime.now());
  Evento get responsable => _responsable;
  // controlador para agregar un nuevo evento formativo
  int index = 0;
  int get getIndex => index;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  // CURSO, TALLER, PROGRAMA ESPECIAL, DIPLOMADO
  List<DropdownMenuItem<Object>>? tiposEvento = const [
    DropdownMenuItem(
      value: 'CURSO',
      child: Text('CURSO'),
    ),
    DropdownMenuItem(
      value: 'TALLER',
      child: Text('TALLER'),
    ),
    DropdownMenuItem(
      value: 'PROGRAMA ESPECIAL',
      child: Text('PROGRAMA ESPECIAL'),
    ),
    DropdownMenuItem(
      value: 'DIPLOMADO',
      child: Text('DIPLOMADO'),
    ),
  ];

  // List of dropdown items 'PRESENCIAL', 'EN LINEA', 'MIXTA'
  List<DropdownMenuItem<Object>>? modalidadesEvento = const [
    DropdownMenuItem(
      value: 'PRESENCIAL',
      child: Text('PRESENCIAL'),
    ),
    DropdownMenuItem(
      value: 'EN LINEA',
      child: Text('EN LINEA'),
    ),
    DropdownMenuItem(
      value: 'MIXTA',
      child: Text('MIXTA'),
    ),
  ];

  Object tipoEvento = 'CURSO';
  Object modalidadEvento = 'PRESENCIAL';

  set setTipoEvento(Object? value) {
    if (value != null) {
      tipoEvento = value;
      notifyListeners();
    }
  }

  set setModalidadEvento(Object? value) {
    if (value != null) {
      modalidadEvento = value;
      notifyListeners();
    }
  }

  TextEditingController nombreEvento = TextEditingController();

  // Future<void> fetchResponsable(String id) async {
  //   await FirebaseFirestore.instance
  //       .collection('responsables')
  //       .doc(id)
  //       .get()
  //       .then((value) {
  //     _responsable = Evento.fromFirebase(value.data());
  //     notifyListeners();
  //   });
  //   return null;
  // }

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
          return false;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  Stream<List<Evento>> getEventosStream(String tipo) {
    return FirebaseFirestore.instance
        .collection('evento')
        .where('idUsuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('estatus', isEqualTo: tipo)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Evento.fromFirebase(e.data())).toList());
  }

  Future<List<Evento>> getEventos(String tipo) async {
    var data = await FirebaseFirestore.instance
        .collection('evento')
        .where('idUsuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('estatus', isEqualTo: tipo)
        .get()
        .then((value) {
      return value.docs.map((e) => Evento.fromFirebase(e.data())).toList();
    });

    return data;
  }

  Future<bool> addEvento() async {
    // generar un id aleatorio de 6 digitos

    String id = (100000 + Random().nextInt(900000)).toString();
    _responsable.idEvento = id;
    _responsable.idUsuario = FirebaseAuth.instance.currentUser!.uid;
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

  Future<Evento?> fetchEvento(String id) async {
    Evento? evento = await FirebaseFirestore.instance
        .collection('evento')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        return Evento.fromFirebase(value.data()!);
      } else {
        return null;
      }
    });
    return evento;
  }
}
