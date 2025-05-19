import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeminjamanPage extends StatefulWidget {
  final dynamic itemUnit;
  const PeminjamanPage({Key? key, required this.itemUnit}) : super(key: key);

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _idBarangController = TextEditingController();

  List<int> _itemsId = [];

  @override
  void initState() {
    super.initState();

    if (widget.itemUnit is List) {
      _itemsId = (widget.itemUnit as List)
          .where((item) => item != null && item['id'] != null) 
          .map((item) => item['id'] as int)
          .toList();
    } else {
      if (widget.itemUnit != null && widget.itemUnit['id'] != null) {
        _itemsId = [widget.itemUnit['id'] as int];
      } else {
        _itemsId = [];
      }
    }

    _idBarangController.text = _itemsId.join(', ');
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = picked.toIso8601String();
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _timeController.text = picked.format(context);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final reason = _reasonController.text;
    final tanggal = _dateController.text;
    final jam = _timeController.text;

    final body = {
      "jam": jam,
      "return_date": tanggal,
      "reason": reason,
      "status": "PENGAJUAN",
      "items_id": _itemsId,
      "id_user": 1
    };

    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000/api/load"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil disimpan')),
        );
      } else {
        print("Gagal: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: ${response.body}')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isList = widget.itemUnit is List;

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Tampilkan barang
              isList
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (widget.itemUnit as List).length,
                      itemBuilder: (context, index) {
                        final item = (widget.itemUnit as List)[index];
                        print(item);
                        return ListTile(
                          title: Text(item['name'] ?? 'tidak ada'),
                          subtitle:
                              Text(item['kategori'] ?? 'tidak ada'),
                          trailing: Text(item['codeUnit'] ?? 'Tidak ada nama'),
                        );
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/tb.png',
                          width: 150,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${widget.itemUnit['item']?['name'] ?? 'tidak ada'}'),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x484488B7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: Text(
                                      '${widget.itemUnit['kategori'] ?? 'tidak ada'}',
                                      style: TextStyle(
                                          color: Color(0xFF4488B7),
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  '${widget.itemUnit['category']['name'] ?? 'tidak ada'}'),
                            ],
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: 20),

              // Form input
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _reasonController,
                      decoration: InputDecoration(labelText: 'Reason'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(labelText: 'Tanggal'),
                      onTap: _pickDate,
                    ),
                    TextField(
                      controller: _timeController,
                      readOnly: true,
                      decoration:
                          InputDecoration(labelText: 'Waktu Pengembalian'),
                      onTap: _pickTime,
                    ),
                    TextFormField(
                      controller: _idBarangController,
                      decoration: InputDecoration(labelText: 'Barang'),
                      readOnly: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Kirim"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
