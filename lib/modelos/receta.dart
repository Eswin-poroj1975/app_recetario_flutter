//Métodos para convertir objetos de la receta a mapas
// para poder trabajar con SQLite

class Receta {
  final int? id; 
  final String name;
  final String imagePath;
  final List<String> ingredientes;
  final String instrucciones;
  final int tiempoPreparacion;
  bool isFavorite;

  //Constructor
  Receta ({
    this.id,
    required this.name,
    required this.imagePath,
    required this.ingredientes,
    required this.instrucciones,
    required this.tiempoPreparacion,
    this.isFavorite = false,
  });

  // metodo copia, es jacer copia de nuestra instancai Receta y modifiicar algunos valores, si algun parametro no es proporcionnal.
  Receta copy({
    int?id,
    String? name,
    String? imagePath,
    List<String>? ingredientes,
    String? instrucciones,
    int? tiempoPreparacion,
    bool?isFavorite,
  }){
    return Receta(
      id: id?? this.id,
      name: name?? this.name,
      imagePath: imagePath?? this.imagePath,
      ingredientes: ingredientes?? this.ingredientes,
      instrucciones: instrucciones?? this.instrucciones,
      tiempoPreparacion: tiempoPreparacion?? this.tiempoPreparacion,
      isFavorite: isFavorite?? this.isFavorite,
    );
  }

  /* el método toMap convertir una instancia en un map<String,dynamic>
  es la forma de almacenar la receta en BD
  los indgredientes se convertir en una reca*/

  Map <String, dynamic> toMap(){
    return {
      'id': id,
      'name':name,
      'imagePath':imagePath,
      'ingredientes': ingredientes,
      'tiempoPreparacion':tiempoPreparacion,
      'isFavorite': isFavorite ? 1:0,
    };
  }

  // constructor desde el mapa para crear una instancia de receta a partir
  // factory se usa para definir constructor de fabrica. Los contructores no siempre 
  // fabrican no siempre crea una nueva instancia de la clase, en su lugar
  // devuelven una instancia existente, una instancia de subclase o valor

  factory Receta.fromMap(Map<String, dynamic>map){
    return Receta(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      ingredientes: List<String>.from(map['ingredientes'].split(',')),
      instrucciones: map['instrucciones'],
      tiempoPreparacion: map['tiempoPreparacion'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}