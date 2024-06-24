import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario_bases_de_datos/modelos/receta.dart';
import 'dart:io';

import 'package:recetario_bases_de_datos/providers/recetaProvider.dart';

class DetalleRecetaPantalla extends StatelessWidget {
  static const routeName = '/detalleReceta';
  @override
  Widget build(BuildContext context){
    final Receta receta = ModalRoute.of(context)!.settings.arguments as Receta;
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.name),
        actions: [
          IconButton(onPressed: _mostrarDialogoEdicion(context, receta),
           icon: Icon(Icons.edit),
           ),
          IconButton(onPressed: _mostrarDialogoConfirmarEliminar(context, receta.id!),
           icon: Icon(Icons.delete),
           ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (receta.imagePath.isNotEmpty) 
            Image.file(File(receta.imagePath), height: 200),       
            const SizedBox(height: 16,),
            Text(receta.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16,),
            const Text('Ingredientes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            //convierte una lista en un widget
            ...receta.ingredientes.map((ingredientes) => Text(ingredientes)).toList(),

            const SizedBox(height: 16,),
            const Text('Intrucciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(receta.instrucciones),
            SizedBox(height: 16),
            Text('Tiempo de preparación: ${receta.tiempoPreparacion} minutos',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold
                ),
            ),
          ],
        ),
      ),
    );
  }

  //método para mostrar edicion de datos

  void _mostrarDialogoEdicion(BuildContext context, Receta receta){
    final TextEditingController nameController = TextEditingController(text: receta.name);

    final TextEditingController ingredientesController = TextEditingController(text: receta.ingredientes.join(','));

    final TextEditingController instruccionesController = TextEditingController(text: receta.instrucciones);

    final TextEditingController tiempoPreparacionController = TextEditingController(text: receta.tiempoPreparacion.toString());

    showDialog(context: context, 
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Receta'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre:',
                ),
              ),
                            TextField(
                controller: ingredientesController,
                decoration: const InputDecoration(
                  labelText: 'Ingredientes (separados por , ):',
                ),
              ),
              TextField(
                controller: instruccionesController,
                decoration: const InputDecoration(
                  labelText: 'Instrucciones:',
                ),
              ),
              TextField(
                controller: tiempoPreparacionController,
                decoration: const InputDecoration(
                  labelText: 'Tiempo de Preparacion (minutos):',
                ),
                keyboardType: TextInputType.number,
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
            Navigator.of(context).pop();
          }, 
          child: Text('Cancelar'),),
          ElevatedButton(onPressed: (){
            final String name = nameController.text;
            final String ingredientes = ingredientesController.text;
            final String instrucciones = instruccionesController.text;
            final int tiempo = int.parse(tiempoPreparacionController.text);

            final Receta actualizarReceta = Receta(id: receta.id, 
            name: name, 
            imagePath: receta.imagePath,//mantenemos la imagen y su ruta 
            ingredientes: ingredientes.split(','), 
            instrucciones: instrucciones, 
            tiempoPreparacion: tiempo
            );
            Provider.of<RecetaProvider>(context, listen: false).actualizarReceta(actualizarReceta);
            Navigator.of(context).pop();
          }, 
          child: const Text('Guardar'),
          )
        ],
      );
    }
    );
  }

  void _mostrarDialogoConfirmarEliminar(BuildContext context, int id){
    showDialog(context: context, 
    builder: (ctx){
      return AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text('¿Esta seguro de eliminar esta receta?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(ctx).pop();
          }, child: Text('Cancelar')),

          ElevatedButton(onPressed: (){
            Provider.of<RecetaProvider>(context, listen: false).eliminarReceta(id);
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          }, child: Text('Eliminar'),),
        ],
      );
    }
    );
  }
}