import 'package:flutter/material.dart';
import '../models/pengembalian.dart';
import '../services/loan_service.dart';
import '../models/peminjaman.dart'; // karena kita perlu akses toJson()

import 'detailPengembalian.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  _PengembalianPageState createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  final LoanService pengembalianService = LoanService();

  Future<List<Peminjaman>> _fetchLoanData() async {
    return await pengembalianService.fetchPeminjaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Pengembalian", style: TextStyle(fontSize: 20))),
      ),
      body: FutureBuilder<List<Peminjaman>>(
        future: _fetchLoanData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Data kosong'));
          }

          final data = snapshot.data!;
          final filteredData = data.where((loan) => loan.status != 'DITOLAK' && loan.status != 'SELESAI').toList();

          if (filteredData.isEmpty) {
            return const Center(child: Text('Data kosong'));
          }

          return ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: ListTile(
                  leading: const Icon(Icons.assignment_return),
                  title: Text('Tanggal Kembali: ${item.returnDate.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text('Status: ${item.status ?? "Tidak ada alasan"}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPengembalian(peminjaman: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
