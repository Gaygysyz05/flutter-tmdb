import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Invalid username or password';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;

    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'The server is not available. Check yout network connection';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Invalid login ot password!';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'An error occurred. Please try again';   
          break;
      }
    }
     catch (e) {
      _errorMessage = 'An error occurred. Please try again';   
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Unknown error, try again.';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutesNames.mainScreen));
  }
}

