import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:http/http.dart' as http show post;

enum _AuthMethod {
  login('signInWithPassword'),
  signup('signUp');

  final String value;

  const _AuthMethod(this.value);
}

class Auth with ChangeNotifier {
  static final _apiKey = dotenv.env['FIREBASE_WEB_API_KEY'];

  static final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  Future<void> _authenticate(
    String email,
    String password,
    _AuthMethod authMethod,
  ) async {
    final finalUrl = '$_url${authMethod.value}?key=$_apiKey';

    final response = await http.post(
      Uri.parse(finalUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(response.body);
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, _AuthMethod.login);
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, _AuthMethod.signup);
  }
}
