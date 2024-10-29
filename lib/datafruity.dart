import 'package:flutter/material.dart';

class DataFruityScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  DataFruityScreen({required this.item});

  @override
  _DataFruityScreenState createState() => _DataFruityScreenState();
}

class _DataFruityScreenState extends State<DataFruityScreen> {
  // สร้างตัวแปรเพื่อเก็บสถานะของ checkboxes
  List<bool> _selectedOptions = List.generate(4, (index) => false); // จำนวนตัวเลือกที่แก้ไขเป็น 4

  // รายชื่อของตัวเลือก
  List<String> _optionTitles = [
    'มะละกอ',
    'ส้ม',
    'องุ่น',
    'แคนตาลูป',
  ];

  void _confirmOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการสั่งซื้อ'),
          content: Text('คุณต้องการสั่งซื้อ ${widget.item['name']} หรือไม่?'),
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
      body: Padding(
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
              "รายละเอียดเพิ่มเติมเกี่ยวกับเมนูนี้ เช่น ส่วนผสมหรือวิธีการทำ...",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // ช่องติ๊กเลือก
            Text(
              'เลือกส่วนผสมเพิ่มเติม:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: List.generate(_optionTitles.length, (index) {
                return CheckboxListTile(
                  title: Text(_optionTitles[index]), // แสดงตัวเลือกตามรายชื่อ
                  value: _selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedOptions[index] = value!;
                    });
                  },
                );
              }),
            ),
            Spacer(), // ขยายพื้นที่ให้ปุ่มอยู่ด้านล่าง
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
