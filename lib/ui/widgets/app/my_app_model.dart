import 'package:themoviedb/domain/data_provider/session_data_provider.dart';

class MyAppModel {
  final _sessionDataprovider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataprovider.getSessionId();
    _isAuth = sessionId != null;
  }
}
