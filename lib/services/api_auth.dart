import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiAuth {
  static const _baseUrl = 'http://localhost:5000';
  // static const _baseUrl = 'http://192.168.43.67:5000';
  // static const _baseUrl = 'http://10.0.2.2:5000';

  static Future<String?> login(String nipd, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nipd': nipd, 'password': password}),
    );

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
      final token = data['token'];

      // ✅ Decode token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];

      print('Decoded userId: $userId');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      await prefs.setInt('userId', userId); // simpan userId

      return token;
    } else {
      return null;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
