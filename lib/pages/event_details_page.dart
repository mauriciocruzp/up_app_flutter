import 'package:flutter/material.dart';
import 'package:upch_events_app/components/top_bar.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: "Evento"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/evento1.jpg',
                  width: 280, height: 300),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Encuentro anual ANUIES-TIC AUNL |2024",
              style: TextStyle(
                  color: Color(0xff0D0C0C),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter"),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Requisitos: ser estudiante o tesista\nLugar: Universidad Politecnica de Chiapas\nFecha: 30 de Marzo de 2024\nHora: 10:00 am-12:00 pm\nCosto: 800\nModalidad: Presencial\nRegistro: 964 002 58 95\nMas información: https://eventoUANL.com",
              style: TextStyle(
                  height: 2.5,
                  color: Color(0xff0D0C0C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter"),
            ),
          ],
        ),
      ),
    );
  }
}
