import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sfaef/views/dashboard/dashboardResponsable.dart';

import '../utils/utils.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              //assets/images/Unison-1.jpg is background image with 40% opacity and assets/images/logo.png is centered logo
              header(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 600,
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tituloDecorado(
                              titulo:
                                  "PROCESO DE SOLICITUD DE EVENTOS FORMATIVOS",
                            ),
                            //container with F7F7F7 background color
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 894,
                              height: 432,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                //circular border
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 109,
                                    width: 692,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                            backgroundColor:
                                                const Color(0xFFF7A11A),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            )),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("responsable")
                                              .doc("219219494")
                                              .get()
                                              .then((value) {
                                            if (value.data() != null) {
                                              print(value.data());
                                            } else{
                                              print("No existe");
                                            }
                                          });
                                        },
                                        child: const Text(
                                          "Solicitar Evento Formativo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 109,
                                    width: 692,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                            backgroundColor:
                                                const Color(0xFFF7A11A),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            )),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DashboardResponsable()));
                                        },
                                        child: const Text(
                                          "Iniciar Sesión",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  const Text(
                                    '* En caso de contar con un evento formativo aprobado previamente por el SFAEF favor de iniciar sesión',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004990)),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF004990),
                    height: 150,
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('2022 |',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text(' Consejo Divisional |',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text(' Secretaría General Académica |',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text(' Universidad de Sonora |',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ]),
                    ),
                  ),
                ],
              )

              //footer every in the bottom
            ],
          ),
        ),
      ),
    );
  }
}
