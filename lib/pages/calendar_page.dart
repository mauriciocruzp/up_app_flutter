import 'package:flutter/material.dart';
import 'package:up_app_flutter/components/top_bar.dart';
import 'package:up_app_flutter/services/documents_service.dart'; // Importa el servicio de documentos

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.title});

  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String documentUrl = ""; // Variable para almacenar la URL del documento

  @override
  void initState() {
    super.initState();
    fetchDocumentUrl(); // Obtiene la URL del documento al inicializar el estado
  }

  fetchDocumentUrl() async {
    DocumentsService documentsService = DocumentsService();
    var document = await documentsService.fetchDocument('fe78ff6e-0a2d-4828-a833-640a0c5cfc07');
    setState(() {
      documentUrl = document.url; // Actualiza la URL del documento
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "2023-2024",
                    style: TextStyle(
                        color: Color(0xff0D0C0C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"),
                  ),
                  Container(
                    height: 600,
                    width: 350,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffd9d9d9),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(documentUrl, width: 280),
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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