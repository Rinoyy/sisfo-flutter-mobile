import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // jangan lupa import ini
import '../services/api_auth.dart';
import '../main.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nipdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final nipd = nipdController.text;
    final password = passwordController.text;

    final token =
        await ApiAuth.login(nipd, password); // pastikan apiService terdefinisi

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Login')),
        body: Stack(children: [
      SizedBox.expand(
          child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
        child: Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
        ),
      )),
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              width: double.infinity,
              // color: const Color.fromRGBO(255, 255, 255, 1),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: nipdController,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'NIPD',
                        fillColor: Colors.white.withOpacity(0.8),
                        hintText: 'Masukkan NIPD kamu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                        onPressed: _handleLogin, child: const Text('Login')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
