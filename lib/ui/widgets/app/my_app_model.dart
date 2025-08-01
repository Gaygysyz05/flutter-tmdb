import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MyAppModel {
  final _sessionDataprovider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataprovider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataprovider.setSessionId(null);
    await _sessionDataprovider.setAccountId(null);
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRoutesNames.auth,
      (route) => false,
    );
  }
}
