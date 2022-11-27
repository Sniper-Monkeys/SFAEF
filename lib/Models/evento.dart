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

  factory Evento.fromFirebase(dynamic map) => Evento(
        idEvento: map['idEvento'],
        idUsuario: map['idUsuario'],
        nombre: map['nombre'],
        tipo: map['tipo'],
        descripcion: map['descripcion'],
        objetivos: map['objetivos'],
        contYEstructura: map['contYEstructura'],
        costo: map['costo'],
        cupo: map['cupo'],
        experiencias: map['experiencias'],
        duracion: map['duracion'],
        evaluacion: map['evalaucion'],
        referencias: map['referencias'],
        materialApoyo: map['materialApoyo'],
        utilidad: map['utilidad'],
        reqParticipacion: map['reqParticipacion'],
        reqAcreditacion: map['reqAcreditacion'],
        condicionesOperativas: map['condicionesOperativas'],
        dispRecursos: map['dispRecursos'],
        codigoInv: map['codigoInv'],
        estatus: map['estatus'],
        modalidad: map['modalidad'],
        expInstructores: map['expInstructores'],
        documentos: List<String>.from(map['documentos']),
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
      };
}
