import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/evento.dart';
import '../utils/utils.dart';

class EventoFormativoQR extends StatelessWidget {
  final Evento evento;
  const EventoFormativoQR({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String data = "https://sfaef-44a5c.web.app/#/eventos?id=${evento.idEvento}";
    return Scaffold(
        appBar: appBarTitle(),
        body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //assets/images/Unison-1.jpg is background image with 40% opacity and assets/images/logo.png is centered logo
                      header(),

                      viewQR(data),
                      const SizedBox(
                        height: 60,
                      ),
                      const FootterSFAEF(),
                    ]))));
  }

  Column viewQR(String data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TituloDecorado(
                      titulo: "Invitación al evento activo",
                      fontSize: 24,
                    ),
                    const SizedBox(height: 20),
                    Container(
                        width: 894,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                                "Comparte este código QR o el enlace que aparece a continuación",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF004990))),
                            const SizedBox(
                              height: 20,
                            ),

                            // Container orange with QR code
                            qrContainer(data),

                            // Container with link
                            Container(
                              width: 894,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Enlace para acceder al evento",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF004990))),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SelectableText(
                                    "https://sfaef-44a5c.web.app/#/eventos?id=${evento.idEvento}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ]),
            ))
      ],
    );
  }

  Container qrContainer(String data) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: QrImage(
                  data: data,
                  version: 3,
                  size: 600,
                  foregroundColor: const Color.fromARGB(255, 0, 55, 110),
                  gapless: false,
                  errorStateBuilder: (cxt, err) {
                    return const Center(
                      child: Text(
                        "Error al generar el código",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            evento.nombre.text,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
