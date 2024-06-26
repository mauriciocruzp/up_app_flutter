import 'package:flutter/material.dart';
import 'package:up_app_flutter/components/top_bar.dart';
import 'package:up_app_flutter/pages/event_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Calendario Académico 2023-2024",
                      style: TextStyle(
                          color: Color(0xff0D0C0C),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter")),
                ],
              ),
            ),
            Container(
              color: const Color(0xffd9d9d9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Calendario_2023_2024.jpg',
                      width: 280, height: 300),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Encuentra el sitio que buscas",
                      style: TextStyle(
                          color: Color(0xff0D0C0C),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter")),
                ],
              ),
            ),
            Container(
              color: const Color(0xffd9d9d9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/mapa.jpg',
                      width: 230, height: 170),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Eventos",
                      style: TextStyle(
                          color: Color(0xff0D0C0C),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter")),
                ],
              ),
            ),
            Container(
              color: const Color(0xffd9d9d9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/evento1.jpg',
                          width: 130, height: 120),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EventDetailsPage(id: '1')));
                            },
                            child: const Text('Ver más'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/images/evento2.jpg',
                          width: 120, height: 130),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EventDetailsPage(id: '2')));
                            },
                            child: const Text('Ver más'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
