import 'package:flutter/material.dart';
import 'package:upch_events_app/components/nav_bar.dart';
import 'package:upch_events_app/components/top_bar.dart';

class Events extends StatefulWidget {
  const Events({super.key, required this.title});

  final String title;

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
      ),
      body: GridView.count(
        childAspectRatio: 0.95,
        crossAxisCount: 2,
        children: List.generate(20, (index) {
          return eventCard();
        }),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

Widget eventCard() {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xffd9d9d9),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      children: [
        Image.asset('assets/images/evento1.jpg', width: 120),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5A3966),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            "Ver",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
