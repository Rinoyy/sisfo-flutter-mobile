import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login_page.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token'); // hapus token
    await prefs.remove('userId');

    // pindah ke halaman LoginPage dan hilangkan halaman sebelumnya
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const Center(
        child: Text('ini akun'),
      ),
    );
  }
}
