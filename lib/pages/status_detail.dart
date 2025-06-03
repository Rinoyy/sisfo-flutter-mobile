import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/peminjaman.dart';

class DetailPengembalian extends StatelessWidget {
  final Peminjaman peminjaman;
  final hiddenStatuses = {
    'PENGAJUAN',
    'PENGAJUAN_PENGEMBALIAN',
    'SELESAI',
    'DITOLAK',
  };

  

  DetailPengembalian({Key? key, required this.peminjaman}) : super(key: key);

  Future<void> _submitReturn(BuildContext context) async {
    final itemsIdList = peminjaman.loanDetails
        .map((detail) => detail.itemUnit?.id)
        .whereType<int>()
        .toList();


    final Map<String, dynamic> body = {
      "borrowingId": peminjaman.id,
      "idAchiver": 1,
      "itemCondition": 1,
      "returnDate": peminjaman.returnDate.toIso8601String(),
      "itemId": itemsIdList,
      "status": "PENGAJUAN_PENGEMBALIAN",
      "locationId": 1,
      "userId": peminjaman.userId,
    };

    final url = Uri.parse('http://localhost:5000/api/returns');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pengembalian telah dikirim!')),
        );
      } else {
        print('Submit gagal: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submit: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final jumlahBarang = peminjaman.loanDetails.length;
    final tanggalPinjam = peminjaman.loanDate.toLocal();
    const dummyAdmin = "Yuli Sarah";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengembalian barang'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Pesanan dipinjam',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah barang'),
                Text('$jumlahBarang barang'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tanggal Peminjaman'),
                Text(
                    '${tanggalPinjam.day} Februari ${tanggalPinjam.year}, ${tanggalPinjam.hour}:${tanggalPinjam.minute.toString().padLeft(2, '0')}'),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Info peminjaman',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Admin'),
                Text('Yuli Sarah'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tanggal Peminjaman'),
                Text(
                    '${tanggalPinjam.day} Februari ${tanggalPinjam.year}, ${tanggalPinjam.hour}:${tanggalPinjam.minute.toString().padLeft(2, '0')}'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Daftar Barang',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...peminjaman.loanDetails.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final detail = entry.value;
              final itemUnit = detail.itemUnit;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/tb.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Barang ke-$index',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          Text(itemUnit?.name ?? 'Barang tidak diketahui'),
                        ],
                      ),
                    ),
                    if (itemUnit != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          itemUnit.codeUnit,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              );
            }),
            if (!hiddenStatuses.contains(peminjaman.status)) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _submitReturn(context),
                icon: const Icon(Icons.send),
                label: const Text('Kirim Pengembalian'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
