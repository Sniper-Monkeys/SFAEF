import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/responsableProvider.dart';
import 'package:sfaef/views/dashboard/dashboardResponsable.dart';

import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //email validator
  bool emailValidator(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    // login(context);
  }

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
              loginMainPage(context),
              const FootterSFAEF(),

              //footer every in the bottom
            ],
          ),
        ),
      ),
    );
  }

  Column loginMainPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TituloDecorado(
                titulo: "PROCESO DE SOLICITUD DE EVENTOS FORMATIVOS",
              ),
              //container with F7F7F7 background color
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 894,
                height: 600,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  //circular border
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 109,
                      width: 692,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              backgroundColor: const Color(0xFFF7A11A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
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
                    const SizedBox(
                      height: 10,
                    ),
                    // login credentials
                    // email input
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 692,
                            height: 60,
                            child: TextField(
                              controller: _emailController,
                              // validator: emailValidator,

                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),

                                // orange border and blue label
                                label: Text(
                                  "Correo",
                                  style: TextStyle(
                                    color: Color(0xFF0F4C81),
                                  ),
                                ),
                                hintText: "Ingrese su correo",
                                icon: Icon(
                                  Icons.email,
                                  color: Color(0xFF0F4C81),
                                ),

                                labelStyle: TextStyle(
                                    fontSize: 16, color: Color(0xFF004990)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                              ),
                            ),
                          ),
                          // password input
                          SizedBox(
                            width: 692,
                            height: 60,
                            child: TextField(
                              controller: _passwordController,
                              onSubmitted: (value) => login(context),
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contraseña',
                                hintText: "********",
                                icon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF0F4C81),
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 16, color: Color(0xFF004990)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    loginButton(context),
                    const Text(
                      '* En caso de contar con un evento formativo aprobado previamente por el SFAEF favor de iniciar sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF004990)),
                    ),
                    if (isLogin)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.orange),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Iniciando sesión...',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF004990)),
                          ),
                        ],
                      )
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  Container loginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      height: 109,
      width: 692,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: const Color(0xFFF7A11A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
          onPressed: () {
            login(context);
          },
          child: const Text(
            "Iniciar Sesión",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }

  Future<void> login(BuildContext context) async {
    // _emailController.text = 'a219205955@unison.mx';
    // _passwordController.text = 'admin123';
    if (emailValidator(_emailController.text)) {
      setState(() {
        isLogin = true;
      });

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        if (value.user != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const DashboardResponsable()));
        } else {
          setState(() {
            isLogin = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Usuario o contraseña incorrectos'),
              ),
            );
          });
        }
      }).onError((error, stackTrace) {
        setState(() {
          isLogin = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Usuario o contraseña incorrectos'),
            ),
          );
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Credenciales incorrectas'),
        ),
      );
    }
  }

  // Widget loginButton(BuildContext context) {
  //   return StatefulBuilder(builder: (context, setState) {
  //     return
  //   });
  // }
}
