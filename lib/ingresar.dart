import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Imagen
                Image.asset(
                  'assets/imagen5.jpg',
                  height: 200.0,
                ),
                const SizedBox(height: 20.0),
                // Campos de usuario y contraseña
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                  ),
                ),
                const SizedBox(height: 10.0),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                SizedBox(height: 20.0),
                // ingresar
                ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      // Si el inicio de sesión es exitoso, se puede obtener el usuario que se acaba de registrar a través de userCredential.user
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print(
                            'No se encontró una cuenta con ese correo electrónico.');
                      } else if (e.code == 'wrong-password') {
                        print('Contraseña incorrecta.');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize: const Size(200, 50),
                  ),
                  child: const Text('Iniciar sesión'),
                ),

                SizedBox(height: 20.0),
                // redes sociales
                const Text(
                  'Ingresa con tus redes sociales',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Botón de Facebook
                    ElevatedButton.icon(
                      onPressed: () async {
                        await launch('https://www.facebook.com/');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4267B2),
                        onPrimary: Colors.white,
                      ),
                      icon: const Icon(Icons.facebook),
                      label: const Text('Facebook'),
                    ),
                    // Botón de Google
                    ElevatedButton.icon(
                      onPressed: () async {
                        launch(
                            'https://accounts.google.com/v3/signin/identifier?dsh=S-33459664%3A1680834825555408&continue=https%3A%2F%2Faccounts.google.com%2F&followup=https%3A%2F%2Faccounts.google.com%2F&ifkv=AQMjQ7RTxL0CkwfmYQp-b83w0PxITl0so7Lcd3Z1bcxKAuJAedjaRCbvjBl4DMwNHCKe_KvnyNCVSg&passive=1209600&flowName=GlifWebSignIn&flowEntry=ServiceLogin');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 235, 9, 9),
                        onPrimary: Color.fromARGB(255, 255, 255, 255),
                      ),
                      icon: const Icon(Icons.g_translate),
                      label: const Text('Google'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // recuperar contraseña
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    '¿Haz olvidado tu contraseña? Recupérala aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
