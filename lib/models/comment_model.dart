class CommentModel {
  final String eventId;
  final String userId;
  final String text;
  final String imageUrl;

  const CommentModel({
    required this.eventId,
    required this.userId,
    required this.text,
    required this.imageUrl,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'eventId': String eventId,
        'userId': String userId,
        'text': String text,
        'imageUrl': String imageUrl,
      } =>
        CommentModel(
          eventId: eventId,
          userId: userId,
          text: text,
          imageUrl: imageUrl,
        ),
      _ =>
        throw const FormatException('Failed to create a CommentModel from JSON'),
    };
  }
}