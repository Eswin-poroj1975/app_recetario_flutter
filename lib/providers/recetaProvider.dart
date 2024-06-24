import 'package:flutter/material.dart';
import 'package:recetario_bases_de_datos/database/recetario_database.dart';
import 'package:recetario_bases_de_datos/modelos/receta.dart';

//Nos servirá para manejar todas las operaciones relacionadas con las recetas
//agregar, actualizar, eliminar, mostrar recetas

/* ¿Qué es el ChangeNotifier?
ChangeNotifier es una clase en Flutter que proporciona una manera fácil y eficiente de gestionar el estado y notificar a los widgets interesados cuando ese estado cambia. Es una de las herramientas fundamentales en el patrón de arquitectura Provider, que es muy popular para la gestión del estado en aplicaciones Flutter.
 
Funciones de ChangeNotifier
Gestión del Estado:
 
ChangeNotifier permite definir un estado y métodos para modificar ese estado.
Notificación de Cambios:
 
Cuando el estado cambia, ChangeNotifier puede notificar a los listeners (widgets que están interesados en ese estado) para que se reconstruyan y reflejen los cambios.
Cómo Usar ChangeNotifier
Crear una Clase que Extienda ChangeNotifier:
 
Define una clase que extienda ChangeNotifier y gestiona el estado en ella.
Notificar a los Listeners:
 */

class RecetaProvider extends ChangeNotifier {
  List<Receta> _recetas=[];
  List<Receta> get recetas => _recetas;

  bool get isDarkMode => isDarkMode;
  bool _isDarkMode = false;

  void toggleDarkMode(){
    _isDarkMode =! _isDarkMode;
    notifyListeners();
  }

  //fetchReceta, nos servira para cargar todas las recetas desde la base de datos y actualizar

  Future <void> fetchReceta()async{
    _recetas = await RecetaBaseDeDatos.instance.readAllRecipes();
    notifyListeners();
  }

  //método para agregar recetas y actualizar lista de datos
  Future <void> agregarReceta(Receta receta)async{
    final nuevaReceta = await RecetaBaseDeDatos.instance.create(receta);
    _recetas.add(nuevaReceta);
    notifyListeners();
  }

  //método para actualizar recetas y atualizar la lista de datos
  Future<void> actualizarReceta(Receta receta) async {
    await RecetaBaseDeDatos.instance.update(receta);
    _recetas = _recetas.map((e) => e.id == receta.id? receta:e).toList();
    notifyListeners();
  }

  Future <void> eliminarReceta(int id) async {
    await RecetaBaseDeDatos.instance.delete(id);
    _recetas.removeWhere((receta) => receta.id == id);
  }

}