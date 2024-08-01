import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class HoneycombScreen extends StatefulWidget {
  const HoneycombScreen({super.key});

  @override
  HoneycombScreenState createState() => HoneycombScreenState();
}

class HoneycombScreenState extends State<HoneycombScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '벌집',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      bottomNavigationBar: BottomNavigator(currentIndex: 3),
    );
  }
}
