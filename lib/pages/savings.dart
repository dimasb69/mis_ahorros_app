import 'package:flutter/material.dart';
import 'package:saving_control/models/data_model.dart';
import '../const_and_function/functions.dart';
import '../const_and_function/widgets.dart';
import 'package:delayed_display/delayed_display.dart';


late List<DataList> ListaData = [];
bool startAnimation = true;
double screenHeight = 0;
double screenWidth = 0;


class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  @override
  void initState() {
    csvRead(context).then((value) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_home_work_outlined,
                size: 35,
              ),
              SizedBox(width: 4),
              Text(
                "MIS AHORROS",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Agregar Nuevo',
            onPressed: () {
              addItem(context).whenComplete((){
                sleepTime(1500);
                csvRead(context).then((value) => setState(() {}));
                setState(() {ListaData;});
              });

            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          color: Color.fromARGB(20, 20, 30, 10),
        ),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: ListaData.length,
            itemBuilder: (BuildContext context, int index) {
              DataList listData = ListaData[index];
              return DelayedDisplay(
                  slidingCurve: Curves.slowMiddle,
                  delay: const Duration(milliseconds: 800),
                  child: boxW(
                      listData.name.toString(),
                      listData.color,
                      listData.monto,
                      listData.val_actual,
                      listData.date.toString(),
                      listData.resta,
                      index,
                      remove(index),
                      edit(index),
                      deposit(index),
                      subtract(index)));
            },
          ),

        ),
      ),
      bottomNavigationBar: bottomDevName(),
    );
  }

  Widget remove(index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8),
      child: GestureDetector(
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_forever_outlined, size: 15),
            SizedBox(width: 5),
            Text('Eliminar'),
          ],
        ),
        onTap: () async {
          dellValue(context).then((value)  async{
            print(value.toString());
            if (value)
            {
              startAnimation = false;
              setState(() {});
              await sleepTime(600);
              remItem(index);
              startAnimation = true;
              listToCSV(ListaData, context);
              setState(() {});
            }
          });
        },
      ),
    );
  }

  Widget edit(index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8),
      child: GestureDetector(
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, size: 15),
            SizedBox(width: 5),
            Text('Editar'),
          ],
        ),
        onTap: () async {
          editItem(context, index).then((value) => setState(() {}));
        },
      ),
    );
  }

  Widget deposit(index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8),
      child: GestureDetector(
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline_outlined, size: 15),
            SizedBox(width: 5),
            Text('Depositar'),
          ],
        ),
        onTap: () async {
          depositValue(context, index).then((value) => setState(() {}));
        },
      ),
    );
  }

  Widget subtract(index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8),
      child: GestureDetector(
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.remove_circle_outline, size: 15),
            SizedBox(width: 5),
            Text('Retirar'),
          ],
        ),
        onTap: () async {
          subtractionValue(context, index).then((value) => setState(() {}));
        },
      ),
    );
  }
}
