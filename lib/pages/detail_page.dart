import 'package:flutter/material.dart';
import '../models/item_unit.dart';
import '../pages/peminjaman_page.dart';
import '../pages/peminjaman_page.dart';
import '../pages/keranjang.dart';

class DetailPage extends StatelessWidget {
  final ItemUnit itemUnit;

  const DetailPage({Key? key, required this.itemUnit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Barang')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/tb.png',
                        height: 180,
                        width: 350,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 370,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Halo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${itemUnit.codeUnit}',
                          style:
                              TextStyle(color: Color(0xFF4488B7), fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${itemUnit.category?.name ?? 'Unknown Category'}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: const Color(0x484488B7),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: const Text(
                                  'Ready',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF485777),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -3),
            blurRadius: 6,
          )
        ]),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PeminjamanPage(itemUnit: [
                      {
                        'id': itemUnit.id,
                        'name': 'Halo',
                        'stock': 10,
                        'kategori':
                            itemUnit.category.name ?? 'Unknown Category',
                        'codeUnit': itemUnit.codeUnit,
                      }
                    ]),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4488B7),
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pinjam barang'),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        width: 400,
                        height: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Image.asset(
                                  'assets/images/tb.png',
                                  width: 150,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${itemUnit.item.name ?? 'unknow'}'),
                                      Text("IN-001"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PeminjamanPage(
                                                    itemUnit: itemUnit)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4488B7),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Pinjam barang'),
                                ),
                                OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Color(0xFF4488B7)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text("tambah keranjang"))
                              ],
                            ),
                          ],
                        ));
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 50),
                side: const BorderSide(color: Color(0xFF4488B7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: ElevatedButton(
                child: Text("tambah keranjang"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KeranjangPage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
