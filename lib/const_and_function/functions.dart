import 'dart:convert';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saving_control/const_and_function/widgets.dart';
import '../pages/savings.dart' show ListaData;
import '../models/data_model.dart';
import 'dart:io';

const csvName = "data.csv";

late String csv;
final random = Random();

backColor() {
  Color colorBar = Color.fromARGB(
      255, random.nextInt(250), random.nextInt(128), random.nextInt(250));
  return colorBar.value;
}

remItem(index) {
  ListaData.removeAt(index);
}

Future<void> addItem(context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "NUEVO",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 150,
            height: 270,
            child: Column(
              children: [
                dateW(context),
                nameW(),
                amountW(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (fechaControler.text != "" &&
                              nameControler.text != '' &&
                              montoControler.text != '') {
                            if (int.parse(montoControler.text) <= 0) {
                              alertError(context, 'El monto debe ser mayor a 0');
                            } else {
                              ListaData.add(DataList(
                                  nameControler.text,
                                  int.parse(montoControler.text),
                                  fechaControler.text,
                                  0,
                                  int.parse(montoControler.text),
                                  backColor()));
                              listToCSV(ListaData, context);
                              nameControler.clear();
                              fechaControler.clear();
                              montoControler.clear();
                              dateBox = '${d.day}/${d.month}/${d.year}';
                              Navigator.pop(context);
                            }
                          } else {
                            alertError(context, 'Debe incluir todos los campos correctamente');
                          }
                        },
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          nameControler.clear();
                          fechaControler.clear();
                          montoControler.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<void> alertError(BuildContext context, texto) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('ERROR'),
      content: Text('$texto'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Si');
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> listToCSV(List<DataList> lista, context) async {
  List<List<dynamic>> csvData = [
    <String>['name', 'monto', 'date', 'val-.actual', 'resta', 'color'],
    ...lista.map((item) => [
          item.name,
          item.monto,
          item.date,
          item.val_actual,
          item.resta,
          item.color.toString()
        ])
  ];
  csv = const ListToCsvConverter().convert(csvData);
  csv;
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/$csvName';
  final File file = File(path);

  var dataSaved = await file.writeAsString(csv);
  dataSaved;
  snackShow('Data Updated', context);
}

Future<void> csvRead(context) async {
  ListaData = [];
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/$csvName';
  final input = File(path).openRead();
  try {
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    fields;
    for (int i = 0; i < fields.length; i++) {
      if (i > 0) {
        final String name = fields[i][0].toString();
        final int amount = int.parse(fields[i][1].toString());
        final String date = fields[i][2].toString();
        final int valAtc = int.parse(fields[i][3].toString());
        final int minus = int.parse(fields[i][4].toString());
        final color = fields[i][5].toString();
        ListaData.add(
            DataList(name, amount, date, valAtc, minus, color));
        await sleepTime(250);
      }
    }
  } catch (e) {
    e;
  }
  //print('primer valor: ${fields.length}');
}

List dateSplit(String date) {
  var newDate = date.split('/');
  return newDate;
}

Future<void> editItem(context, index) async {
  nameControler.text = ListaData[index].name.toString();
  montoControler.text = ListaData[index].monto.toString();
  dateBox = ListaData[index].date.toString();
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "EDITAR",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 150,
            height: 270,
            child: Column(
              children: [
                dateW(context),
                nameW(),
                amountW(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (fechaControler.text != "" &&
                              nameControler.text != '' &&
                              montoControler.text != '') {
                            if (int.parse(montoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else {
                              ListaData[index].name = nameControler.text;
                              ListaData[index].date = fechaControler.text;
                              ListaData[index].monto =
                                  int.parse(montoControler.text);
                              await sleepTime(500);
                              listToCSV(ListaData, context);
                              nameControler.clear();
                              fechaControler.clear();
                              montoControler.clear();
                              dateBox = '${d.day}/${d.month}/${d.year}';
                              Navigator.pop(context);
                            }
                          } else {
                            alertError(context,
                                'Debe incluir todos los campos correctamente');
                          }
                        },
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<void> depositValue(context, index) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "DEPOSITO",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 160,
            height: 135,
            child: Column(
              children: [
                const SizedBox(height: 8),
                addition('Monto a Depositar'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (depositoControler.text != '') {
                            if (int.parse(depositoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else if ((int.parse(depositoControler.text) +
                                    ListaData[index].val_actual) >
                                ListaData[index].monto) {
                              var mensaje = 'Deposito Supera tu meta';
                              alertError(context, mensaje);
                            } else {
                              ListaData[index].val_actual =
                                  ListaData[index].val_actual +
                                      int.parse(depositoControler.text);
                              ListaData[index].resta = ListaData[index].resta -
                                  int.parse(depositoControler.text);
                              await sleepTime(500);
                              listToCSV(ListaData, context);
                              depositoControler.clear();
                              Navigator.pop(context);
                            }
                          } else {
                            alertError(context,
                                'Debe incluir todos los campos correctamente');
                          }
                        },
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<void> subtractionValue(context, index) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "RETIRO",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 160,
            height: 135,
            child: Column(
              children: [
                const SizedBox(height: 8),
                addition('Monto a retirar'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (depositoControler.text != '') {
                            if (int.parse(depositoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else if (int.parse(depositoControler.text) >
                                (ListaData[index].val_actual)) {
                              var mensaje = 'Monto mayor a lo ahorrado';
                              alertError(context, mensaje);
                            } else {
                              ListaData[index].val_actual =
                                  ListaData[index].val_actual -
                                      int.parse(depositoControler.text);
                              ListaData[index].resta = ListaData[index].resta +
                                  int.parse(depositoControler.text);
                              await sleepTime(500);
                              listToCSV(ListaData, context);
                              depositoControler.clear();
                              Navigator.pop(context);
                            }
                          } else {
                            alertError(context,
                                'Debe incluir todos los campos correctamente');
                          }
                        },
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<bool> dellValue(context) async {
  var respuesta2 = false;
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "ELIMINAR",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 120,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Estas seguro que deseas eliminar el registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        respuesta2 = true;
                        Navigator.pop(context);
                        await sleepTime(500);
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ],
              )
            ],
          ),
        )),
  );
  return respuesta2;
}

Future<void> sleepTime(dur) async {
  await Future.delayed(Duration(milliseconds: dur));
}

snackShow(msg, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}
