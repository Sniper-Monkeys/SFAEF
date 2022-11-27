import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/utils.dart';

class DashboardResponsable extends StatefulWidget {
  const DashboardResponsable({super.key});

  @override
  State<DashboardResponsable> createState() => _DashboardResponsableState();
}

class _DashboardResponsableState extends State<DashboardResponsable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tituloDecorado(
                                  titulo: "Administrar Eventos",
                                ),
                                botonNuevoEventoFormativo(context),
                              ],
                            ),
                            const SizedBox(
                                height: 500,
                                child: EventsList(
                                  tipoEvento: TipoEvento.EventoActivo,
                                )),
                            const SizedBox(
                                height: 500,
                                child: EventsList(
                                  tipoEvento: TipoEvento.EventoPasado,
                                )),
                            const SizedBox(
                                height: 500,
                                child: EventsList(
                                  tipoEvento: TipoEvento.EventoRechazado,
                                )),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox botonNuevoEventoFormativo(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 54,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF7A11A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            nuevoEventoFormativo(context);
          },
          child: const Text(
            "Solicitar Evento Formativo",
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
    );
  }

  Future<dynamic> nuevoEventoFormativo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Column(
              children: [
                Container(
                  color: const Color(0xFF004990),
                  child: const Text(
                    "Sistema de Formulación y Aprobación de Eventos Formativos (SFAEF)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(height: 150, child: header())
              ],
            ),
            content: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              width: 500,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  tituloDecorado(
                    titulo: "PROCESO DE SOLICITUD DE EVENTOS FORMATIVOS",
                    fontSize: 16,
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    color: const Color(0xFFF7F7F7),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tituloDecorado(
                            titulo: "DATOS DEL EVENTO FORMATIVO",
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "NOMBRE DEL EVENTO",
                                          // border bottom orang
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "TIPO DE EVENTO",
                                          // border bottom orang
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "MODALIDAD",
                                          // border bottom orang
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        minLines: 5,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "DESCRIPCIÓN",
                                          // border bottom orang
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        minLines: 5,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,

                                          labelText:
                                              "DEFINICIÓN DE LOS OBJECTIVOS",
                                          // border bottom orang

                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Si")),
            ],
          );
        });
  }
}

enum TipoEvento { EventoActivo, EventoPasado, EventoRechazado }

class EventsList extends StatelessWidget {
  final TipoEvento tipoEvento;
  const EventsList({
    Key? key,
    required this.tipoEvento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
        width: 1400,
        height: 500,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tipoEvento == TipoEvento.EventoActivo
                        ? "Eventos Activos"
                        : tipoEvento == TipoEvento.EventoPasado
                            ? "Eventos Pasados"
                            : "Eventos Rechazados",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF004990)),
                  ),
                  Container(
                    width: 63,
                    height: 3,
                    color: tipoEvento == TipoEvento.EventoRechazado
                        ? const Color(0xFFAA1804)
                        : Colors.orange,
                  ),
                ],
              ),
              const Text(
                '1',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF004990)),
              ),
            ],
          ),
          // list view of 5 EventoActivo()
          SizedBox(
            height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Evento(
                  tipoEvento: tipoEvento,
                );
              },
              itemCount: 5,
            ),
          ),
        ]),
      ),
    );
  }
}

class Evento extends StatelessWidget {
  final TipoEvento tipoEvento;
  const Evento({
    required this.tipoEvento,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          // bottom shadow
          BoxShadow(
            color: Color.fromARGB(29, 0, 0, 0),
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 28.0,
            color: tipoEvento == TipoEvento.EventoRechazado
                ? const Color(0xFFAA1804)
                : Colors.orange,
          ),
        ),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
              child: Text(
                "Evento: Fotografía periodistica. Otro enfoque...",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF004990)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, top: 8, bottom: 8),
              child: Text(
                "07/08/2022",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF004990)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
              child: Text(
                "Taller",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF004990)),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
