import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario_bases_de_datos/pantallas/agregarRecetaPantalla.dart';
import 'package:recetario_bases_de_datos/pantallas/detalleRecetaPantalla.dart';
import 'package:recetario_bases_de_datos/providers/recetaProvider.dart';

class ListarRecetaPantalla extends StatelessWidget {
  static const routeName = '/listarRecetas';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetario'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(AgregarRecetaPantalla.routeName);
          }, 
          icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<RecetaProvider>(
        builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.recetas.length,
          itemBuilder: (context, index) {
            final receta = provider.recetas[index];
            return ListTile(
              title: Text(receta.name),
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetalleRecetaPantalla.routeName, 
                  arguments: receta,
                );
              },
            );
          },
        );
      },),
    );
  }
  
}