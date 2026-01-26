import 'package:flutter/material.dart';

void main() {
  runApp(const MiPrimeraApp());
}

class MiPrimeraApp extends StatelessWidget {
  const MiPrimeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(' Perfil Personal'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.blue,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Andy Posas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  'Ingeniería en Sistemas',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Bienvenido a mi primera app',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 15),

                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                  height: 100,
                ),

                const SizedBox(height: 20),

                Card(
                  color: Colors.purple,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Información Adicional',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Ciudad: La Ceiba'),
                        Text('Edad: 20 años'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Mis hobbies:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const Column(
                  children: [
                    Text(' Gym'),
                    Text(' Escuchar música'),
                    Text(' Ver Pelis'),
                  ],
                ),

                const SizedBox(height: 20),

               
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Gracias por visitar mi app!'),
                          ),
                        );
                      },
                      child: const Text('Gracias'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
