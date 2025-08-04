import 'package:themoviedb/domain/data_provider/session_data_provider.dart';

class AuthService {
  final _sessionDataprovider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataprovider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }
}
