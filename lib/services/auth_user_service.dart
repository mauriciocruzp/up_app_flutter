import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upch_events_app/models/user_model.dart';

class AuthUserService {
  Future<String?> login(String email, String password) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({'email': email, 'password': password});
    final response = await http.post(
      Uri.parse('http://35.153.95.41:3001/api/v1/users/auth'),
      headers: headers,
      body: msg,
    );


    if (response.statusCode == 201) {
      var payload = parseJwt(response.body);
      bool isAdmin = payload['dataValues']['admin'];
      String id = payload['dataValues']['id'];
      updateToken(response.body);
      updateUserData(id, isAdmin);
      return response.body;
    } else {
      return null;
    }
  }

  Future<bool> updateUser(String id, String firstName, String lastName, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    });
    final response = await http.put(
      Uri.parse('http://35.153.95.41:3001/api/v1/users/$id'),
      headers: headers,
      body: msg,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  updateToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  updateUserData(String userId, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', userId);
    prefs.setString('isAdmin', isAdmin.toString());
  }

  Future<List<String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? isAdmin = prefs.getString('isAdmin');
    bool isAdminBool = isAdmin == 'true' ? true : false;
    if (userId != null) {
      return [userId, isAdmin];
    } else {
      return [null, null];
    }
  }

  Future<UserModel> getUserById(String id) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      Uri.parse('http://35.153.95.41:3001/api/v1/users/$id'),
      headers: headers,
    );

    var userData = jsonDecode(response.body)['user'];
    print(userData);

    UserModel user = UserModel(id: userData['id'],
        firstName: userData['firstName'],
        lastName: userData['lastName'],
        email: userData['email'],
        isAdmin: userData['admin']);

    return user;
  }

  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({'token': token});
      final response = await http.post(
        Uri.parse('http://35.153.95.41:3001/api/v1/users/validate-token'),
        headers: headers,
        body: msg,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
