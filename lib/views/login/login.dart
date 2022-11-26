import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004990),
        title: const Text(
            'Sistema de Formulación y Aprobación de Eventos Formativos (SFAEF)',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w200)),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    margin: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  textAlign: TextAlign.start,
                                  "PROCESO DE SOLICITUD DE EVENTOS FORMATIVOS",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF004990)),
                                ),
                                //LINE ORANGE IN START
                                Container(
                                  width: 63,
                                  height: 3,
                                  color: Colors.orange,
                                ),
                              ],
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
                                        onPressed: () {},
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
                                        onPressed: () {},
                                        child: const Text(
                                          "Iniciar Sesión",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  Text(
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
                          children: [
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

  SizedBox header() {
    return SizedBox(
      height: 144,
      child: Stack(
        children: [
          Container(
            height: 144,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/headerlogo.png',
                ),
                opacity: 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container(
          //   height: 300,
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.70),
          //   ),
          // ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
