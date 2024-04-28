import 'package:flutter/material.dart';
import 'package:up_app_flutter/components/top_bar.dart';
import 'package:up_app_flutter/pages/events_page.dart';

import '../models/comment_model.dart';
import '../models/event_model.dart';
import '../services/auth_user_service.dart';
import '../services/event_service.dart';

class EventDetailsPage extends StatefulWidget {
  final String id;

  const EventDetailsPage({
    required this.id,
    super.key,
  });

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Future<EventModel> futureEvent;
  late Future<List<CommentModel>> futureComments;
  late Future<List<String?>> futureUser;

  @override
  void initState() {
    super.initState();
    futureEvent = EventService().fetchEvent(widget.id);
    futureComments = EventService().fetchComments(widget.id);
    futureUser = AuthUserService().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: "Evento"),
      body: SingleChildScrollView(
        child: FutureBuilder<EventModel>(
          future: futureEvent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var comment = snapshot.hasData;
              return Column(
                children: [
                  EventCard(context: context, event: snapshot.data!),
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data!.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Lugar: ${snapshot.data!.location}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Fecha: ${snapshot.data!.date.toUtc()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                                  FutureBuilder<List<String?>>(
                                    future: futureUser,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data![1] == 'true') {
                                          return ElevatedButton(
                                            onPressed: () {
                                              EventService()
                                                  .deleteEvent(widget.id);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EventsPage(title: 'Eventos',),
                                                ),
                                              );
                                            },
                                            child:
                                                const Text('Eliminar evento'),
                                          );
                                        } else {
                                          return const SizedBox
                                              .shrink(); // No muestra nada si el usuario no es administrador
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<CommentModel>>(
                    future: futureComments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final comment = snapshot.data![index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xffeeeeee),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
