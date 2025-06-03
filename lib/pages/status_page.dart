import 'package:flutter/material.dart';
import '../models/peminjaman.dart';
import '../services/loan_service.dart';
import 'detailPengembalian.dart';


class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  late Future<List<Peminjaman>> futureLoans;
  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    futureLoans = LoanService().fetchPeminjaman();
  }

  void main() {
    DateTime loanDateTime = DateTime.parse("2025-05-25 20:17:00.000");
    print(formatDate(loanDateTime));

    String loanDateString = "2025-05-25 20:17:00.000";
    print(formatDateFromString(loanDateString));
  }

  String formatDate(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  String formatDateFromString(String dateStr) {
    DateTime dt = DateTime.parse(dateStr);
    return formatDate(dt);
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Semua',
      'PENGAJUAN',
      'DIPINJAM',
      'PENGAJUAN_PENGEMBALIAN',
      'SELESAI',
      'DITOLAK'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Status"),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color:
                              isSelected ? Colors.black : Colors.grey.shade300,
                        ),
                        backgroundColor: isSelected
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black87
                              : Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: FutureBuilder<List<Peminjaman>>(
                  future: futureLoans,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Tidak ada data peminjaman'));
                    } else {
                      final filteredLoans = selectedCategory == 'Semua'
                          ? snapshot.data!
                          : snapshot.data!
                              .where((loan) => loan.status == selectedCategory)
                              .toList();

                      if (filteredLoans.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.inbox,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Data kosong',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tidak ada peminjaman dengan status ini.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 220,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: filteredLoans.length,
                        itemBuilder: (context, index) {
                          final loan = filteredLoans[index];
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPengembalian(peminjaman: loan),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/tb.png',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Tanggal pengembalian:\n${formatDate(loan.returnDate)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'Alasan:\n${loan.reason}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
