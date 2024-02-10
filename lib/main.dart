import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Saving's List")),
        body: Container(
          height: 1200,
          width: 600,
          decoration: BoxDecoration(
              color: Colors.cyanAccent,
          ),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  cuadro('carro'),

                ],
              ),
            ),
          ),
        ));
  }
}

Widget cuadro(String texto) {
  return AnimatedContainer(
    color: Colors.grey,
    duration: const Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
    width: double.maxFinite,
    height: 200,
    child: FittedBox(
      fit: BoxFit.fitHeight,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.blue),
      ),
    ),
  );
}
