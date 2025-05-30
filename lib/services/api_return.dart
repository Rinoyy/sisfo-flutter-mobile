import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PengembalianService {
  final String baseUrl;

  PengembalianService({required this.baseUrl});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<bool> kirimPengembalian({
    required int borrowingId,
    required List<int> itemsId,
    required int idUser,
  }) async {
    final token = await _getToken();
    if (token == null) {
      print('⚠️ Token tidak ditemukan');
      return false;
    }

    final url = Uri.parse('$baseUrl/returns');

    final body = {
      "borrowing_id": borrowingId,
      "id_achiver": 1, // hardcoded
      "item_condition": 1, // hardcoded
      "return_date": DateTime.now().toIso8601String(),
      "items_id": itemsId,
      "status": "PENGAJUAN_PENGEMBALIAN",
      "location_id": 1, // hardcoded
      "id_user": idUser,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // pakai token di sini
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Pengembalian berhasil dikirim');
        return true;
      } else {
        print('❌ Gagal kirim: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('⚠️ Error kirim pengembalian: $e');
      return false;
    }
  }
}
