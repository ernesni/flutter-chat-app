
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando( bool valor ){
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String?> getToken() async{
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  } 
  static Future<void> deleteToken() async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  } 

  Future<bool> login( String email, String password ) async {

    autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    var url = Uri.http(Environment.apiUrl, '${Environment.pathApi}/');
    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register( String name, String email, String password ) async {
    autenticando = true;

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    var url = Uri.http(Environment.apiUrl, '${Environment.pathApi}/new');
    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );
    
    autenticando = false;

    if ( resp.statusCode == 201 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      var decodedResponse = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
      return decodedResponse['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    var url = Uri.http(Environment.apiUrl, '${Environment.pathApi}/renew');
    final resp = await http.get(url, 
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token ?? '' 
      }
    );

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken( String token ) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }


}