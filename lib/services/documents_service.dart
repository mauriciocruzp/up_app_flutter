import 'dart:convert';

import '../models/document_model.dart';
import 'package:http/http.dart' as http;

class DocumentsService {
  Future<DocumentModel> fetchDocument(String id) async {
    final response = await http
        .get(Uri.parse('http://35.153.95.41:3001/api/v1/documents/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['document'];

      DocumentModel document = DocumentModel.fromJson({
        'id': data['id'],
        'title': data['title'],
        'description': data['description'],
        'url': data['url'],
      });
      return document;
    } else {
      throw Exception('Failed to load document');
    }
  }
}
