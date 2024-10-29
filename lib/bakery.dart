import 'package:flutter/material.dart';

class BakeryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'เกรีกโยเกิร์ตชาเขียว ซอยมิลค์พลัส',
      'image': 'assets/b1.jpg',
      'rating': 4.5,
    },
    {
      'name': 'ทาร์ตโยเกิร์ตผลไม้รวม ฟรุตตี้เลิฟเวอร์',
      'image': 'assets/b2.jpg',
      'rating': 4.0,
    },
    {
      'name': 'กราโนล่าบาร์ ซิกเนเจอร์มิกซ์',
      'image': 'assets/b3.jpg',
      'rating': 5.0,
    },
    {
      'name': 'บราวนีฟักทอง โรยถั่วและผลไม้แห้ง',
      'image': 'assets/b4.jpg',
      'rating': 4.8,
    },
    {
      'name': 'เค้กวีแกนสามชั้น ครัมเบิ้ลมิกซ์',
      'image': 'assets/b5.jpg',
      'rating': 4.8,
    },
    {
      'name': 'คุกกี้ข้าวโอ๊ตทรัฟเฟิล่',
      'image': 'assets/b6.jpg',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakery Menu'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        color: Color.fromRGBO(30, 30, 30, 1),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6, // ปรับค่าให้เหมาะสม
            crossAxisSpacing: 10.0, // เพิ่มระยะห่าง
            mainAxisSpacing: 10.0,  // ลดระยะห่าง
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return _buildMenuItem(context, menuItems[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      color: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: item['image'] != ''
                  ? Image.asset(
                item['image'],
                width: double.infinity,
                height: 100, // ปรับขนาดให้เล็กลง
                fit: BoxFit.cover,
              )
                  : Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'ไม่มีรูปภาพ',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            item['name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  i < item['rating'] ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 16,
                ),
            ],
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              _showOrderDialog(context, item['name']);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            child: Text(
              'สั่งซื้อ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDialog(BuildContext context, String? itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('สั่งซื้อ'),
          content: Text('คุณต้องการสั่งซื้อ $itemName หรือไม่?'),
          actions: [
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('สั่งซื้อ $itemName สำเร็จ')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
