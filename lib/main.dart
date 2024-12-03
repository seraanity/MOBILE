import 'package:flutter/material.dart';
import 'package:njajanz/Pages/CartPage.dart';
import 'package:njajanz/Pages/HomePage.dart';
import 'package:njajanz/Pages/ItemPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Njajanz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F3),
      ),
      routes: {
        "/": (context) => HomePage(),
        "CartPage": (context) => CartPage(),
        "ItemPage": (context) => ItemPage(),
      },
    );
  }
}
