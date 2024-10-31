import 'package:flutter/material.dart';

class DataMenuScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  DataMenuScreen({required this.item});

  @override
  _DataMenuScreenState createState() => _DataMenuScreenState();
}

class _DataMenuScreenState extends State<DataMenuScreen> {
  // สร้างตัวแปรเพื่อเก็บสถานะของ radio button
  int? _selectedOption;
  final TextEditingController _additionalInfoController = TextEditingController();

  // รายชื่อของตัวเลือกและราคา
  List<Map<String, dynamic>> _options = [
    {'title': 'หมู', 'price': 5},
    {'title': 'ไก่', 'price': 5},
    {'title': 'กุ้ง', 'price': 10},
    {'title': 'ปลา', 'price': 10},
  ];

  void _confirmOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการสั่งซื้อ'),
          content: Text('คุณต้องการสั่งซื้อ ${widget.item['name']} หรือไม่? ข้อมูลเพิ่มเติม: ${_additionalInfoController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดกล่องยืนยัน
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดกล่องยืนยัน
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('สั่งซื้อ ${widget.item['name']} เรียบร้อยแล้ว!')),
                );
              },
              child: Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name']),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView( // ใช้ SingleChildScrollView เพื่อให้เลื่อนลงได้
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // รูปภาพ
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                widget.item['image'],
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // ชื่อเมนู
            Text(
              widget.item['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // รายละเอียดเพิ่มเติม
            Text(
              "รายละเอียดเพิ่มเติมเกี่ยวกับเมนูนี้ สามารถเลือกเปลี่ยนได้",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // ช่องติ๊กเลือก
            Text(
              'เลือกส่วนผสมเพิ่มเติม:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: List.generate(_options.length, (index) {
                return RadioListTile<int>(
                  title: Text('${_options[index]['title']} +${_options[index]['price']}'),
                  value: index,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value; // อัปเดตสถานะเมื่อมีการเลือก
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            // ฟิลด์กรอกข้อมูลเพิ่มเติม
            Text(
              'ข้อมูลเพิ่มเติม:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _additionalInfoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'กรุณาใส่ข้อมูลเพิ่มเติม',
              ),
            ),
            SizedBox(height: 20), // เพิ่มระยะห่าง
            // ปุ่มสั่งซื้อ
            Center(
              child: ElevatedButton(
                onPressed: _confirmOrder, // เรียกใช้ฟังก์ชันยืนยันการสั่งซื้อ
                child: Text('สั่งซื้อ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
