import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/eventoProvider.dart';
import 'package:sfaef/controller/responsableProvider.dart';

import '../../models/evento.dart';
import '../../models/responsable.dart';
import '../utils/utils.dart';
import 'eventoFormativoQR.dart';

class DetalleEvento extends StatefulWidget {
  final String id;
  const DetalleEvento({super.key, required this.id});

  @override
  State<DetalleEvento> createState() => _DetalleEventoState();
}

class _DetalleEventoState extends State<DetalleEvento> {
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
                      //assets/images/Unison-1.jpg is background image with 40% opacity and assets/images/logo.png is centered logo
                      header(),
                      detalleEvento(),
                      const SizedBox(
                        height: 20,
                      ),
                      const FootterSFAEF()
                    ]))));
  }

  Widget detalleEvento() {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return Consumer<ResponsableProvider>(
          builder: (context, responsableProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  child: FutureBuilder<Evento?>(
                      future: eventoProvider.fetchEvento(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("No se pudo cargar el evento"));
                        }
                        if (snapshot.data == null &&
                            snapshot.connectionState !=
                                ConnectionState.waiting) {
                          return const Center(
                              child: Text("No existe el evento"));
                        }
                        if (snapshot.data?.idEvento == widget.id) {
                          Evento evento = snapshot.data!;
                          return FutureBuilder<Responsable?>(
                              future: responsableProvider
                                  .fetchResponsable(evento.idUsuario),
                              builder: (context,
                                  AsyncSnapshot<Responsable?> snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return const Center(
                                      child: Text(
                                          "No se pudo cargar el responsable"));
                                }
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            TituloDecorado(
                                              titulo:
                                                  "${evento.tipo.text}: ${evento.nombre.text}",
                                              fontSize: 24,
                                            ),
                                            Text(evento.fechaFormateada,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF004990))),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      //container with F7F7F7 background and 16 border radius
                                      detalleEventoFormulario(evento),
                                    ],
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              });
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ))
          ],
        );
      });
    });
  }

  Widget detalleEventoFormulario(Evento evento) {
    return Consumer<ResponsableProvider>(
        builder: (context, responsableProvider, child) {
      return Container(
        width: 894,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (FirebaseAuth.instance.currentUser != null &&
                evento.idUsuario == FirebaseAuth.instance.currentUser!.uid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: codigoQRBoton(evento)),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  TituloDecorado(
                    titulo: "Tipo de evento formativo: ${evento.tipo.text}",
                    fontSize: 16,
                  ),
                  TituloDecorado(
                    titulo: "Modalidad: ${evento.modalidad.text}",
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Descripción",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.descripcion.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Definición de los objectivos:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.objetivos.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Contenido y Estructura del programa:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.contYEstructura.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TituloDecorado(
                        titulo: "Costo:",
                        fontSize: 16,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(evento.costo.text,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF004990))),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TituloDecorado(
                          titulo: "Duración:",
                          fontSize: 16,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text("${evento.duracion.text} HRS",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF004990))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TituloDecorado(
                        titulo: "Cupo:",
                        fontSize: 16,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text("${evento.costo.text} personas",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF004990))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Experiencias de aprendizaje:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.experiencias.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Estrategia de evaluación:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.evaluacion.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Referencias Teoricas Metodológicas:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.referencias.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Recursos y materiales didacticos de apoyo:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.materialApoyo.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Utilidad y oportunidad del programa:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.utilidad.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Requisitos de participación:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.reqParticipacion.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo:
                  "Requisitos de acreditación y entrega de constancia o diploma:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.reqAcreditacion.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Condiciones operativas del evento:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.condicionesOperativas.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            const SizedBox(
              height: 25,
            ),
            const TituloDecorado(
              titulo: "Autofinanciamiento o disponiblidad de recursos:",
              fontSize: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(evento.dispRecursos.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004990))),
            ),
            //centerer elevated button
            const SizedBox(
              height: 25,
            ),
            if (responsableProvider.responsable != null &&
                responsableProvider.responsable!.nombre.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TituloDecorado(
                      titulo: "Creado por:",
                      fontSize: 16,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 20,
                      children: [
                        Text(
                          responsableProvider.responsable!.nombre,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF004990)),
                        ),
                        Text(
                          responsableProvider.responsable!.correo,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF004990)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (FirebaseAuth.instance.currentUser == null ||
                FirebaseAuth.instance.currentUser!.uid != evento.idUsuario)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const FormularioEvento()));
                  },
                  child: const Text("CONTINUAR"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      );
    });
  }

  Container codigoQRBoton(Evento evento) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 70,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventoFormativoQR(
                          evento: evento,
                        )));
          },
          child: const Text('GENERAR UN CÓDIGO DE INVITACIÓN',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))),
    );
  }
}
