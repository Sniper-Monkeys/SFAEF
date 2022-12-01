import './usuario.dart';
import './evento.dart';

class Responsable extends Usuario {
  String nombre;
  String idInstitucional;
  List<Evento> eventos;

  Responsable({
    required this.nombre,
    required this.idInstitucional,
    required this.eventos,
    required String idUsuario,
    required String correo,
    required String tipo,
  }) : super(idUsuario: idUsuario, correo: correo, tipo: tipo);

  // Getters
  String get getNombre => nombre;
  String get getIdInstitucional => idInstitucional;
  List<Evento> get getListaEventos => eventos;
  Evento getEvento(String idEvento) =>
      eventos.firstWhere((element) => element.idEvento == idEvento);

  solicitarEvento(Evento evento) {
    evento.estatus = "Activo";
    eventos.add(evento);
  }

  factory Responsable.fromFirebase(dynamic map) => Responsable(
        nombre: map['nombre'],
        idInstitucional: map['idInstitucional'],
        eventos: [],
        idUsuario: map['idUsuario'],
        correo: map['correo'],
        tipo: map['tipo'],
      );

  @override
  Map<String, dynamic> toMap() => {
        'nombre': nombre,
        'idInstitucional': idInstitucional,
        'eventos': eventos,
        'idUsuario': idUsuario,
        'correo': correo,
        'tipo': tipo,
      };
}
