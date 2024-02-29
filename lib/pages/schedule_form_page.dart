import 'package:flutter/material.dart';
import 'package:upch_events_app/components/top_bar.dart';

class ScheduleFormPage extends StatelessWidget {
  const ScheduleFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Horario'),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(children: [
      Text("Selecciona los datos de tu horario", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
  }

  _inputField(context) {
    List<String> majors = <String>["Software", "Biomédica", "Mecatrónica", "Manufactura", "Nanotecnología"];
    List<String> cuatrimester = <String>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    List<String> groups = <String>["A", "B", "C"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Carrera"),
        DropdownButtonFormField(
            items: majors.map((e){
              return DropdownMenuItem(
                  value: e,
                  child: Text(e)
              );
            }).toList(), onChanged: (value){}),
        const SizedBox(height: 10),
        const Text("Cuatrimestre"),
        DropdownButtonFormField(
            items: cuatrimester.map((e){
              return DropdownMenuItem(
                  value: e,
                  child: Text(e)
              );
            }).toList(), onChanged: (value){}),
        const SizedBox(height: 10),
        const Text("Grupo"),
        DropdownButtonFormField(
            items: groups.map((e){
              return DropdownMenuItem(
                  value: e,
                  child: Text(e)
              );
            }).toList(), onChanged: (value){}),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Ver horario",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }
}
