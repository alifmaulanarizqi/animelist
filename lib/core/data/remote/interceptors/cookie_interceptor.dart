import 'package:dio/dio.dart';
import 'package:fms/core/data/local/app_preferences.dart';
import 'package:get_it/get_it.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    var cookies = response.headers['set-cookie'];
    if (cookies != null && cookies.isNotEmpty) {
      var prefs = GetIt.instance<AppPreferences>();

      var token = '';
      var refreshToken = '';

      for (var cookie in cookies) {
        if (cookie.startsWith('token')) {
          token = cookie
              .split(';')
              .where((e) => e.startsWith('token='))
              .first
              .replaceAll('token=', '');
        } else if (cookie.startsWith('refresh_token')) {

          refreshToken = cookie
              .split(';')
              .where((e) => e.startsWith('refresh_token'))
              .first
              .replaceAll('refresh_token=', '');
        }
      }

      if (token.isNotEmpty) {
        prefs.setToken(token);
        prefs.setRefreshToken(refreshToken);
      }
    }

  }
}
