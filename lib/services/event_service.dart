import 'package:upch_events_app/models/comment_model.dart';
import 'package:upch_events_app/models/event_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventService {
  Future<List<EventModel>> fetchEvents() async {
    final response =
    await http.get(Uri.parse('http://35.153.95.41:3001/api/v1/events/'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['events'];

      List<EventModel> events = data
          .map(
            (event) =>
            EventModel.fromJson({
              'id': event['id'],
              'title': event['title'],
              'description': event['description'],
              'date': DateTime.parse(event['date']),
              'location': event['location'],
              'image': event['image'],
            }),
      )
          .toList();
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<EventModel> fetchEvent(String id) async {
    final response =
    await http.get(Uri.parse('http://35.153.95.41:3001/api/v1/events/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['event'];

      EventModel event = EventModel.fromJson({
        'id': data['id'],
        'title': data['title'],
        'description': data['description'],
        'date': DateTime.parse(data['date']),
        'location': data['location'],
        'image': data['image'],
      });
      return event;
    } else {
      throw Exception('Failed to load event');
    }
  }

  Future<bool> deleteEvent(String id) async {
    final response = await http.delete(
      Uri.parse('http://35.153.95.41:3001/api/v1/events/$id')
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CommentModel>> fetchComments(String eventId) async {
    final response = await http
        .get(Uri.parse(
        'http://35.153.95.41:3001/api/v1/comments/?eventId=$eventId'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['comments'];

      List<CommentModel> comments = data
          .map(
            (comment) =>
            CommentModel.fromJson({
              'eventId': comment['eventId'],
              'userId': comment['userId'],
              'text': comment['text'],
              'imageUrl': comment['imageUrl'],
            }),
      )
          .toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
