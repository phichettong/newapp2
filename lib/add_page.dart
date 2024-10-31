import 'dart:ui'; // ต้องนำเข้าเพื่อใช้ BackdropFilter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    void _addUser() async {
      // ตรวจสอบว่าฟิลด์ไม่ว่าง
      if (nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          emailController.text.isNotEmpty) {

        // เพิ่มข้อมูลผู้ใช้ไปยัง Firestore
        await FirebaseFirestore.instance.collection('users').add({
          'ชื่อ': nameController.text,
          'เบอร์โทร': phoneController.text,
          'อีเมล': emailController.text,
        });

        // เคลียร์ข้อมูลในฟิลด์
        nameController.clear();
        phoneController.clear();
        emailController.clear();

        // แสดง SnackBar ยืนยัน
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เพิ่มผู้ใช้เรียบร้อย')),
        );

        // ปิดหน้าต่าง
        Navigator.pop(context);
      } else {
        // แสดง SnackBar ถ้าฟิลด์มีข้อมูลไม่ครบ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
        );
      }
    }

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
                  // ฟิลด์กรอกชื่อ
                  _buildTextField(controller: nameController, label: 'ชื่อ'),
                  SizedBox(height: 16.0),
                  // ฟิลด์กรอกเบอร์โทร
                  _buildTextField(controller: phoneController, label: 'เบอร์โทร', keyboardType: TextInputType.phone),
                  SizedBox(height: 16.0),
                  // ฟิลด์กรอกอีเมล
                  _buildTextField(controller: emailController, label: 'อีเมล', keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // สีพื้นหลังของปุ่ม
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // ขนาดปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                      ),
                    ),
                    onPressed: _addUser,
                    child: Text('เพิ่มผู้ใช้'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey), // สีข้อความ
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // มุมโค้ง
            borderSide: BorderSide.none, // ซ่อนกรอบ
          ),
          filled: true,
          fillColor: Colors.white, // สีพื้นหลังของ TextField
        ),
      ),
    );
  }
}
