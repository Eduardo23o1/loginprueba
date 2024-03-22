import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_view.dart'; // Asegúrate de importar la pantalla de inicio de sesión

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      // Cerrar sesión en Firebase Auth
      await _auth.signOut();

      // Cerrar sesión en Google SignIn
      await _googleSignIn.signOut();

      // Navegar de vuelta a la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (error) {
      print("Error al cerrar sesión: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*       appBar: AppBar(
        title: Text('Welcome'),
      ), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
