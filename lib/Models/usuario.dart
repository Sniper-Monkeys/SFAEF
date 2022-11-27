class Usuario {
  String idUsuario;
  String correo;
  String tipo;

  Usuario({
    required this.idUsuario,
    required this.correo,
    required this.tipo,
  });

  // Getters
  String get getIdUsuario => idUsuario;
  String get getCorreo => correo;
  String get getTipo => tipo;

  factory Usuario.fromFirebase(dynamic map) => Usuario(
        idUsuario: map['idUsuario'],
        correo: map['correo'],
        tipo: map['tipo'],
      );

  Map<String, dynamic> toMap() => {
        'idUsuario': idUsuario,
        'correo': correo,
        'tipo': tipo,
      };
}
