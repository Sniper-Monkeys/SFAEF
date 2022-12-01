import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/eventoProvider.dart';
import '../../models/evento.dart';
import '../eventoFormativo/detalleEvento.dart';
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
      appBar: appBarTitle(context),
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
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const TituloDecorado(
                          titulo: "Administrar Eventos",
                        ),
                        botonNuevoEventoFormativo(context),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 700,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoActivo,
                      )),
                  const SizedBox(
                      height: 700,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoEnEspera,
                      )),
                  const SizedBox(
                      height: 700,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoPasado,
                      )),
                  const SizedBox(
                      height: 700,
                      child: EventsList(
                        tipoEvento: TipoEvento.eventoRechazado,
                      )),
                ],
              ),
            )),
      ],
    );
  }

  Container botonNuevoEventoFormativo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16),
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

enum TipoEvento { eventoActivo, eventoPasado, eventoRechazado, eventoEnEspera }

class EventsList extends StatelessWidget {
  final TipoEvento tipoEvento;
  const EventsList({
    Key? key,
    required this.tipoEvento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return StreamBuilder(
          stream:
              eventoProvider.getEventosStream(tipoEvento == TipoEvento.eventoActivo
                  ? 'Activo'
                  : tipoEvento == TipoEvento.eventoPasado
                      ? 'Pasado'
                      : tipoEvento == TipoEvento.eventoRechazado
                          ? 'Rechazado'
                          : 'En Espera'),
          builder: (context, AsyncSnapshot<List<Evento>> snapshot) {
            if (snapshot.hasError) {
              // print(snapshot.error);
              return const Text('Algo salio mal');
            }
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                width: 1400,
                height: 700,
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
                                    : tipoEvento == TipoEvento.eventoRechazado
                                        ? "Eventos Rechazados"
                                        : "Eventos en Espera",
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
                      Text(
                        snapshot.data!.length.toString(),
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF004990)),
                      ),
                    ],
                  ),
                  // list view of 5 EventoActivo()
                  SizedBox(
                      height: 600,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return EventoItem(
                            tipoEvento: tipoEvento,
                            evento: snapshot.data![index],
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ))
                ]),
              );
            }
            return const Center(child: CircularProgressIndicator());
          });
    });
  }
}

class EventoItem extends StatelessWidget {
  final TipoEvento tipoEvento;
  final Evento evento;
  const EventoItem({
    required this.tipoEvento,
    required this.evento,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalleEvento(id: evento.idEvento),
          ),
        );
      },
      child: Container(
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
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                child: Text(
                  evento.nombre.text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF004990)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
                child: Text(
                  // format date guardadoEl,
                  evento.fechaFormateada,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF004990)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                child: Text(
                  evento.tipo.text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF004990)),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
