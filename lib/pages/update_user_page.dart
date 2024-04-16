import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upch_events_app/components/top_bar.dart';
import 'package:upch_events_app/pages/login_page.dart';
import 'package:upch_events_app/pages/main_page.dart';
import 'package:upch_events_app/services/auth_user_service.dart';
import 'package:upch_events_app/services/register_user_service.dart';

import 'home_page.dart';

class UpdateUserPage extends StatefulWidget {
  UpdateUserPage({super.key});

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthUserService().getUserData().then((userData) {
      if (userData[0] != null) {
        AuthUserService authUserService = AuthUserService();
        authUserService.getUserById(userData[0]!).then((user) {
          idController.text = user.id;
          firstNameController.text = user.firstName;
          lastNameController.text = user.lastName;
          emailController.text = user.email;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Datos de usuario'),
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
            String id = idController.text;
            String firstName = firstNameController.text;
            String lastName = lastNameController.text;
            String email = emailController.text;
            String password = passwordController.text;

            AuthUserService authUserService = AuthUserService();
            authUserService.updateUser(id, firstName, lastName, email, password).then((response) {
              if (response == true) {

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(title: 'Principal',),
                  ),
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
            "Actualizar",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
