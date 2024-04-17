class DocumentModel {
  final String title;
  final String description;
  final String url;

  DocumentModel({
    required this.title,
    required this.description,
    required this.url,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'description': String description,
        'url': String url,
      } =>
        DocumentModel(
          title: title,
          description: description,
          url: url,
        ),
      _ =>
        throw const FormatException('Failed to create a DocumentModel from JSON'),
    };
  }
}