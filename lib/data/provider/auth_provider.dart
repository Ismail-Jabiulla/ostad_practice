import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../app_url.dart';

class AuthenticationProvider extends ChangeNotifier {
  Future<String?> login(String email, String password) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse("$authUrl/login"));

      var response = await request.send();
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson =
        json.decode(await response.stream.bytesToString());
        String token = parsedJson['token'];
        String uid = parsedJson['user']['_id'];

        await saveTokenToSharedPreferences(token);

        print('Token: $token');
        print('UID: $uid');
        notifyListeners();
        return token;
      } else {
        print("Error: ${response.statusCode}");
        print("Error: ${await response.stream.bytesToString()}");
        notifyListeners();
        return null; // Return null in case of error
      }
    } catch (e) {
      print('Error during login: $e');
      return null; // Return null in case of error
    }
  }

  Future<void> saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
