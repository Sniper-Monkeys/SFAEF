import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/eventoProvider.dart';
import 'package:sfaef/splash.dart';
import 'package:sfaef/views/eventoFormativo/detalleEvento.dart';
import 'controller/responsableProvider.dart';
import 'firebase_options.dart';
import 'package:sfaef/views/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // void main() => runApp(ModularApp(module: AppModule(), child: MyApp()));

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
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const Login(),
            initialRoute: '/',
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                  builder: (context) => const Login(), settings: settings);
            },
            onGenerateRoute: (settings) {
              // print(settings.name);
              String? id = settings.name!.split('?').last.split('=').last;
              return MaterialPageRoute(builder: (context) => Splash(id: id,));

              // if (settings.name != null) {
              //   if (settings.name!.contains('eventos')) {
              //     return MaterialPageRoute(
              //         builder: (context) => DetalleEvento(id: id));
              //   } else {
              //     return MaterialPageRoute(builder: (context) => Splash());
              //   }
              // }
              //return null;
            }));
  }
}
