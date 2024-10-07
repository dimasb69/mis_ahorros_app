
import 'package:flutter/material.dart';
import 'package:saving_control/pages/savings.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mis Ahorros',
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffa0bd95),
        ),
        scaffoldBackgroundColor: const Color(0xefffffff),
      ),
      home: const Savings()));
}

