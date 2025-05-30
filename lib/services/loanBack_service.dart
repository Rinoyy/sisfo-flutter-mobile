import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/peminjaman.dart';

class LoanBackService {
  Future<List<Peminjaman>> fetchPeminjaman() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/load'));
    //     final response =
    // await http.get(Uri.parse('http://10.0.2.2:5000/api/load'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      return data.map((json) => Peminjaman.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peminjaman');
    }
  }
}
