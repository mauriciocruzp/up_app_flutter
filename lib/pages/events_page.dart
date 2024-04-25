import 'package:flutter/material.dart';
import 'package:upch_events_app/components/top_bar.dart';
import 'package:upch_events_app/models/comment_model.dart';
import 'package:upch_events_app/pages/create_event_page.dart';
import 'package:upch_events_app/pages/event_details_page.dart';
import 'package:upch_events_app/services/event_service.dart';
import 'package:upch_events_app/models/event_model.dart';

import '../services/auth_user_service.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key, required this.title});

  final String title;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late Future<List<EventModel>> futureEvents;
  late Future<List<String?>> futureUser;

  @override
  void initState() {
    super.initState();

    EventService es = EventService();
    futureEvents = es.fetchEvents();

    AuthUserService aus = AuthUserService();
    futureUser = aus.getUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEventsFromApi();
  }

  void fetchEventsFromApi() {
    EventService es = EventService();
    futureEvents = es.fetchEvents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
      ),
      body: Center(
        child: FutureBuilder<List<EventModel>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildEvents(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      backgroundColor: const Color(0xffE9E9E9),
    );
  }

  Widget buildEvents(List<EventModel> events) {
    return ListView.builder(
      itemCount: events.length + 1, // Agrega un espacio para el botón
      itemBuilder: (context, index) {
        if (index < events.length) {
          final event = events[index];
          return EventCard(context: context, event: event);
        } else {
          return FutureBuilder<List<String?>>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!);
                if (snapshot.data![1] == 'true') {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateEventPage()),
                      );
                    },
                    child: const Text('Agregar evento'),
                  );
                } else {
                  return const SizedBox.shrink(); // No muestra nada si el usuario no es administrador
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          );
        }
      },
    );
  }
}

class EventCard extends StatefulWidget {
  final EventModel event;
  final BuildContext context;

  const EventCard({super.key, required this.context, required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late Future<List<CommentModel>> futureComments;

  @override
  void initState() {
    super.initState();
    EventService es = EventService();
    futureComments = es.fetchComments(widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              id: widget.event.id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                widget.event.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Image.network(widget.event.image),
            FutureBuilder<List<CommentModel>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          '${snapshot.data!.length.toString()} comentarios', style: const TextStyle(color: Colors.black38),),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
