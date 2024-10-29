import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map_selection_screen.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String email;

  EditScreen({required this.name, required this.email, required String phone, required String address});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController; // สำหรับหมายเลขโทรศัพท์
  String _address = "Select Location on Map"; // ค่าที่อยู่เริ่มต้น

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(); // กำหนดค่าเริ่มต้นสำหรับหมายเลขโทรศัพท์
    _loadData(); // โหลดข้อมูลเมื่อเริ่มต้น
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _phoneController.text = prefs.getString('phone') ?? '';
      _address = prefs.getString('address') ?? "Select Location on Map";
    });
  }

  Future<void> _saveData() async {
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
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.green), // ไอคอนที่อยู่
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

            ElevatedButton(
              onPressed: () {
                _saveData(); // บันทึกข้อมูลที่แก้ไข
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'phone': _phoneController.text, // เพิ่มหมายเลขโทรศัพท์
                  'address': _address,
                });
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
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
          prefixIcon: Icon(icon, color: Colors.green), // ไอคอนที่ด้านหน้า
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
