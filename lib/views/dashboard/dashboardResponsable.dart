import 'package:flutter/material.dart';
import '../eventoFormativo/eventoFormativoForm.dart';
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
              listaEventosView(context),
            ],
          ),
        ),
      ),
    );
  }

  Column listaEventosView(BuildContext context) {
    return Column(
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
                      const TituloDecorado(
                        titulo: "Administrar Eventos",
                      ),
                      botonNuevoEventoFormativo(context),
                    ],
                  ),
                  const SizedBox(
                      height: 500,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoActivo,
                      )),
                  const SizedBox(
                      height: 500,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoPasado,
                      )),
                  const SizedBox(
                      height: 500,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoRechazado,
                      )),
                ],
              ),
            )),
      ],
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NuevoEventoFormativo(),
              ),
            );
          },
          child: const Text(
            "Solicitar Evento Formativo",
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
    );
  }
}

enum TipoEvento { eventoActivo, eventoPasado, eventoRechazado }

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
                    tipoEvento == TipoEvento.eventoActivo
                        ? "Eventos Activos"
                        : tipoEvento == TipoEvento.eventoPasado
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
                    color: tipoEvento == TipoEvento.eventoRechazado
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
            color: tipoEvento == TipoEvento.eventoRechazado
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
