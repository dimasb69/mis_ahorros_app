import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import 'functions.dart';



Widget cuadro(String name, color, int monto, int ahorro,String fecha, int resta) {
  var valor = (((ahorro)*100)/(monto)).toInt();
  var _value = (valor/100);
  print(_value);
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 300,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                data_cuadro(name, monto.toString(), resta.toString(), fecha, ahorro.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              alignment: Alignment.centerRight,
              height: 130,
              width: 75,
              child: LiquidLinearProgressIndicator(
                value: _value, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation( color ), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white38, // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.black87,
                borderWidth: 1.0,
                borderRadius: 10.0,
                direction: Axis
                    .vertical,
                center: Text('${valor}%', style: const TextStyle(fontSize: 24, color: Colors.yellow)),// The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
              ),
            ),
          ),
        ],
      ),
    ],
  );
}


Widget data_cuadro (name, monto, resta, fecha, ahora){
  Color ct = Color(0xEC000000);
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style:  TextStyle(color: ct, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Monto: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                ),

                Text(
                  monto,
                  textAlign: TextAlign.center,
                  style:  TextStyle(color: ct),
                ),
                const SizedBox(width: 25),
                Text(
                  "Resta: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                ),

                Text(
                  resta,
                  textAlign: TextAlign.center,
                  style:  TextStyle(color: ct),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Fecha estimada:  ",
              textAlign: TextAlign.start,
              style: TextStyle(color: ct, fontWeight: FontWeight.bold),
            ),

            Text(
              fecha,
              textAlign: TextAlign.center,
              style:  TextStyle(color: ct),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Ahorrado:  ",
              textAlign: TextAlign.start,
              style: TextStyle(color: ct, fontWeight: FontWeight.bold),
            ),

            Text(
              ahora,
              textAlign: TextAlign.center,
              style:  TextStyle(color: ct),
            ),
          ],
        ),
      ),
    ],
  );
}