import 'package:flutter/material.dart';
import 'login.dart'; // นำเข้า login_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // เรียกใช้งานหน้าล็อกอินจาก login_page.dart
      debugShowCheckedModeBanner: false, // ซ่อน debug banner
    );
  }
}