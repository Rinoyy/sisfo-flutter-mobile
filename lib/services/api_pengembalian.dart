import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pengembalian.dart';

class ApiService {
  Future<List<Pengembalian>> fetchPengembalian() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/load'));
    //     final response =
    // await http.get(Uri.parse('http://10.0.2.2:5000/api/load'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Pengembalian.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pengembalian');
    }
  }
}
