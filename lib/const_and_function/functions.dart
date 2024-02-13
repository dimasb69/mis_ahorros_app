import 'dart:math';
import 'package:flutter/material.dart';
import 'package:saving_control/const_and_function/widgets.dart';
import '../main.dart' show ListaData;
import '../models/data_model.dart';





final random = Random();
Color color_fondo (){
  Color _color_cuadro = Color.fromARGB(random.nextInt(254), random.nextInt(254), random.nextInt(254), 100);
  return _color_cuadro;
}

add_item (name, int monto, int ahora, fecha, context) {

}

rem_item (index) {
  ListaData.removeAt(index);
}

Future<void> addItem(context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          "Agregar item",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: 150,
            height: 300,
            child: Column(
              children: [
                fechaW(context),
                nameW(),
                montoW(),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          bool amount = false;

                          if (fechaControler.text != "" && nameControler.text != '' && montoControler.text != '' ) {
                            if (int.parse(montoControler.text) <= 0){
                              var mensaje = 'El monto debe ser mayor a 0';
                              alertError(context, mensaje);
                          }else{
                              ListaData.add(DataList(nameControler.text, int.parse(montoControler.text), fechaControler.text, 0, 0, color_fondo()));
                              nameControler.clear();
                              fechaControler.clear();
                              montoControler.clear();
                              Navigator.pop(context);
                            }
                          }else{
                            var mensaje = 'Debe incluir todos los campos correctamente';
                            alertError(context, mensaje);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Aceptar",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
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
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
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

