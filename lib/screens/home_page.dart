import 'package:fcfreshfoods/screens/category_product.dart';
import 'package:fcfreshfoods/screens/categorypage.dart';
import 'package:fcfreshfoods/screens/dashboard.dart';
import 'package:fcfreshfoods/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'offers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentitem = 0;

  List<Widget> pages = [Dashboard(), CategoryPage(), Offers(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentitem],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentitem,
        onTap: (value) {
          setState(() {
            _currentitem = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.discount), label: "Offers"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profiles"),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
