import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/service/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'The server is not available. Check yout network connection';
        case ApiClientExceptionType.auth:
          return 'Invalid login ot password!';
        case ApiClientExceptionType.other:
          return 'An error occurred. Please try again';
        case ApiClientExceptionType.sessionExpired:
          throw UnimplementedError();
      }
    } catch (e) {
      return 'An error occurred. Please try again';
    }

    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (_isValid(login, password)) {
      _updateState('Invalid username or password', false);
      return;
    }

    _updateState(null, true);

    _errorMessage = await _login(login, password);

    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    }
    _updateState(_errorMessage, false);
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == _isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = _isAuthProgress;
    notifyListeners();
  }
}
