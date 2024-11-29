import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario IUJO',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormularioCapturaDatos(),
    );
  }
}

class FormularioCapturaDatos extends StatefulWidget {
  const FormularioCapturaDatos({super.key});

  @override
  _FormularioCapturaDatosState createState() => _FormularioCapturaDatosState();
}

class _FormularioCapturaDatosState extends State<FormularioCapturaDatos> {
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool activarNotificaciones = false;
  double precioEstimado = 0.0;
  DateTime? fechaSeleccionada;
  TimeOfDay? horaSeleccionada;

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
      });
    }
  }

  Future<void> _seleccionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != horaSeleccionada) {
      setState(() {
        horaSeleccionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Captura de Datos'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.0,
                      width: 250.0,
                      child: Image.asset('assets/image.png'),
                    ),
                    const Text(
                      'Formulario de captura de Datos',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Nombre',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text("Trabaja"),
                value: trabaja,
                onChanged: (bool? value) {
                  setState(() {
                    trabaja = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text("Estudia"),
                value: estudia,
                onChanged: (bool? value) {
                  setState(() {
                    estudia = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              ListTile(
                title: const Text("Masculino"),
                leading: Radio(
                  value: 'Masculino',
                  groupValue: genero,
                  onChanged: (String? value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Femenino"),
                leading: Radio(
                  value: 'Femenino',
                  groupValue: genero,
                  onChanged: (String? value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
              ),
              SwitchListTile(
                title: const Text("Activar Notificaciones"),
                value: activarNotificaciones,
                onChanged: (bool value) {
                  setState(() {
                    activarNotificaciones = value;
                  });
                },
              ),
              const Center(
                child: Text(
                  "Seleccione Precio Estimado",
                  textAlign: TextAlign.center,
                ),
              ),
              Slider(
                value: precioEstimado,
                min: 0,
                max: 100,
                divisions: 10,
                label: precioEstimado.round().toString(),
                activeColor: Colors.yellow,
                onChanged: (double value) {
                  setState(() {
                    precioEstimado = value;
                  });
                },
              ),
              Column(
                children: [
                  const Divider(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    label: const Text("Fecha"),
                    onPressed: () => _seleccionarFecha(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.access_time, color: Colors.white),
                    label: const Text("Hora"),
                    onPressed: () => _seleccionarHora(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {},
      ),
    );
  }
}
