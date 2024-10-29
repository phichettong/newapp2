import 'dart:ui'; // ต้องนำเข้าเพื่อใช้ BackdropFilter
import 'package:flutter/material.dart';
import 'package:newapp/home.dart';
import 'home.dart'; // นำเข้า HomeScreen

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  // ฟิลด์กรอกชื่อผู้ใช้
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // สีพื้นหลัง
                      borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                    ),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                  // ฟิลด์กรอกรหัสผ่าน
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // สีพื้นหลัง
                      borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                    onPressed: () {
                      // ตรวจสอบว่ารหัสผ่านไม่ว่างเปล่า
                      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter username and password'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // นำไปสู่หน้า Home
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Implement register logic here
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
