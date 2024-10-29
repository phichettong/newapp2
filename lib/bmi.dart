import 'package:flutter/material.dart';

class BmiCalculatorScreen extends StatefulWidget {
  @override
  _BmiCalculatorScreenState createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _result = '';
  String _category = '';

  void _calculateBmi() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text)! / 100; // แปลงเป็นเมตร

    if (weight != null && height != null && height > 0) {
      double bmi = weight / (height * height);
      setState(() {
        _result = 'BMI: ${bmi.toStringAsFixed(2)}';
        // กำหนดเกณฑ์ BMI
        if (bmi < 18.5) {
          _category = 'ผอมเกินไป';
        } else if (bmi >= 18.5 && bmi < 24.9) {
          _category = 'น้ำหนักปกติ';
        } else if (bmi >= 25 && bmi < 29.9) {
          _category = 'อ้วน';
        } else {
          _category = 'อ้วนมาก';
        }
      });
    } else {
      setState(() {
        _result = 'กรุณากรอกข้อมูลที่ถูกต้อง';
        _category = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // ให้เต็มความสูงของหน้าจอ
        decoration: BoxDecoration(
          color: Color.fromRGBO(30, 30, 30, 1),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // กรอบสำหรับรูปภาพ
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/bmi1.png',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                // ช่องกรอกน้ำหนัก
                _buildTextField(
                  controller: _weightController,
                  label: 'น้ำหนัก (kg)',
                ),
                SizedBox(height: 16.0),

                // ช่องกรอกส่วนสูง
                _buildTextField(
                  controller: _heightController,
                  label: 'ส่วนสูง (cm)',
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: _calculateBmi,
                  child: Text('คำนวณ BMI'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  _result,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  _category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }
}
