import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/data_model.dart';



final random = Random();
Color color_fondo (){
  Color _color_cuadro = Color.fromARGB(random.nextInt(254), random.nextInt(254), random.nextInt(254), 100);
  return _color_cuadro;
}

add_item (name, int monto, int ahora, fhecha) {
  contenido.add(data(name, monto, "25-05-2024", ahora, (monto-ahora), color_fondo()));
}

rem_item (index) {
  contenido.removeAt(index);
}