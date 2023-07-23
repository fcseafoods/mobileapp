import 'package:fcfreshfoods/screens/LoginScreen.dart';
import 'package:fcfreshfoods/screens/cartpage.dart';
import 'package:fcfreshfoods/screens/favoritepage.dart';
import 'package:fcfreshfoods/screens/home_page.dart';
import 'package:fcfreshfoods/screens/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
    routes: {
      "/home":(context) => HomePage(),
      "/loginpage":(context) => LoginScreen(),
      "/cart":(context) => Cartpage(),
      "/orders":(context) => OrderPage(),
      "/favorites":(context) => MyFavorites()
    },
  ));  
}
  