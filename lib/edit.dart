import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String email;

  EditScreen({required this.name, required this.email, required String address});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _address = "Select Location on Map"; // ค่าที่อยู่เริ่มต้น

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(controller: _nameController, label: 'Name'),
            SizedBox(height: 16),
            _buildTextField(controller: _emailController, label: 'Email'),
            SizedBox(height: 16),

            // แสดงที่อยู่และปุ่มสำหรับไปยังหน้าแผนที่
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
                title: Text(_address, style: TextStyle(fontSize: 16)),
                trailing: ElevatedButton(
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
                  child: Text('Select'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // บันทึกข้อมูลที่แก้ไข
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'email': _emailController.text,
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

  Widget _buildTextField({required TextEditingController controller, required String label}) {
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
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}

class MapSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Map will be displayed here',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Sample Address"); // ส่งค่าที่อยู่กลับไป
              },
              child: Text('Select Sample Location'),
            ),
          ],
        ),
      ),
    );
  }
}
