import 'package:flutter/material.dart';

AppBar appBarTitle() {
  return AppBar(
    backgroundColor: const Color(0xFF004990),
    title: const Text(
        'Sistema de Formulación y Aprobación de Eventos Formativos (SFAEF)',
        style: TextStyle(
            color: Colors.white, fontSize: 28, fontWeight: FontWeight.w200)),
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

class TituloDecorado extends StatelessWidget {
  final String titulo;
  final double fontSize;
  const TituloDecorado(
    {
    required this.titulo,
    this.fontSize = 24,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          titulo,
          style:  TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color:const Color(0xFF004990)),
        ),
        //LINE ORANGE IN START
        Container(
          width: 63,
          height: 3,
          color: Colors.orange,
        ),
      ],
    );
  }
}


class FootterSFAEF extends StatelessWidget {
  const FootterSFAEF({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF004990),
      height: 100,
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
    );
  }
}
