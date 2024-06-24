import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario_bases_de_datos/pantallas/agregarRecetaPantalla.dart';
import 'package:recetario_bases_de_datos/pantallas/detalleRecetaPantalla.dart';
import 'package:recetario_bases_de_datos/providers/recetaProvider.dart';
import 'package:recetario_bases_de_datos/pantallas/listarRecetaPantalla.dart';
import 'package:recetario_bases_de_datos/pantallas/bienvenidaPantalla.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>RecetaProvider()..fetchReceta(),
      child: Consumer<RecetaProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Recetario',
            theme: provider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            initialRoute: BienvenidaPantalla.routeName,
            routes: {
              BienvenidaPantalla.routeName:(context) => BienvenidaPantalla(),
              ListarRecetaPantalla.routeName:(context) => ListarRecetaPantalla(),
              DetalleRecetaPantalla.routeName:(context) => DetalleRecetaPantalla(),
              AgregarRecetaPantalla.routeName:(context) => AgregarRecetaPantalla(),
            },
          );
        },
      ),
    );
  }
}
