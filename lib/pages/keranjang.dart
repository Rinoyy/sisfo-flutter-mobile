import 'package:flutter/material.dart';
import '../pages/peminjaman_page.dart';

class KeranjangPage extends StatelessWidget {
  KeranjangPage({super.key});

  final List<Map<String, dynamic>> keranjangList = [
    {
      "id": 1,
      "name": "Laptop Asus",
      "codeUnit": "UNIT001",
      "category": {"name": "Elektronik"},
    },
    {
      "id": 2,
      "name": "Proyektor Epson",
      "codeUnit": "UNIT002",
      "category": {"name": "Elektronik"},
    },
    {
      "id": 3,
      "name": "Proyektor Epson",
      "codeUnit": "UNIT002",
      "category": {"name": "Elektronik"},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Keranjang")),
      body: ListView.builder(
        itemCount: keranjangList.length,
        itemBuilder: (context, index) {
          final item = keranjangList[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['category']['name']),
            trailing: Text(item['codeUnit']),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PeminjamanPage(itemUnit: keranjangList),
              ),
            );
          },
          child: Text("Pinjam Semua Barang"),
        ),
      ),
    );
  }
}
