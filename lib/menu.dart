import 'package:flutter/material.dart';
import 'package:newapp/datamenu.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'ข้าวผัดไข่ ซาบะย่าง และผักสลัด',
      'image': 'assets/menu1.jpg',
      'rating': 4.5,
      'price': 100, // เพิ่มราคา
    },
    {
      'name': 'ผัดถั่วงอกใส่เต้าหู้',
      'image': 'assets/menu2.jpg',
      'rating': 4.0,
      'price': 69, // เพิ่มราคา
    },
    {
      'name': 'สลัดอกไก่โรยงา กินคู่กับน้ำสลัดญี่ปุ่น',
      'image': 'assets/menu3.jpg',
      'rating': 5.0,
      'price': 89, // เพิ่มราคา
    },
    {
      'name': 'อกไก่ลวกกับผักต่างๆ กินคู่กับน้ำจิ้มสุกี้',
      'image': 'assets/menu4.jpg',
      'rating': 4.8,
      'price': 89, // เพิ่มราคา
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _filteredMenuItems;

  @override
  void initState() {
    super.initState();
    _filteredMenuItems = menuItems;
    _searchController.addListener(_filterMenuItems);
  }

  void _filterMenuItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMenuItems = menuItems
          .where((item) => item['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Color.fromRGBO(30, 30, 30, 1), // สีพื้นหลัง
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ค้นหาเมนู...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMenuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(_filteredMenuItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DataMenuScreen(item: item),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                item['image']!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          i < item['rating']! ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 16,
                        ),
                      SizedBox(width: 8.0),
                      Icon(Icons.motorcycle, size: 16, color: Colors.grey),
                    ],
                  ),
                  SizedBox(height: 4.0), // ระยะห่าง
                  Text(
                    'ราคา: ${item['price']} บาท', // แสดงราคา
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

