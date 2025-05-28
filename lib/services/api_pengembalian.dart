import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pengembalian.dart';

class ApiService {
  Future<List<Pengembalian>> fetchPengembalian() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan, user belum login');
    }

    final response = await http.get(
      Uri.parse('http://localhost:5000/api/returns'),
      headers: {
        'Authorization': 'Bearer $token',  // Kirim token di header
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      print('Respons JSON: $jsonResponse');

      final List<dynamic> dataList = jsonResponse['data'];

      for (var item in dataList) {
        print('Item: $item');
      }

      return dataList.map((json) => Pengembalian.fromJson(json)).toList();
    } else {
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Gagal mengambil data pengembalian');
    }
  }
}
