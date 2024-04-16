import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upch_events_app/components/top_bar.dart';
import 'package:upch_events_app/pages/login_page.dart';
import 'package:upch_events_app/pages/main_page.dart';
import 'package:upch_events_app/services/auth_user_service.dart';
import 'package:upch_events_app/services/register_user_service.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Registro'),
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
          controller: firstNameController,
          decoration: InputDecoration(
              hintText: "Nombre",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: lastNameController,
          decoration: InputDecoration(
              hintText: "Apellido",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: emailController,
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
          controller: passwordController,
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
            String firstName = firstNameController.text;
            String lastName = lastNameController.text;
            String email = emailController.text;
            String password = passwordController.text;

            RegisterUserService registerUserService = RegisterUserService();
            registerUserService.register(firstName, lastName, email, password).then((token) {
              if (token != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Usuario ya existente"),
                  ),
                );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xff8b00be),
          ),
          child: const Text(
            "Registrarse",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("¿Ya tienes una cuenta? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text(
                "Inicia sesión",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
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
