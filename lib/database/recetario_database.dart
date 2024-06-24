//Vamos a usar el modelo (modelo vista controlador)
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:recetario_bases_de_datos/modelos/receta.dart';

class RecetaBaseDeDatos {
  static final RecetaBaseDeDatos instance = RecetaBaseDeDatos._init();
  static Database? _database;
  RecetaBaseDeDatos._init();

  Future <Database> get database  async{
    if (_database != null) return _database!;
      _database= await _initDB('recetas.db');
      return _database!;
  }
  
  Future <Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
  CREATE TABLE recetas (
    idReceta $idType,
    nameReceta $textType,
    imagePathReceta $textType,
    ingredientesReceta $textType,
    instruccionesReceta $textType,
    tiempoPreparacionReceta $intType,
    isFavoriteReceta $boolType
  )
  '''
  );
  }

  Future <Receta> create (Receta receta) async{
    final db = await instance.database;
    final id = await db.insert('recetas', receta.toMap());
    return receta.copy(id: id);
  }

  //listar recetas
  // mostrar recetas en base a un id

  Future <Receta?> readRecetas(int id)async {
    final db = await instance.database;

    //capturar la receta en base a una condicion
    final maps = await db.query(
      'recetas',
      columns: [
        'idReceta',
        'nameReceta',
        'imagePathReceta',
        'ingredientesReceta',
        'instruccionesReceta',
        'tiempoPreparacionReceta',
        'isFavoriteReceta',
      ],
      where: 'idRecetas=?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Receta.fromMap(maps.first);
    } else {
      return null;
    }
  }
  //todas las recetas
  Future <List<Receta>> readAllRecipes()async{
    final db = await instance.database;
    const orderBy = 'nameReceta ASC';
    final result = await db.query('recetas', orderBy: orderBy);
    return result.map((json) =>  Receta.fromMap(json)).toList();
  }

  // Actualizar Datos
  Future <int> update(Receta receta) async{
    final db = await instance.database;
    return db.update(
      'recetas', 
      receta.toMap(),
      where: 'idRecetas =?',
      whereArgs: [receta.id],
    );
  }

  // borrar datos
  Future <int> delete (int id) async{
    final db = await instance.database;
    return await db.delete(
      'recetas',
      where: 'idRecetas = ?',
      whereArgs: [id],
    );
  }

  //cerrar la base de datos, esto permite la seguridad de la informacion
  Future close()async{
    final db = await instance.database;
    db.close();
  }
}
