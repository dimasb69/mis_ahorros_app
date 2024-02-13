import 'package:flutter/material.dart';
import 'package:saving_control/models/data_model.dart';
import 'const_and_function/functions.dart';
import 'const_and_function/widgets.dart';


late List<data> contenido = [];
bool startAnimation = false;
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
  Widget remove (index){
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
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
        onTap: (){
          rem_item(index);
          setState(() {

          });
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
            title: GestureDetector(
                child: const Text("Bajo el Colchón"),
            onTap: () {
                      setState(() {
                        startAnimation = !startAnimation;
                      });
            },
            ),
          actions: [
            GestureDetector(
                child: const Icon(Icons.add),
            onTap: () {
              addItem(context).then((_) => {
                  setState(() {

                })
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
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: contenido.length,
                itemBuilder: (BuildContext context, int index){
                  var _color = contenido[index].color;
                  var _name = contenido[index].name.toString();
                  var _monto = contenido[index].monto;
                  var _resta = contenido[index].resta;
                  var _fecha = contenido[index].date.toString();
                  var _actual = contenido[index].val_actual;
                 return cuadro(_name, _color, _monto, _actual, _fecha, _resta, index, remove(index));
                },
            ),
          ),
        ));
  }
}








