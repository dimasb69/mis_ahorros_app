import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/savings.dart';
import 'functions.dart';

final nameControler = TextEditingController();
final fechaControler = TextEditingController();
final montoControler = TextEditingController();
final depositoControler = TextEditingController();
var d = DateTime.now();
late DateTime? newDateF;
var dateBox = '${d.day}/${d.month}/${d.year}';
var iDate = d.day;
var iMonth = d.month;
var iYear = d.year;
const miUrl = 'https://momdontgo.dev';

Widget boxW(
    String name,
    color,
    int monto,
    int ahorro,
    String fecha,
    int resta,
    int index,
    Widget remove,
    Widget edit,
    Widget deposit,
    Widget retirar) {
  var valor = (((ahorro) * 100) / (monto)).toInt();
  var _value = (valor / 100);
  var split = dateSplit(fecha);
  final date1 = DateTime.utc(
      int.parse(split[2]), int.parse(split[1]), int.parse(split[0]), 0, 0, 0);
  final date2 = DateTime.utc(d.year, d.month, d.day, 0, 0, 0);
  final difference = date1.difference(date2);
  final calculoR = monto - ahorro;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 750),
      opacity: startAnimation ? 1.0 : 0.1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: screenWidth,
        height: 230,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color.fromARGB(211, 92, 103, 92)),
            color: const Color.fromARGB(160, 90, 140, 90)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: (screenWidth - 110),
                    height: 195,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        dataBox(name, monto.toString(), calculoR.toString(),
                            fecha, ahorro.toString(), index, difference.inDays),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 6),
                          alignment: Alignment.centerRight,
                          height: 160,
                          width: 65,
                          child: LiquidLinearProgressIndicator(
                            value: _value,
                            // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Color(int.parse(color))),
                            // Defaults to the current Theme's accentColor.
                            backgroundColor: Color.fromARGB(103, 231, 159, 76),
                            // Defaults to the current Theme's backgroundColor.
                            borderColor: Color.fromARGB(139, 222, 220, 220),
                            borderWidth: 1.0,
                            borderRadius: 10.0,
                            direction: Axis.vertical,
                            center: estrella100(_value),
                            // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                          ),
                        ),
                        Text('${valor}%',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.yellow)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  edit,
                  deposit,
                  retirar,
                  remove,
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget dataBox(name, monto, resta, fecha, ahora, index, dif) {
  var montDias = num.parse((int.parse(resta) / (dif + 1)).toStringAsFixed(2));
  Color ct = const Color(0xEC000000);
  return Container(
    width: 300,
    height: 180,
    margin: const EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
        color: Color.fromARGB(136, 190, 188, 188),
      ),
      //color: const Color(0x844E4F4B)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: ct, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Meta: ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$monto ${currencyType.text}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ct),
                  ),
                  const SizedBox(width: 25),
                  Text(
                    "Restan: ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$resta ${currencyType.text}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ct),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fecha Limite:  ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    fecha,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ct),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Faltan:  ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: ct, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${dif + 1} Dias",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ct),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Montos necesarios para completar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Diario: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: ct,
                                fontWeight: FontWeight.bold,
                                fontSize: 9),
                          ),
                          Text(
                            '$montDias ${currencyType.text}',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: ct, fontSize: 9),
                          ),
                        ],

                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Semanal: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: ct,
                                fontWeight: FontWeight.bold,
                                fontSize: 9),
                          ),
                          Text(
                            "${num.parse((montDias * 7).toStringAsFixed(2))} ${currencyType.text}",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: ct, fontSize: 9),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mensual: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: ct,
                                fontWeight: FontWeight.bold,
                                fontSize: 9),
                          ),
                          Text(
                            "${num.parse((montDias * 30).toStringAsFixed(2))} ${currencyType.text}",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: ct, fontSize: 9),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ahorrado:  ",
                textAlign: TextAlign.start,
                style: TextStyle(color: ct, fontWeight: FontWeight.bold),
              ),
              Text(
                ahora,
                textAlign: TextAlign.center,
                style: TextStyle(color: ct),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget nameW() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: nameControler,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.add_card, color: Colors.black),
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

Widget currencyNew() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller:newCurrencyType,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.add_card, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 10,
            style: BorderStyle.solid,
          ),
        ),
        hintText: "ejemplo: \$ ó USD",
        hintStyle: const TextStyle(color: Colors.black, fontSize: 10),
        fillColor: Colors.white38,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}

Widget dateW(context) {
  fechaControler.text = dateBox;
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
              lastDate: DateTime(iYear + 50, 12, 31));
          if (newDate2 != null) {
            if (newDate2.day >= 0) {
              dateBox = '${newDate2.day}/${newDate2.month}/${newDate2.year}';
              fechaControler.text = dateBox;
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

Widget amountW() {
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
        prefixIcon: const Icon(Icons.money_off, color: Colors.black),
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

Widget addition(String tittle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: depositoControler,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.money_off, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 10,
            style: BorderStyle.solid,
          ),
        ),
        hintText: tittle,
        hintStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.white38,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}

Widget bottomDevName() {
  return SizedBox(
    height: 20,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(miUrl);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Text('Developed',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xA6111111),
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(miUrl);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Text(' By {MomDontGo.Dev}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xA6111111),
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget estrella100(value) {
  if (value == 1.0) {
    return Container(
      alignment: Alignment.center,
      child: const DelayedDisplay(
        slidingCurve: Curves.fastEaseInToSlowEaseOut,
        delay: Duration(milliseconds: 600),
        child: Icon(
          Icons.star,
          size: 30,
          color: Colors.yellow,
        ),
      ),
    );
  } else {
    return SizedBox();
  }
}
