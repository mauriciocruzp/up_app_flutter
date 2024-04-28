import 'package:flutter/material.dart';
import 'package:up_app_flutter/pages/login_page.dart';


class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff8b00be),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoup.png', width: 200),
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 60,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
