import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/eventoProvider.dart';
import 'controller/responsableProvider.dart';
import 'firebase_options.dart';
import 'package:sfaef/views/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsableProvider responsableProvider = ResponsableProvider();
    EventoProvider eventoProvider = EventoProvider();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => responsableProvider),
          ChangeNotifierProvider(create: (context) => eventoProvider),
        ],
        child: MaterialApp(
            title:
                'Sistema de Formulación y Aprobación de Eventos formativos (SFAEF)',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const Login()));
  }
}
