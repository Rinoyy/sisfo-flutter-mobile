import 'package:flutter/material.dart';
import 'package:sisfomobile/models/item_unit.dart';
import '../models/keranjang.dart';
import '../pages/peminjaman_page.dart';
import '../services/api_keranjang.dart';

class KeranjangPage extends StatefulWidget {
  KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<KeranjangItem> _keranjang = [];
  Set<int> selectedItemIds = {};

  @override
  void initState() {
    super.initState();
    testApi();
  }

  void testApi() async {
    try {
      final keranjang = await ApiKeranjang().fetchKeranjang();
      print('Data berhasil diambil:');
      for (var item in keranjang) {
        print(
            'ID: ${item.id}, User: ${item.idUser}, Unit: ${item.idItemsUnit}');
      }
      setState(() {
        _keranjang = keranjang;
      });
    } catch (e) {
      print('Gagal ambil data: $e');
    }
  }

  void _kirimPeminjaman() {
    final selectedItems = _keranjang
        .where((item) => selectedItemIds.contains(item.id))
        .map((item) => {
              'id': item.itemUnit.id,
              'id_items_unit': item.idItemsUnit,
              'kategori': item.itemUnit.name,
              'name': item.itemUnit.category.name,
              'codeUnit': item.itemUnit.codeUnit,
            })
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeminjamanPage(itemUnit: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Keranjang")),
      body: _keranjang.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _keranjang.length,
                    itemBuilder: (context, index) {
                      final item = _keranjang[index];
                      final isSelected = selectedItemIds.contains(item.id);

                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: Image.asset(
                            'assets/images/tb.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            'Kategori: ${item.itemUnit.category.name}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama: ${item.itemUnit.name}'),
                              Text('Code Unit: ${item.itemUnit.codeUnit}'),
                              Text('User ID: ${item.idUser}'),
                            ],
                          ),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (selected) {
                              setState(() {
                                if (selected == true) {
                                  selectedItemIds.add(item.id);
                                } else {
                                  selectedItemIds.remove(item.id);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed:
                        selectedItemIds.isEmpty ? null : _kirimPeminjaman,
                    icon: Icon(Icons.send),
                    label: Text("Kirim Peminjaman"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
