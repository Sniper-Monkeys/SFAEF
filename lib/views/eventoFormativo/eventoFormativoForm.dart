import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sfaef/controller/eventoProvider.dart';
import 'package:sfaef/controller/eventoProvider.dart';

import '../utils/utils.dart';

class NuevoEventoFormativo extends StatefulWidget {
  const NuevoEventoFormativo({Key? key}) : super(key: key);

  @override
  State<NuevoEventoFormativo> createState() => _NuevoEventoFormativoState();
}

class _NuevoEventoFormativoState extends State<NuevoEventoFormativo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return Scaffold(
          appBar: appBarTitle(context),
          body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    header(),
                    eventoFormativoFormulario(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (eventoProvider.index == 1)
                          SizedBox(
                            height: 57,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  eventoProvider.index = 0;
                                });
                              },
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 57,
                          width: 337,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (eventoProvider.index == 0) {
                                if (eventoProvider.form1Key.currentState!
                                    .validate()) {
                                  eventoProvider.form1Key.currentState!.save();
                                  eventoProvider.index = 1;
                                }
                                setState(() {});
                              } else if (eventoProvider.index == 1) {
                                if (eventoProvider.form2Key.currentState!
                                    .validate()) {
                                  eventoProvider.form2Key.currentState!.save();
                                  bool confirm =
                                      await eventoProvider.addEvento();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (confirm) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Evento formativo creado con ??xito')));
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Error al crear el evento')));
                                    }
                                  });
                                }
                              }
                            },
                            child: Text(
                              eventoProvider.index == 0
                                  ? "CONTINUAR"
                                  : "ENVIAR SOLICITUD",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const FootterSFAEF()
                  ],
                )),
          ));
    });
  }

  Widget eventoFormativoFormulario() {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          width: 1000,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TituloDecorado(
                titulo: "PROCESO DE SOLICITUD DE EVENTOS FORMATIVOS",
                fontSize: 16,
              ),
              Container(
                color: const Color(0xFFF7F7F7),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TituloDecorado(
                        titulo: "DATOS DEL EVENTO FORMATIVO",
                        fontSize: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (eventoProvider.index == 0)
                        Form(
                            key: eventoProvider.form1Key,
                            child: primerFormulario()),
                      if (eventoProvider.index == 1)
                        Form(
                            key: eventoProvider.form2Key,
                            child: segundoFormulario()),
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      });
    });
  }

  Widget primerFormulario() {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: eventoProvider.responsable.nombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el nombre del evento';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "NOMBRE DEL EVENTO",
                    // border bottom orang

                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                      child: Text(
                    "TIPO DE EVENTO FORMATIVO",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF004990),
                        fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text("MODALIDAD",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF004990),
                              fontWeight: FontWeight.bold))),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        // dropdown de tipo de evento with 'Curso', 'Taller', 'Programa Especial', 'Diplomado'
                        Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            items: eventoProvider.tiposEvento,
                            value: eventoProvider.tipoEvento,
                            onChanged: (value) {
                              eventoProvider.setTipoEvento = value;
                              eventoProvider.responsable.tipo.text =
                                  value.toString();
                            },

                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF004990)),
                            underline: Container(
                              height: 1,
                              color: Colors.orange,
                            ),
                            dropdownColor: Colors.white,

                            isExpanded: true,

                            // backgroundColor: Colors.white,
                            hint: const Text(
                              "TIPO DE EVENTO",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF004990)),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.orange,
                              size: 30,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip:
                              "Curso. Es una experiencia de aprendizaje\nque proporciona elementos\nte??ricos y metodol??gicos de un tema o\nproblem??tica espec??fica. Tiene\nobjectivos claros y puede construirise como\nactividad modular de un\nDipomado. El valor curricular es a partir de 20 Horas.\n\nTaller. Forma de trabajo en donde el\nparticipante construye su\naprenidzaje por medio de la realizaci??n de \nejercicios que son definidos\na partir de un programa de formaci??n\nintegrado por temas que\nresponden a objetivos de aprendizaje\nconcretos. El valor curricular es\napartir de 10 horas.\n\nPrograma especial. Es una experiencia de\naprendizaje, de duraci??n\nvariable, conformada de diversos m??dulos\ntalles u otros. El valor\ncurricular es a partir de 20 horas\n\nDiplomado. Su objectivo es transmitir\nhabilidades para atender\nsituaciones de importancia profesional y\nsocial.Los contenidos que\nse desarollan deben ser de relevancia y\nactualidad en el escenario\nde la pr??ctica acad??mica o profesional. Los\ndiplomados se organizan\nen m??dulos estructurados en un programa\nde estudios. Su duraci??n\nminima es de 120 horas.",
                          icon: const Icon(
                            Icons.help,
                            color: Color(0xFF004990),
                            size: 30,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("TIPO DE EVENTO FORMATIVO"),
                                  content: const Text(
                                      "Seleccione el tipo de evento formativo que desea realizar"),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton(
                      items: eventoProvider.modalidadesEvento,
                      value: eventoProvider.modalidadEvento,
                      onChanged: (value) {
                        eventoProvider.setModalidadEvento = value;
                        eventoProvider.responsable.modalidad.text =
                            value.toString();
                      },
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFF004990)),

                      underline: Container(
                        height: 1,
                        color: Colors.orange,
                      ),
                      dropdownColor: Colors.white,

                      isExpanded: true,
                      // backgroundColor: Colors.white,
                      hint: const Text(
                        "MODALIDAD",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF004990)),
                      ),

                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.orange,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  controller: eventoProvider.responsable.descripcion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese una descripci??n';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "DESCRIPCI??N",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  controller: eventoProvider.responsable.objetivos,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese los objetivos';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,

                    labelText: "DEFINICI??N DE LOS OBJETIVOS",
                    // border bottom orang

                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  controller: eventoProvider.responsable.contYEstructura,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la estructura del evento';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,

                    labelText: "CONTENIDO Y LA ESTRUCTURA DEL PROGRAMA",
                    hintText:
                        "Ej. El programa consiste de tres fases principales...",
                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el costo';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: eventoProvider.responsable.costo,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,

                        labelText: "COSTO",
                        // border bottom orang
                        // only number and .

                        labelStyle:
                            TextStyle(fontSize: 16, color: Color(0xFF004990)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      minLines: 5,
                      maxLines: 5,
                      controller: eventoProvider.responsable.experiencias,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese las experiencias';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,

                        labelText: "EXPERIENCIAS DE APRENDIZAJE",
                        // border bottom orang
                        labelStyle:
                            TextStyle(fontSize: 16, color: Color(0xFF004990)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // ANOTHER EXPANDED TO CUPO AND DURACION
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: eventoProvider.responsable.cupo,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el cupo';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "CUPO",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  controller: eventoProvider.responsable.duracion,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la duraci??n';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "DURACI??N DEL EVENTO (HRS)",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.evaluacion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la estrategia de evaluaci??n';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,

                    filled: true,
                    labelText: "ESTRATEGIA DE EVALUACI??N",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.referencias,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese las referencias';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "REFERENCIAS TE??RICAS-METODOL??GICAS",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.materialApoyo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese los recursos y materiales de apoyo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,

                    filled: true,
                    labelText: "RECURSOS Y MATERIALES DID??CTICOS DE APOYO",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.utilidad,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la utilidad y oportunidad del programa';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "UTILIDAD Y OPORTUNIDAD DEL PROGRAMA",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.reqParticipacion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese los requisitos de participaci??n';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "REQUISITOS DE PARTICIPACI??N",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    hintText: "Ej. Cursar el 5to semestre de la licenciatura",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.reqAcreditacion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese los requisitos de acreditaci??n';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText:
                        "REQUISITOS DE ACREDITACI??N Y ENTREGA DE CONSTANCIA O DIPLOMA",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    hintText:
                        "Obtener una calificaci??n aprobatoria en el proyecto final",
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese las condiciones operativas del evento';
                    }
                    return null;
                  },
                  controller: eventoProvider.responsable.condicionesOperativas,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "CONDICIONES OPERATIVAS DEL EVENTO",
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
                    hintText:
                        "Ej. Abierto o focalizado, cupo m??ximo y min??mo, entre otras cosas.",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  controller: eventoProvider.responsable.dispRecursos,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la disponibilidad de recursos';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "CAPACIDAD DE AUTOFINANCIAMIENTO",

                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),
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
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }

  Widget segundoFormulario() {
    return Consumer<EventoProvider>(builder: (context, eventoProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  controller: eventoProvider.responsable.expInstructores,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText:
                        "EXPERIENCIA, CALIDAD PROFESIONAL Y CALIDAD ACAD??MICA REQUERIDA DEL (LOS)\n INSTRUCTOR(ES)",
                    // border bottom orang
                    labelStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF004990)),

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
          const SizedBox(
            height: 20,
          ),
          const TituloDecorado(
            titulo:
                'AGREGAR CURRICULUM SINT??TICO DEL(LOS) INSTRUCT(ES) PROPUESTO(S)',
            fontSize: 16,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 500,
              width: double.infinity,
              child: Wrap(children: [
                for (var i = 0;
                    i < eventoProvider.responsable.documentos.length;
                    i++)
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        const Expanded(
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              eventoProvider.responsable.documentos.removeAt(i);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                InkWell(
                  onTap: () async {
                    bool confirm = await eventoProvider.attachfile();
                    if (confirm) {
                      // snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Archivo adjuntado'),
                        ),
                      );
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('No se adjunto el archivo'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 178,
                    height: 176,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: 120,
                      ),
                    ),
                  ),
                )
              ])),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }
}
