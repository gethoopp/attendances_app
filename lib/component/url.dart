import 'package:attendance_app/consstant/env_config.dart';

class Url {
  //base URL
  static String get baseUrl => EnvConfig.baseUrl;
  static String get baseSocket => EnvConfig.baseSocket;

  //URL
  static String registerUrl = 'api/register';
  static String loginUrl = 'api/login';
  static String getUser = 'api/data';
  static String getUserPresence = 'api/presence';
  static String sendCheckin = 'api/checkIn';
  static String sendCheckOut = 'api/checkOut';

  //socket URL
  static String socketUrl = 'ws/input';
}
