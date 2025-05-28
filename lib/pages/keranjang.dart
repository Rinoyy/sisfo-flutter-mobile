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
  @override
  List<KeranjangItem> _keranjang = [];

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

  Set<int> selectedItemIds = {};

  void _kirimPeminjaman() {
    final selectedItems = _keranjang
        .where((item) => selectedItemIds.contains(item.id))
        .map((item) => {
              'id': item.id,
              'id_user': item.idUser,
              'id_items_unit': item.idItemsUnit,
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _keranjang.length,
                itemBuilder: (context, index) {
                  final item = _keranjang[index];
                  return CheckboxListTile(
                    title: Text('ID: ${item.id}'),
                    subtitle:
                        Text('User: ${item.idUser}, Unit: ${item.idItemsUnit}'),
                    value: selectedItemIds.contains(item.id),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          selectedItemIds.add(item.id);
                        } else {
                          selectedItemIds.remove(item.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final selectedItems = _keranjang
                    .where((item) => selectedItemIds.contains(item.id))
                    .map((item) => {
                          'id': item.itemUnit.id,
                          'id_items_unit': item.idItemsUnit,
                          'kategori': item.itemUnit.name,
                          'name': item.itemUnit.category.name,
                          'codeUnit': item.itemUnit.codeUnit
                        })
                    .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PeminjamanPage(itemUnit: selectedItems),
                  ),
                );
              },
              child: const Text("Kirim Peminjaman"),
            )
          ],
        ));
  }
}
