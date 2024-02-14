import 'dart:convert';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saving_control/const_and_function/widgets.dart';
import '../main.dart' show ListaData;
import '../models/data_model.dart';
import 'dart:io';
const csvName = "data.csv";

late String csv;
final random = Random();
Color color_fondo() {
  Color _color_cuadro = Color.fromARGB(
      255, random.nextInt(250), random.nextInt(128), random.nextInt(250));
  return _color_cuadro;
}

rem_item(index) {
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
          child: Container(
            width: 150,
            height: 270,
            child: Column(
              children: [
                fechaW(context),
                nameW(),
                montoW(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (fechaControler.text != "" &&
                              nameControler.text != '' &&
                              montoControler.text != '') {
                            if (int.parse(montoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else {
                              ListaData.add(DataList(
                                  nameControler.text,
                                  int.parse(montoControler.text),
                                  fechaControler.text,
                                  0,
                                  int.parse(montoControler.text),
                                  color_fondo()));
                              listToCSV(ListaData);
                              nameControler.clear();
                              fechaControler.clear();
                              montoControler.clear();
                              dateBox = '${d.day}/${d.month}/${d.year}';
                              Navigator.pop(context);
                            }
                          } else {
                            var mensaje =
                                'Debe incluir todos los campos correctamente';
                            alertError(context, mensaje);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Aceptar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          nameControler.clear();
                          fechaControler.clear();
                          montoControler.clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
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

Future<void> listToCSV(List<DataList> lista) async {
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
  print(csv);

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/$csvName';
  final File file = File(path);

  var dataSaved = await file.writeAsString(csv);
  print(dataSaved);
}

Future<void> csvRead() async {
  ListaData = [];
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/$csvName';
  final input = File(path).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(CsvToListConverter())
      .toList();
  //print('primer valor: ${fields.length}');
  for (int i = 0; i < fields.length; i++) {
    if (i != 0) {
      final String name = fields[i][0].toString();
      final int monto = int.parse(fields[i][1].toString());
      final String date = fields[i][2].toString();
      final int val_atc = int.parse(fields[i][3].toString());
      final int resta = int.parse(fields[i][4].toString());
      final color = fields[i][5].toString();
      var exaName = "";
      for (int c = 0; c < color.length; c++) {
        if (c == 6) {
          exaName = exaName + color[c];
        } else if (c == 7) {
          exaName = exaName + color[c];
        } else if (c == 8) {
          exaName = exaName + color[c];
        } else if (c == 9) {
          exaName = exaName + color[c];
        } else if (c == 10) {
          exaName = exaName + color[c];
        } else if (c == 11) {
          exaName = exaName + color[c];
        } else if (c == 12) {
          exaName = exaName + color[c];
        } else if (c == 13) {
          exaName = exaName + color[c];
        } else if (c == 14) {
          exaName = exaName + color[c];
        } else if (c == 15) {
          exaName = exaName + color[c];
        }
      }
      final idColor = int.parse(exaName);
      ListaData.add(
          DataList(name, monto, date, val_atc, resta, Color(idColor)));
      await timporEspera(250);
    }
  }
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
          child: Container(
            width: 150,
            height: 270,
            child: Column(
              children: [
                fechaW(context),
                nameW(),
                montoW(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
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
                              await timporEspera(500);
                              listToCSV(ListaData);
                              nameControler.clear();
                              fechaControler.clear();
                              montoControler.clear();
                              dateBox = '${d.day}/${d.month}/${d.year}';
                              Navigator.pop(context);
                            }
                          } else {
                            var mensaje =
                                'Debe incluir todos los campos correctamente';
                            alertError(context, mensaje);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Aceptar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          nameControler.clear();
                          fechaControler.clear();
                          montoControler.clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
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
          child: Container(
            width: 150,
            height: 120,
            child: Column(
              children: [
                const SizedBox(height: 8),
                deposito('Monto a Depositar'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (depositoControler.text != '') {
                            if (int.parse(depositoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else if((int.parse(depositoControler.text)+ListaData[index].val_actual) > ListaData[index].monto){
                              var mensaje = 'Deposito Supera tu meta';
                              alertError(context, mensaje);
                            }else{
                              ListaData[index].val_actual =
                                  ListaData[index].val_actual +
                                      int.parse(depositoControler.text);
                              ListaData[index].resta = ListaData[index].resta -
                                  int.parse(depositoControler.text);
                              await timporEspera(500);
                              listToCSV(ListaData);
                              depositoControler.clear();
                              Navigator.pop(context);
                            }
                          } else {
                            var mensaje =
                                'Debe incluir todos los campos correctamente';
                            alertError(context, mensaje);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Aceptar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<void> restaValue(context, index) async {
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
          child: Container(
            width: 150,
            height: 120,
            child: Column(
              children: [
                const SizedBox(height: 8),
                deposito('Monto a retirar'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (depositoControler.text != '') {
                            if (int.parse(depositoControler.text) <= 0) {
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                            } else if(int.parse(depositoControler.text) > (ListaData[index].val_actual)){
                              var mensaje = 'Monto mayor a lo ahorrado';
                              alertError(context, mensaje);
                            }else{
                              ListaData[index].val_actual =
                                  ListaData[index].val_actual -
                                      int.parse(depositoControler.text);
                              ListaData[index].resta = ListaData[index].resta +
                                  int.parse(depositoControler.text);
                              await timporEspera(500);
                              listToCSV(ListaData);
                              depositoControler.clear();
                              Navigator.pop(context);
                            }
                          } else {
                            var mensaje =
                                'Debe incluir todos los campos correctamente';
                            alertError(context, mensaje);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Aceptar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

Future<bool> eliminarValue(context) async {
  var respuesta2= false;
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "ELIMINAR",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: 100,
            height: 80,
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Text(
                    'Estas seguro que deseas Eliminar',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          respuesta2 = true;
                          Navigator.pop(context);
                          await timporEspera(500);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Aceptar",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
  return respuesta2;
}


Future<void> timporEspera(dur) async {
  await Future.delayed(Duration(milliseconds: dur));
}

