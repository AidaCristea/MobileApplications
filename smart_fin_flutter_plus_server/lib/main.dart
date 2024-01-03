import 'package:flutter/material.dart';

import 'Screens/AllExpensesScreen.dart';
//import 'package:smart_fin_flutter/Screens/AllExpensesScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: Row(
            children: [
              Text(
                "SmartFin",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 9.0),
              Image(
                image: AssetImage("assets/flying-money-4385660-3640566.png"),
                width: 75,
                height: 75,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.green[100],
          child: Center(
            child: SizedBox(
              width: 100,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllExpensesScreen()));
                },
                child: Text(
                  "Start",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ));
  }
}
