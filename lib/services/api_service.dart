import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_unit.dart';

class ApiService {
  Future<List<ItemUnit>> fetchItemUnits() async {
    // final response =
    //   await http.get(Uri.parse('http://10.0.2.2:5000/api/itemsUnit'));
  final response = await http.get(Uri.parse('http://localhost:5000/api/itemsUnit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ItemUnit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load item units');
    }
  }
}
