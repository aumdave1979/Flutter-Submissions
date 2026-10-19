import 'package:flutter/material.dart';

class ElectricityBillCalculator extends StatefulWidget {
  ElectricityBillCalculator({super.key});

  @override
  State<ElectricityBillCalculator> createState() {
    return _ElectricityBillCalculator();
  }
}

class _ElectricityBillCalculator extends State<ElectricityBillCalculator> {
  final unitsController = TextEditingController();
  double totalBill = 0;

  void calculateBill() {
    if (unitsController.text.isEmpty) {
      return;
    }

    int units = int.parse(unitsController.text);
    double bill = 0;

    if (units <= 100) {
      bill = units * 5;
    } else if (units <= 200) {
      bill = (100 * 5) + ((units - 100) * 7);
    } else {
      bill = (100 * 5) + (100 * 7) + ((units - 200) * 10);
    }

    setState(() {
      totalBill = bill;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Electricity Bill Calculator',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                controller: unitsController,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: calculateBill,
                child: Text('Calculate'),
              ),
              SizedBox(height: 30),
              Text('Bill : $totalBill'),
            ],
          ),
        ),
      ),
    );
  }
}
