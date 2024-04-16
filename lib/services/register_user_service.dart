import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RegisterUserService {
  Future<String?> register(String firstName, String lastName,String email, String password) async {
    Map<String,String> headers = {'Content-Type':'application/json'};
    if (kDebugMode) {
      print(email);
      print(password);
    }
    final msg = jsonEncode({'firstName': firstName, 'lastName': lastName,'email': email, 'password': password});
    final response = await http.post(
      Uri.parse('http://35.153.95.41:3001/api/v1/users/'),
      headers: headers,
      body: msg,
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
