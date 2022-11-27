class Evento {
  String idEvento;
  String idUsuario;
  String nombre;
  String tipo;
  String descripcion;
  String objetivos;
  String contYEstructura;
  double costo;
  int cupo;
  String experiencias;
  double duracion;
  String evalaucion;
  String referencias;
  String materialApoyo;
  String utilidad;
  String reqParticipacion;
  String reqAcreditacion;
  String condicionesOperativas;
  String dispRecursos;
  String codigoInv;
  String estatus;
  
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
    required this.evalaucion,
    required this.referencias,
    required this.materialApoyo,
    required this.utilidad,
    required this.reqParticipacion,
    required this.reqAcreditacion,
    required this.condicionesOperativas,
    required this.dispRecursos,
    required this.codigoInv,
    required this.estatus,
  });

  // Getters
  String get getIdEvento => idEvento;
  String get getIdUsuario => idUsuario;
  String get getNombre => nombre;
  String get getTipo => tipo;
  String get getDescripcion => descripcion;
  String get getObjetivos => objetivos;
  String get getContYEstructura => contYEstructura;
  double get getCosto => costo;
  int get getCupo => cupo;
  String get getExperiencias => experiencias;
  double get getDuracion => duracion;
  String get getEvalaucion => evalaucion;
  String get getReferencias => referencias;
  String get getMaterialApoyo => materialApoyo;
  String get getUtilidad => utilidad;
  String get getReqParticipacion => reqParticipacion;
  String get getReqAcreditacion => reqAcreditacion;
  String get getCondicionesOperativas => condicionesOperativas;
  String get getDispRecursos => dispRecursos;
  String get getCodigoInv => codigoInv;
  String get getEstatus => estatus;

  factory Evento.fromFirebase(dynamic map) => Evento(
        idEvento: map['idEvento'],
        idUsuario: map['idUsuario'],
        nombre: map['nombre'],
        tipo: map['tipo'],
        descripcion: map['descripcion'],
        objetivos: map['objetivos'],
        contYEstructura: map['contYEstructura'],
        costo: double.parse(map['costo']),
        cupo: int.parse(map['cupo']),
        experiencias: map['experiencias'],
        duracion: double.parse(map['duracion']),
        evalaucion: map['evalaucion'],
        referencias: map['referencias'],
        materialApoyo: map['materialApoyo'],
        utilidad: map['utilidad'],
        reqParticipacion: map['reqParticipacion'],
        reqAcreditacion: map['reqAcreditacion'],
        condicionesOperativas: map['condicionesOperativas'],
        dispRecursos: map['dispRecursos'],
        codigoInv: map['codigoInv'],
        estatus: map['estatus'],
      );

  Map<String, dynamic> toMap() => {
        'idEvento': idEvento,
        'idUsuario': idUsuario,
        'nombre': nombre,
        'tipo': tipo,
        'descripcion': descripcion,
        'objetivos': objetivos,
        'contYEstructura': contYEstructura,
        'costo': costo,
        'cupo': cupo,
        'experiencias': experiencias,
        'duracion': duracion,
        'evalaucion': evalaucion,
        'referencias': referencias,
        'materialApoyo': materialApoyo,
        'utilidad': utilidad,
        'reqParticipacion': reqParticipacion,
        'reqAcreditacion': reqAcreditacion,
        'condicionesOperativas': condicionesOperativas,
        'dispRecursos': dispRecursos,
        'codigoInv': codigoInv,
        'estatus': estatus,
        };
}
