import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'horario.dart';
import 'notas.dart';

Future<Post> fetchPost() async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  final response = await http.get(
      Uri.parse(
          'https://eee1-201-215-145-33.ngrok.io/login/13.911.978-9/20111979/2'),
      headers: requestHeaders);

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String nombre;
  final List<dynamic> notas;

  Post({this.nombre, this.notas});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(nombre: json['nombre'], notas: json['notas']);
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;
  MyApp({Key key, this.post}) : super(key: key);

  Card miCard(data, nombre, context) {
    int color;
    color = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    return Card(
      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(color).withOpacity(1.0),
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
    Post data;
    return MaterialApp(
      title: '',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cft San Agustin"),
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
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> notas = snapshot.data.notas;
                    return GridView.count(
                      // Crea una grid con 2 columnas. Si cambias el scrollDirection a
                      // horizontal, esto produciría 2 filas.
                      crossAxisCount: 2,
                      // Genera 100 Widgets que muestran su índice en la lista
                      children: List.generate(notas.length, (index) {
                        return miCard(
                            notas[index], snapshot.data.nombre, context);
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // Por defecto, muestra un loading spinner
                  return CircularProgressIndicator();
                },
              ),
              SimpleTable()
            ],
          ),
        ),
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({this.data});
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    print("data: ${this.data}");
    return GridView.count(
      // Crea una grid con 2 columnas. Si cambias el scrollDirection a
      // horizontal, esto produciría 2 filas.
      crossAxisCount: 2,
      // Genera 100 Widgets que muestran su índice en la lista
      children: List.generate(this.data.length, (index) {
        return Center(
          child: Text(
            'Item ${this.data[index]}',
          ),
        );
      }),
    );
  }
}
