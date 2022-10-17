import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'horario.dart';
import 'notas.dart';

class Post {
  final String nombre;
  final List<dynamic> notas;

  Post({this.nombre, this.notas});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(nombre: json['nombre'], notas: json['notas']);
  }
}

class MenuApp extends StatelessWidget {
  final post;
  MenuApp({Key key, @required this.post}) : super(key: key);

  Widget miCard(data, nombre, context) {
    int color;
    color = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    return Card(
      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0xff5808e5),
      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

      // La propiedad child anida un widget en su interior
      // Usamos columna para ordenar un ListTile y una fila con botones
      child: Column(
        children: <Widget>[
          // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
          ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text(
                '${data["Ramo"]}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Asistencia: ${data["Asist 75%"]}%',
                style: TextStyle(color: Colors.white),
              )),

          // Usamos una fila para ordenar los botones del card
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Ver notas!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondRoute(
                            notas: data, nombre: nombre, color: color)),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(fontFamily: 'Varela'),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${post.nombre}"),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff5808e5),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Notas', icon: Icon(Icons.favorite)),
                Tab(text: 'Horario', icon: Icon(Icons.calendar_month)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // I wrapped large widgets in the SingleChildScrollView
              GridView.count(
                // Crea una grid con 2 columnas. Si cambias el scrollDirection a
                // horizontal, esto produciría 2 filas.
                crossAxisCount: 2,
                // Genera 100 Widgets que muestran su índice en la lista
                children: List.generate(post.notas.length, (index) {
                  return miCard(post.notas[index], post.nombre, context);
                }),
              ),
              SimpleTable(horario: post.horario)
            ],
          ),
        ),
      ),
    );
  }
}
