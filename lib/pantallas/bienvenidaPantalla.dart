import 'package:flutter/material.dart';
import 'package:recetario_bases_de_datos/pantallas/listarRecetaPantalla.dart';

class BienvenidaPantalla extends StatelessWidget {
  static const routeName = '/bienvenida';
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).pushNamed(ListarRecetaPantalla.routeName);
        }, child: const Text('Bienvenido al Recetario')),
      ),
    );
  }
}