import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/data_model.dart';
import '../pages/savings.dart';
import 'functions.dart';


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

Future<void> csvRead(savingsList, context) async {
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
  savingsList.listUpdate(ListaData);
  //print('primer valor: ${fields.length}');
}