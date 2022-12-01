import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sfaef/views/dashboard/dashboardResponsable.dart';
import 'package:sfaef/views/eventoFormativo/detalleEvento.dart';
import 'package:sfaef/views/login/login.dart';
import 'package:splash_view/splash_view.dart';

class Splash extends StatefulWidget {
  final String? id;
  const Splash({Key? key, required this.id}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  User? currentUser;
  final subscription = FirebaseAuth.instance.idTokenChanges().listen(null);

  @override
  void initState() {
    // if widget.id contains any numbers
    if (widget.id != null &&
        widget.id!.isNotEmpty &&
        widget.id!.contains(RegExp(r'[0-9]'))) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DetalleEvento(
                      id: widget.id!,
                    )));
      });
    }
    subscription.onData((User? user) {
      if (user == null) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 100), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        });
      } else {
        Future.delayed(const Duration(seconds: 1, milliseconds: 100), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const DashboardResponsable()));
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const DashboardResponsable()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashView(
      logo: const SizedBox(
        width: 120,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/icon.png'),
        ),
      ),
      title: const Text('SFAEF',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      subtitle: const Text(
          'Sistema de Formulación y Aprobación de Eventos formativos',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
      duration: const Duration(seconds: 5),
      loadingIndicator: Column(
        children: const [
          SizedBox(height: 20),
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Cargando...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      backgroundImageDecoration: const BackgroundImageDecoration(
        image: AssetImage('assets/images/LCC_login.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
