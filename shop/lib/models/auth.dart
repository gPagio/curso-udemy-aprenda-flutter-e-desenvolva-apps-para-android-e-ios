import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:http/http.dart' as http show post;
import 'package:shop/exceptions/auth_exception.dart' show AuthException;

enum _AuthMethod {
  login('signInWithPassword'),
  signup('signUp');

  final String value;

  const _AuthMethod(this.value);
}

class Auth with ChangeNotifier {
  static final _apiKey = dotenv.env['FIREBASE_WEB_API_KEY'];
  static final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expirationDate;

  bool get isAuth {
    final isValidTokenExpirationDate =
        _expirationDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValidTokenExpirationDate;
  }

  String? get token {
    if (isAuth) return _token;
    return null;
  }

  String? get email {
    if (isAuth) return _email;
    return null;
  }

  String? get userId {
    if (isAuth) return _uid;
    return null;
  }

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

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expirationDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, _AuthMethod.login);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, _AuthMethod.signup);
  }
}
