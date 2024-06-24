import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recetario_bases_de_datos/modelos/receta.dart';
import 'package:recetario_bases_de_datos/providers/recetaProvider.dart';

class AgregarRecetaPantalla extends StatefulWidget {
  static const routeName = '/addReceta';
  @override
  _AgregarRecetaPantalla createState()=> _AgregarRecetaPantalla();
}

class _AgregarRecetaPantalla extends State<AgregarRecetaPantalla>{
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _instruccionesController = TextEditingController();
  final _tiempoController = TextEditingController();
  File? _imagenFile; //variable para guardar la imagen tomada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Receta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child:Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la Receta'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ingredientesController,
                  decoration: InputDecoration(
                    labelText: 'Ingredientes (separados por coma)'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese los ingredientes';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _instruccionesController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese las instrucciones para preparar la receta'
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese las instrucciones';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tiempoController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese el tiempo de preparacion (minutos)'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese los ingredientes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(onPressed: (){
                  _capturarImagen(ImageSource.camera);
                }, child: Text('Tomar foto'),
                ),
                SizedBox(height: 21.0),
                _imagenFile != null? Image.file(_imagenFile!):Text('No se ha tomado ninguna fotografia'),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    final nuevaReceta = Receta(
                      name: _nameController.text, 
                      imagePath: _imagenFile?.path??'', 
                      ingredientes: _ingredientesController.text.split(','), //dividir la info por comas
                      instrucciones: _instruccionesController.text, 
                    tiempoPreparacion: int.parse(_tiempoController.text));
                    Provider.of<RecetaProvider>(context, listen: false).agregarReceta(nuevaReceta);
                    Navigator.of(context).pop();
                  }
                }, child: Text('Guardar'),)

               
              ],
            ),
            ),
        ),
        ),
    );
  }  

  //método para capturar la imagen desde la camara
  Future<void> _capturarImagen(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 600, //ajustar tamaño máximo de acuerdo a sus necesidades
        imageQuality: 70, // ajusta la calidad de imagen entre 0-100
        );
      
      if(pickedFile != null){
        //Guardar Imagen
        setState(() {
          _imagenFile = File(pickedFile.path);
        });
      } else {
        print('No se selecciono ninguna imagen.');
      }
    } catch (e) {
      print('Error al capturar imagen $e');
    }
  }
}
