import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // นำเข้า Firestore
import 'package:shared_preferences/shared_preferences.dart';
import 'map_selection_screen.dart';

class EditScreen extends StatefulWidget {
  final String userId; // รับ userId สำหรับดึงข้อมูลจาก Firestore

  EditScreen({required this.userId, required String name, required String email, required String address, required String phone});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _address = "Select Location on Map"; // ค่าที่อยู่เริ่มต้น

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _loadData(); // เรียกใช้เพื่อโหลดข้อมูล
  }

  Future<void> _loadData() async {
    // โหลดข้อมูลจาก Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

    if (userDoc.exists) {
      setState(() {
        _nameController.text = userDoc['name'] ?? '';
        _emailController.text = userDoc['email'] ?? '';
        _phoneController.text = userDoc['phone'] ?? '';
        _address = userDoc['address'] ?? "Select Location on Map"; // หากมีที่อยู่ใน Firestore
      });
    }
  }

  Future<void> _saveData() async {
    // บันทึกข้อมูลที่แก้ไขใน Firestore
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _address,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(controller: _nameController, label: 'Name', icon: Icons.person),
              SizedBox(height: 16),
              _buildTextField(controller: _emailController, label: 'Email', icon: Icons.email),
              SizedBox(height: 16),
              _buildTextField(controller: _phoneController, label: 'Phone Number', icon: Icons.phone),
              SizedBox(height: 16),

              // แสดงที่อยู่พร้อมไอคอน
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Colors.green),
                  title: Text(_address, style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 8),

              // ปุ่มสำหรับไปยังหน้าแผนที่
              ElevatedButton(
                onPressed: () async {
                  final selectedAddress = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapSelectionScreen()),
                  );
                  if (selectedAddress != null) {
                    setState(() {
                      _address = selectedAddress; // อัปเดตที่อยู่
                    });
                  }
                },
                child: Text('Select Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),

              // ปุ่มสำหรับบันทึกข้อมูล
              ElevatedButton(
                onPressed: () {
                  // ตรวจสอบข้อมูลที่กรอก
                  if (_nameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty || _address == "Select Location on Map") {
                    // แสดงข้อความเตือนหากมีข้อมูลที่ยังไม่ได้กรอก
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    _saveData(); // บันทึกข้อมูลที่แก้ไข
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'phone': _phoneController.text,
                      'address': _address,
                    });
                  }
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )

      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}