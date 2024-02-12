import 'dart:ffi';
import 'dart:ui';

class data{
  late String? name;
  late int monto;
  late String? date;
  late int val_actual;
  late int resta;
  late Color? color;
  data(this.name, this.monto, this.date, this.val_actual, this.resta, this.color){
    name=name;
    monto=monto;
    date = date;
    val_actual = val_actual;
    resta = resta;
    color = color;
  }
}