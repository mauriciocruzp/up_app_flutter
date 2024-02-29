import 'package:flutter/material.dart';
import 'package:upch_events_app/components/top_bar.dart';
import 'package:upch_events_app/pages/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Inicio de sesión'),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            // _forgotPassword(context),
            // _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Image.asset('assets/images/logoup_purple.png', width: 200),
        const Text(
          "Bienvenido",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Ingresa tus datos para continuar"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Correo electrónico",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.alternate_email)),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xff8b00be),
          ),
          child: const Text(
            "Iniciar sesión",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

// _forgotPassword(context) {
//   return TextButton(
//     onPressed: () {},
//     child: const Text("Forgot password?",
//       style: TextStyle(color: Colors.purple),
//     ),
//   );
// }
//
// _signup(context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       const Text("Dont have an account? "),
//       TextButton(
//           onPressed: () {},
//           child: const Text(
//             "Sign Up", style: TextStyle(color: Colors.purple),)
//       )
//     ],
//   );
// }
}
