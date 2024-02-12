import 'package:flutter/material.dart';
import 'package:saving_control/models/data_model.dart';
import 'const_and_function/functions.dart';
import 'const_and_function/widgets.dart';


late List<data> contenido = [];

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Saving's List"),
          actions: [
            GestureDetector(
                child: Text('agrear'),
            onTap: () {
                  setState(() {
                    add_item("Carro", 10000, 5000, '01-12-2024');
                  });
            }
              ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  child: Text('eliminar'),
              onTap: (){
                setState(() {
                  rem_item((contenido.length)-1);
                });
              },
              ),
            ),
          ],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Color.fromARGB(20, 20, 30, 10),
          ),
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: contenido.length,
                itemBuilder: (BuildContext context, int index){
                  var _color = contenido[index].color;
                  var _name = contenido[index].name.toString();
                  var _monto = contenido[index].monto;
                  var _resta = contenido[index].resta;
                  var _fecha = contenido[index].date.toString();
                  var _actual = contenido[index].val_actual;

                 return Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: AnimatedContainer(
                       width: double.maxFinite,
                       height: 155,
                       duration: const Duration(seconds: 1),
                       curve: Curves.slowMiddle,
                       decoration: BoxDecoration (
                           borderRadius: BorderRadius.circular(15.0),
                           border: Border.all(color: Colors.black87,),
                           color: const Color(0x844E4F4B)
                       ),
                       child: cuadro(_name, _color, _monto, _actual, _fecha, _resta)),
                 );
                },
            ),
          ),
        ));
  }
}









