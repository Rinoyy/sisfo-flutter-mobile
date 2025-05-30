import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/keranjang.dart';

class ApiKeranjang {
  Future<List<KeranjangItem>> fetchKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan, user belum login');
    }

    final response = await http.get(
      Uri.parse('http://localhost:5000/api/keranjang'),
      // Uri.parse('http://10.0.2.2:5000/api/keranjang'),
      headers: {
        'Authorization': 'Bearer $token', // Kirim token di header
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];

      // print(dataList);

      return dataList.map((item) => KeranjangItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load item units');
    }
  }
}
