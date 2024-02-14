import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:saving_control/models/data_model.dart';
import 'const_and_function/functions.dart';
import 'const_and_function/widgets.dart';


late List<DataList> ListaData = [];
bool startAnimation = true;
double screenHeight = 0;
double screenWidth = 0;

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData().copyWith(
        appBarTheme:const AppBarTheme(
          backgroundColor: Color(0xffa0bd95),
        ),
        scaffoldBackgroundColor: const Color(0xefffffff),
      ),
      home: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    csvRead().then((value) => setState(() {}));
    super.initState();

  }

  Widget remove (index){
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8),
      child: GestureDetector(
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_forever, size: 15),
            SizedBox(width: 5),
            Text('Eliminar'),
        ],
        ),
        onTap: ()async {
          startAnimation=false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 750));
          rem_item(index);
          startAnimation = true;
          listToCSV(ListaData);
          setState(() {});
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Bajo el Colchón"),
          actions: [
            GestureDetector(
                child: const Icon(Icons.add),
            onTap: () {
              addItem(context).then((_) => {
                  setState(() {})
              });

            }
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
                itemBuilder: (BuildContext context, int index){
                  DataList listData = ListaData[index];
                 return DelayedDisplay(
                   slidingCurve: Curves.slowMiddle,
                     delay: const Duration(milliseconds: 600),
                     child: cuadro(listData.name.toString(), listData.color, listData.monto, listData.val_actual, listData.date.toString(), listData.resta, index, remove(index)));
                },
            ),
          ),
        ));
  }
}








