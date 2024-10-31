import 'dart:ui'; // ต้องนำเข้าเพื่อใช้ BackdropFilter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/add_page.dart';
import 'package:newapp/home.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();

    if (email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // ตรวจสอบใน Firestore
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('อีเมล', isEqualTo: email)
          .where('เบอร์โทร', isEqualTo: phone)
          .get();

      if (result.docs.isNotEmpty) {
        // หากพบผู้ใช้
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // หากไม่พบผู้ใช้
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or phone number'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // จัดการข้อผิดพลาดการเชื่อมต่อ Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // ใส่ path ของภาพที่นี่
                fit: BoxFit.cover, // ปรับภาพให้เต็มพื้นที่
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // เบลอพื้นหลัง
            child: Container(
              color: Colors.black.withOpacity(0.5), // ทำให้มืดลง
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // โลโก้
                  ClipOval(
                    child: Image.asset(
                      'assets/logo.jpg', // ใส่ path ของโลโก้ที่นี่
                      width: 150.0, // ขนาดโลโก้
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.0), // เพิ่มระยะห่างใต้โลโก้
                  // ฟิลด์กรอกอีเมล
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // สีพื้นหลัง
                      borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey), // สีข้อความ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                          borderSide: BorderSide.none, // ซ่อนกรอบ
                        ),
                        filled: true,
                        fillColor: Colors.white, // สีพื้นหลังของ TextField
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // ฟิลด์กรอกเบอร์โทร
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // สีพื้นหลัง
                      borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                    ),
                    child: TextField(
                      controller: phoneController,
                      obscureText: true, // ทำให้แสดงเป็นดอกจัน
                      decoration: InputDecoration(
                        labelText: 'Phone Number ',
                        labelStyle: TextStyle(color: Colors.grey), // สีข้อความ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                          borderSide: BorderSide.none, // ซ่อนกรอบ
                        ),
                        filled: true,
                        fillColor: Colors.white, // สีพื้นหลังของ TextField
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // สีพื้นหลังของปุ่ม
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // ขนาดปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                      ),
                    ),
                    onPressed: () => _login(context),
                    child: Text('Login'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // นำไปสู่หน้า Register
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPage()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.green), // เปลี่ยนสีข้อความ
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
