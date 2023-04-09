import 'package:flutter/material.dart';
import 'regPage.dart';
import 'ingresar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized(); //LA APLICACIÓN NO FUNCIONA ( SE QUEDA EN BLANCO ), SI SE UTILIZAN ESTAS DOS LÌNEAS
  //await Firebase.initializeApp(); //No se pudo implementar firebase.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      home: const HomePage(),
      routes: {
        '/regPage': (context) => const RegisterScreen(),
        '/ingresar': (context) => LoginPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/imagen4.jpg',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 32),
          Container(
            width: 5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ingresar');
              },
              child: const Text('Ingresar'),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 98, 127, 255),
                  fixedSize: const Size(200, 50)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/regPage');
            },
            child: const Text('Registrarse'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              fixedSize: const Size(200, 50),
            ),
          ),
        ],
      ),
    );
  }
}
