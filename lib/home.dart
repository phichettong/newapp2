import 'package:flutter/material.dart';
import 'package:newapp/fruity.dart';
import 'package:newapp/menu.dart';
import 'package:newapp/bakery.dart';
import 'package:newapp/bmi.dart';
import 'package:newapp/edit.dart'; // นำเข้าไฟล์ edit.dart
import 'package:newapp/login.dart'; // นำเข้าไฟล์ login.dart

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'User Name'; // ชื่อผู้ใช้
  String userEmail = 'user@example.com'; // อีเมลผู้ใช้
  String userAddress = 'User Address'; // ที่อยู่ผู้ใช้

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName, style: TextStyle(color: Colors.black)),
              accountEmail: Text(userEmail, style: TextStyle(color: Colors.black)),
              decoration: BoxDecoration(color: Colors.grey), // เปลี่ยนสีพื้นหลังของส่วนหัว
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  userName[0], // แสดงตัวอักษรแทนภาพผู้ใช้
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () async {
                // นำไปยังหน้าจอแก้ไขข้อมูล
                final updatedInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(
                      name: userName,
                      email: userEmail,
                      address: userAddress,
                    ),
                  ),
                );

                if (updatedInfo != null) {
                  setState(() {
                    userName = updatedInfo['name'];
                    userEmail = updatedInfo['email'];
                    userAddress = updatedInfo['address'];
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // ปิด Drawer
                // นำไปยังหน้า Login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // เปลี่ยนเป็น LoginScreen
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black, // เปลี่ยนพื้นหลังของ Body เป็นสีดำ
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: [
                _buildMenuButton(context, 'assets/eat.jpg', Icons.fastfood, 'Menu', MenuScreen()), // เปลี่ยนที่นี่
                _buildMenuButton(context, 'assets/fruits.jpg', Icons.local_drink, 'Fruity', FruityScreen()), // เปลี่ยนที่นี่
                _buildMenuButton(context, 'assets/bakery.jpg', Icons.bakery_dining, 'Bakery', BakeryScreen()), // เปลี่ยนที่นี่
                _buildMenuButton(context, 'assets/bmi.jpg', Icons.monitor_weight, 'BMI', BmiCalculatorScreen()), // เปลี่ยนที่นี่
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String imagePath, IconData icon, String label, Widget nextPage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage), // นำไปยังหน้าที่ระบุ
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage), // นำไปยังหน้าที่ระบุ
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              SizedBox(width: 8.0),
              Text(label, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}
