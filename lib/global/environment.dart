
import 'dart:io';

class Environment {
  //static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:8080/api/auth' : 'http://localhost:8080/api/auth';
  static String apiUrl = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';
  static String pathApi = '/api/auth';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000'       : 'http://localhost:3000';
}