import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import '../main.dart';



final nameControler = TextEditingController();
final fechaControler = TextEditingController();
final montoControler = TextEditingController();
var d = DateTime.now();
var _date = '${d.day}/${d.month}/${d.year}';
var iDate = d.day;
var iMonth = d.month;
var iYear = d.year;


Widget cuadro(String name, color, int monto, int ahorro,String fecha, int resta, int index, Widget remove) {
  var valor = (((ahorro)*100)/(monto)).toInt();
  var _value = (valor/100);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: startAnimation ? 1.0 : 0.1,
      child: Container(
        width: screenWidth,
        height: 175,
        decoration: BoxDecoration (
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black87,),
            color: const Color(0x844E4F4B)
        ),
        child: Column(
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
                      data_cuadro(name, monto.toString(), resta.toString(), fecha, ahorro.toString(), index),
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
            remove
          ],
        ),
      ),
    ),
  );
}


Widget data_cuadro (name, monto, resta, fecha, ahora, index){
  Color ct = const Color(0xEC000000);
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

Widget nameW() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: nameControler,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon:
        const Icon(Icons.account_circle_outlined, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 10,
            style: BorderStyle.solid,
          ),
        ),
        hintText: "Motivo",
        hintStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.white38,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}


Widget fechaW(context) {
  fechaControler.text = _date;
  var dp = DateTime.now();
  DateTime dateInit = DateTime(dp.year, dp.month, dp.day);
  return Expanded(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 8.0, right: 8, bottom: 8.0),
      child: TextFormField(
        onTap: () async {
          DateTime? newDate2 = await showDatePicker(
              context: context,
              initialDate: dateInit,
              firstDate: DateTime(iYear, iMonth, iDate),
              lastDate: DateTime(2050, 12, 31));
          if (newDate2 != null) {
            if (newDate2.day >= 0) {
              _date = '${newDate2.day}/${newDate2.month}/${newDate2.year}';
              fechaControler.text = _date;
              FocusScope.of(context).requestFocus(FocusNode());
            }
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
          FilteringTextInputFormatter.singleLineFormatter
        ],
        decoration: InputDecoration(
          labelText: "Fecha Limite",
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 10,
              style: BorderStyle.solid,
            ),
          ),
          hintText: "End Date",
          hintStyle: const TextStyle(color: Colors.black54),
          fillColor: Colors.white38,
          filled: true,
        ),
        style: const TextStyle(color: Colors.black),
        controller: fechaControler,
      ),
    ),
  );
}

Widget montoW() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: montoControler,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        prefixIcon:
        const Icon(Icons.account_circle_outlined, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 10,
            style: BorderStyle.solid,
          ),
        ),
        hintText: "Monto",
        hintStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.white38,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}