import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/imagen4.jpg',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(_nicknameController, 'Nickname'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_nameController, 'Nombre'),
            _buildTextField(_passwordController, 'Contraseña',
                isPassword: true),
            _buildTextField(_confirmPasswordController, 'Confirmar Contraseña',
                isPassword: true),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  // Si el registro es exitoso, se puede obtener el usuario que se acaba de registrar a través de userCredential.user
                  // También se puede guardar información adicional del usuario en la base de datos Firestore.
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('La contraseña es demasiado débil.');
                  } else if (e.code == 'email-already-in-use') {
                    print('El correo electrónico ya está en uso.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                fixedSize: const Size(200, 50),
              ),
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 32),
            const Divider(),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 5, bottom: 5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
        ),
      ),
    );
  }
}
