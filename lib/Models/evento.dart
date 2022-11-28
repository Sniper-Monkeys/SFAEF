import 'package:flutter/material.dart';

class Evento {
  String idEvento;
  String idUsuario;
  //NOMBRE DEL EVENTO
  TextEditingController nombre;
  // MODALIDAD
  TextEditingController modalidad;
  //
  TextEditingController descripcion;
  // DEFINICIÓN DE LOS OBJECTIVOS
  TextEditingController objetivos;
  TextEditingController costo;
  TextEditingController tipo;
  // CONTENIDO Y ESTRUCTURA DEL PROGRAMA
  TextEditingController contYEstructura;
  TextEditingController cupo;
  TextEditingController duracion;
  //EXPERIENCIAS DE APRENDIZAJE
  TextEditingController experiencias;
  TextEditingController evaluacion;
  TextEditingController referencias;
  TextEditingController materialApoyo;
  TextEditingController utilidad;
  TextEditingController reqParticipacion;
  TextEditingController reqAcreditacion;
  TextEditingController condicionesOperativas;
  TextEditingController dispRecursos;
  TextEditingController codigoInv;
  String estatus;
  TextEditingController expInstructores;
  List<String> documentos;
  DateTime guardadoEl;

  Evento({
    required this.idEvento,
    required this.idUsuario,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.objetivos,
    required this.contYEstructura,
    required this.costo,
    required this.cupo,
    required this.experiencias,
    required this.duracion,
    required this.evaluacion,
    required this.referencias,
    required this.materialApoyo,
    required this.utilidad,
    required this.reqParticipacion,
    required this.reqAcreditacion,
    required this.condicionesOperativas,
    required this.dispRecursos,
    required this.codigoInv,
    required this.estatus,
    required this.modalidad,
    required this.expInstructores,
    required this.documentos,
    required this.guardadoEl,
  });

  // Getters
  String get getIdEvento => idEvento;
  String get getIdUsuario => idUsuario;
  TextEditingController get getNombre => nombre;
  TextEditingController get getTipo => tipo;
  TextEditingController get getDescripcion => descripcion;
  TextEditingController get getObjetivos => objetivos;
  TextEditingController get getContYEstructura => contYEstructura;
  TextEditingController get getCosto => costo;
  TextEditingController get getCupo => cupo;
  TextEditingController get getExperiencias => experiencias;
  TextEditingController get getDuracion => duracion;
  TextEditingController get getEvalaucion => evaluacion;
  TextEditingController get getReferencias => referencias;
  TextEditingController get getMaterialApoyo => materialApoyo;
  TextEditingController get getUtilidad => utilidad;
  TextEditingController get getReqParticipacion => reqParticipacion;
  TextEditingController get getReqAcreditacion => reqAcreditacion;
  TextEditingController get getCondicionesOperativas => condicionesOperativas;
  TextEditingController get getDispRecursos => dispRecursos;
  TextEditingController get getCodigoInv => codigoInv;
  String get getEstatus => estatus;
  TextEditingController get getModalidad => modalidad;
  TextEditingController get getExpInstructores => expInstructores;
  List<String> get getDocumentos => documentos;
  DateTime get getGuardadoEl => guardadoEl;

  factory Evento.fromFirebase(dynamic map) => Evento(
        idEvento: map['idEvento'],
        idUsuario: map['idUsuario'],
        nombre: TextEditingController(text: map['nombre']),
        tipo: TextEditingController(text: map['tipo']),
        descripcion: TextEditingController(text: map['descripcion']),
        objetivos: TextEditingController(text: map['objetivos']),
        contYEstructura: TextEditingController(text: map['contYEstructura']),
        costo: TextEditingController(text: map['costo']),
        cupo: TextEditingController(text: map['cupo']),
        experiencias: TextEditingController(text: map['experiencias']),
        duracion: TextEditingController(text: map['duracion']),
        evaluacion: TextEditingController(text: map['evaluacion']),
        referencias: TextEditingController(text: map['referencias']),
        materialApoyo: TextEditingController(text: map['materialApoyo']),
        utilidad: TextEditingController(text: map['utilidad']),
        reqParticipacion: TextEditingController(text: map['reqParticipacion']),
        reqAcreditacion: TextEditingController(text: map['reqAcreditacion']),
        condicionesOperativas:
            TextEditingController(text: map['condicionesOperativas']),
        dispRecursos: TextEditingController(text: map['dispRecursos']),
        codigoInv: TextEditingController(text: map['codigoInv']),
        estatus: map['estatus'],
        modalidad: TextEditingController(text: map['modalidad']),
        expInstructores: TextEditingController(text: map['expInstructores']),
        documentos: List<String>.from(map['documentos']),
        guardadoEl: DateTime.parse(map['guardadoEl']),
      );

  Map<String, dynamic> toMap() => {
        'idEvento': idEvento,
        'idUsuario': idUsuario,
        'nombre': nombre.text,
        'tipo': tipo.text,
        'descripcion': descripcion.text,
        'objetivos': objetivos.text,
        'contYEstructura': contYEstructura.text,
        'costo': costo.text,
        'cupo': cupo.text,
        'experiencias': experiencias.text,
        'duracion': duracion.text,
        'evalaucion': evaluacion.text,
        'referencias': referencias.text,
        'materialApoyo': materialApoyo.text,
        'utilidad': utilidad.text,
        'reqParticipacion': reqParticipacion.text,
        'reqAcreditacion': reqAcreditacion.text,
        'condicionesOperativas': condicionesOperativas.text,
        'dispRecursos': dispRecursos.text,
        'codigoInv': codigoInv.text,
        'estatus': estatus,
        'modalidad': modalidad.text,
        'expInstructores': expInstructores.text,
        'documentos': documentos,
        'guardadoEl': guardadoEl.toIso8601String(),
      };

  String get fechaFormateada =>
      "${guardadoEl.day}/${guardadoEl.month}/${guardadoEl.year}";
}
