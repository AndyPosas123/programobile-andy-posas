      import 'package:flutter/material.dart';

      void main() {
        runApp(const MyApp());
      }

      // Lista donde se guardan las citas
      List<String> historialCitas = [];

      class MyApp extends StatelessWidget {
        const MyApp({super.key});

        @override
        Widget build(BuildContext context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        }
      }
      class HomeScreen extends StatefulWidget {
        const HomeScreen({super.key});

        @override
        State<HomeScreen> createState() => _HomeScreenState();
      }

      class _HomeScreenState extends State<HomeScreen> {
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Reservas Médicas"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),

              // Se usa Column para organizar los elementos verticalmente porque la información va de arriba hacia abajo
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Próxima Cita",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  // Container para mostrar la próxima cita
                  // sirve para darle forma y color al contenido
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: historialCitas.isEmpty
                        ? const Text("No tienes citas próximas")
                        : Text(historialCitas.last),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Opciones",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  // Expanded permite que el Grid ocupe el espacio disponible
                  Expanded(
                    // GridView organiza las opciones en forma de cuadrícula
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        buildOption(context, Icons.history, "Historial", () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HistorialScreen()),
                          );
                          setState(() {});
                        }),
                        buildOption(context, Icons.add_circle, "Agendar Cita",
                            () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AgendarScreen()),
                          );
                          setState(() {});
                        }),
                        buildOption(context, Icons.notifications, "Notificaciones",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const NotificacionesScreen()),
                          );
                        }),
                        buildOption(context, Icons.person, "Perfil", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PerfilScreen()),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Widget reutilizable para cada opción
        Widget buildOption(
            BuildContext context, IconData icon, String text, VoidCallback onTap) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),

              // Column para centrar el ícono y el texto
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(text),
                ],
              ),
            ),
          );
        }
      }

      //Historial 

      class HistorialScreen extends StatelessWidget {
        const HistorialScreen({super.key});

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Historial")),

            // ListView permite ver varias citas con scroll
            body: historialCitas.isEmpty
                ? const Center(child: Text("No hay citas registradas"))
                : ListView.builder(
                    itemCount: historialCitas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(historialCitas[index]),
                      );
                    },
                  ),
          );
        }
      }

      //Citas

      class AgendarScreen extends StatefulWidget {
        const AgendarScreen({super.key});

        @override
        State<AgendarScreen> createState() => _AgendarScreenState();
      }

      class _AgendarScreenState extends State<AgendarScreen> {
        final TextEditingController _controller = TextEditingController();

        DateTime? fecha;
        TimeOfDay? hora;

        // Selector de fecha
        Future<void> elegirFecha() async {
          final seleccion = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );

          if (seleccion != null) {
            setState(() => fecha = seleccion);
          }
        }

        // Selector de hora
        Future<void> elegirHora() async {
          final seleccion = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (seleccion != null) {
            setState(() => hora = seleccion);
          }
        }

        // Guarda la cita en la lista
        void guardarCita() {
          if (_controller.text.isNotEmpty && fecha != null && hora != null) {
            String cita =
                "${_controller.text} - ${fecha!.day}/${fecha!.month} - ${hora!.format(context)}";

            historialCitas.add(cita);

            Navigator.pop(context);
          }
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Agendar Cita")),
            body: Padding(
              padding: const EdgeInsets.all(16),

              // Column organiza el formulario verticalmente
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(labelText: "Especialidad"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: elegirFecha,
                    child: Text(fecha == null
                        ? "Seleccionar Fecha"
                        : "${fecha!.day}/${fecha!.month}/${fecha!.year}"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: elegirHora,
                    child: Text(hora == null
                        ? "Seleccionar Hora"
                        : hora!.format(context)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: guardarCita,
                    child: const Text("Guardar"),
                  ),
                ],
              ),
            ),
          );
        }
      }

      //Notificaciones

      class NotificacionesScreen extends StatelessWidget {
        const NotificacionesScreen({super.key});

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Notificaciones")),
            body: const Center(
              child: Text("No tienes notificaciones nuevas."),
            ),
          );
        }
      }

      //Perfil 

      class PerfilScreen extends StatelessWidget {
        const PerfilScreen({super.key});

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Mi Perfil")),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 80),
                  SizedBox(height: 10),
                  Text("Nombre: Juan Pérez"),
                  Text("Correo: juan@email.com"),
                ],
              ),
            ),
          );
        }
      }
