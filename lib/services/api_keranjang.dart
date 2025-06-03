import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/keranjang.dart';

class ApiKeranjang {
  // Fungsi GET yang sudah ada
  Future<List<KeranjangItem>> fetchKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan, user belum login');
    }

    final response = await http.get(
      Uri.parse('http://localhost:5000/api/keranjang'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((item) => KeranjangItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load keranjang');
    }
  }

  // Tambahkan fungsi POST untuk tambah keranjang
  Future<bool> tambahKeranjang(int itemUnitId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final userId = prefs.getInt('userId');

    if (token == null || userId == null) {
      throw Exception('User belum login atau token hilang');
    }

    final url = Uri.parse('http://localhost:5000/api/keranjang');
    final body = jsonEncode({
      'userId': userId,
      'itemUnitId': itemUnitId,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Gagal tambah keranjang: ${response.body}');
      return false;
    }
  }
}
