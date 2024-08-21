import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NuevaActividad extends StatefulWidget {
  const NuevaActividad({super.key});

  @override
  State<NuevaActividad> createState() => _NuevaActividadState();
}

class _NuevaActividadState extends State<NuevaActividad> {
  final TextEditingController nombreActividadController =
      TextEditingController();
  final TextEditingController fechaActividadController =
      TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController horasAcademicasController =
      TextEditingController();
  final TextEditingController horasSocialesController = TextEditingController();
  final TextEditingController horasCulturalesController =
      TextEditingController();
  final TextEditingController horasDeportivasController =
      TextEditingController();

  bool academicoIsChecked = false;
  bool socialIsChecked = false;
  bool culturalIsChecked = false;
  bool deportivoIsChecked = false;
  late Timestamp fechaActividad;

  Future<void> addActividad(
    String nombreActividad,
    Timestamp fechaActividad,
    String descripcion,
    int horasAcademicas,
    int horasSociales,
    int horasCulturales,
    int horasDeportivas,
  ) {
    return FirebaseFirestore.instance.collection('actividadesvoae').add({
      'nombreActividad': nombreActividad,
      'descripcion': descripcion,
      'horasAcademicas': horasAcademicas,
      'horasSociales': horasSociales,
      'horasCulturales': horasCulturales,
      'horasDeportivas': horasDeportivas,
      'fechaActividad': fechaActividad,
      'fechaCreacion': Timestamp.now(),
      'fechaActualizacion': Timestamp.now(),
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            fechaActividad = Timestamp.fromDate(value);
            fechaActividadController.text =
                DateFormat('dd/MM/yyyy').format(value);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Actividad'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              addActividad(
                nombreActividadController.text,
                fechaActividad,
                descripcionController.text,
                int.parse(horasAcademicasController.text),
                int.parse(horasSocialesController.text),
                int.parse(horasCulturalesController.text),
                int.parse(horasDeportivasController.text),
              );

              nombreActividadController.clear();
              fechaActividadController.clear();
              descripcionController.clear();
              horasAcademicasController.clear();
              horasSocialesController.clear();
              horasCulturalesController.clear();
              horasDeportivasController.clear();

              setState(() {
                academicoIsChecked = false;
                socialIsChecked = false;
                culturalIsChecked = false;
                deportivoIsChecked = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Actividad creada exitosamente!'),
                ),
              );
            },
            label: const Text('Guardar'),
            icon: const Icon(Icons.save),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nombreActividadController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: const Text("Nombre"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fechaActividadController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: const Text("Fecha de la actividad"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: _showDatePicker,
                    label: const Text('Elegir fecha'),
                    icon: const Icon(Icons.date_range),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: const Text("Descripción"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Ámbitos:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: academicoIsChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      academicoIsChecked = value!;
                                    });
                                  },
                                ),
                                const Text('Científico/Académico'),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 50,
                              ),
                              child: TextField(
                                enabled: academicoIsChecked,
                                controller: horasAcademicasController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: '0'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: socialIsChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      socialIsChecked = value!;
                                    });
                                  },
                                ),
                                const Text('Social'),
                              ],
                            ),
                            const SizedBox(
                              width: 150,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 50,
                              ),
                              child: TextField(
                                enabled: socialIsChecked,
                                controller: horasSocialesController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: '0',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: culturalIsChecked,
                              onChanged: (value) {
                                setState(() {
                                  culturalIsChecked = value!;
                                });
                              },
                            ),
                            const Text('Cultural'),
                            const SizedBox(
                              width: 140,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 50,
                              ),
                              child: TextField(
                                enabled: culturalIsChecked,
                                controller: horasCulturalesController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: '0',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: deportivoIsChecked,
                              onChanged: (value) {
                                setState(() {
                                  deportivoIsChecked = value!;
                                });
                              },
                            ),
                            const Text('Deportivo'),
                            const SizedBox(
                              width: 128,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 50,
                              ),
                              child: TextField(
                                enabled: deportivoIsChecked,
                                controller: horasDeportivasController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: '0',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
