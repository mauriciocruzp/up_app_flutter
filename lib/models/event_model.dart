class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String image;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'title': String title,
        'description': String description,
        'date': DateTime date,
        'location': String location,
        'image': String image,
      } =>
        EventModel(
          id: id,
          title: title,
          description: description,
          date: date,
          location: location,
          image: image,
        ),
      _ =>
        throw const FormatException('Failed to create an EventModel from JSON'),
    };
  }
}
