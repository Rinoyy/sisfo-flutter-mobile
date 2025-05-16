import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeminjamanPage extends StatefulWidget {
  final itemUnit;
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

  @override
  void initState() {
    super.initState();
    _idBarangController.text = widget.itemUnit.id.toString();
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
    final barang = _idBarangController.text;

    final body = {
      "jam": jam,
      "return_date": tanggal,
      "reason": reason,
      "status": "PENGAJUAN",
      "items_id": [_idBarangController.text],
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
    return Scaffold(
      appBar: AppBar(title: Text("Form Peminjaman")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Row(
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.itemUnit.item.name}',
                              ),
                              Container(
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Color(0x484488B7),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Text(
                                        '${widget.itemUnit.codeUnit}',
                                        style: TextStyle(
                                            color: Color(0xFF4488B7),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${widget.itemUnit.category.name}',
                        ),
                      ],
                    )),
                  ],
                ),
              ),
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
                          InputDecoration(labelText: 'waktu Pengembalian'),
                      onTap: _pickTime,
                    ),
                    TextFormField(
                      controller: _idBarangController,
                      decoration: InputDecoration(labelText: 'barang'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
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
          )),
    );
  }
}
