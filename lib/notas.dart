import 'package:flutter/material.dart';
import 'package:store_template/tama%C3%B1o_pantalla.dart';

class SecondRoute extends StatelessWidget {
  final notas;
  final nombre;
  final int color;
  SecondRoute(
      {Key key,
      @required this.notas,
      @required this.nombre,
      @required this.color})
      : super(key: key);

  Container container_notas(notas, index) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff5808e5),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF101012),
            offset: Offset(-12, 12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Nota ${index + 1}:  ${notas['PR ${index + 1}']}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container container_ex(notas, index) {
    String dato;
    print(notas);
    if (index + 1 == 1) {
      dato = "PR Prom 100%:  ${notas['PR Prom 100%']}";
    }
    if (index + 1 == 2) {
      dato = "N Pr 70%:  ${notas['N Pr 70%']}";
    }
    if (index + 1 == 3) {
      dato = "N Ex 30%:  ${notas['N Ex 30%']}";
    }
    if (index + 1 == 4) {
      dato = "N Pr R 70%:  ${notas['N Pr R 70%']}";
    }
    if (index + 1 == 5) {
      dato = "N Ex R 30%:  ${notas['N Ex R 30%']}";
    }
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff5808e5),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF101012),
            offset: Offset(-12, 12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "${dato}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mitadAncho = screenWidth(context, dividedBy: 2);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tus notas"),
        backgroundColor: Color(0xff006064),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                    color: Color(0xff5808e5).withOpacity(1.0),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${notas["Ramo"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Seccion:    ${notas["Sección"]}",
                        style: TextStyle(color: Colors.white)),
                    Text("Año:    ${notas["Año"]}",
                        style: TextStyle(color: Colors.white)),
                    Text("semestre:    ${notas["Periodo"]}",
                        style: TextStyle(color: Colors.white)),
                    Text("Asist 75%:    ${notas["Asist 75%"]}%",
                        style: TextStyle(color: Colors.white))
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Divider(color: Colors.black)
          ],
        ),
        Container(
          height: 200,
          child: GridView.count(
            // Crea una grid con 2 columnas. Si cambias el scrollDirection a
            // horizontal, esto produciría 2 filas.
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.1,
            padding: const EdgeInsets.all(10.0),
            // Genera 100 Widgets que muestran su índice en la lista
            children: List.generate(5, (index) {
              return container_notas(notas, index);
            }),
          ),
        ),
        Divider(color: Colors.black),
        Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Promedio: ${notas["PR Prom 100%"]}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
        ),
        Divider(color: Colors.black),
        Container(
          height: 200,
          child: GridView.count(
            // Crea una grid con 2 columnas. Si cambias el scrollDirection a
            // horizontal, esto produciría 2 filas.
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.1,
            padding: const EdgeInsets.all(10.0),
            // Genera 100 Widgets que muestran su índice en la lista
            children: List.generate(5, (index) {
              return container_ex(notas, index);
            }),
          ),
        ),
        Divider(color: Colors.black),
        Row(
          children: [
            Container(
                height: 40,
                width: mitadAncho,
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "Final: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("${notas['Final']}")
                    ]))),
            Container(
                height: 40,
                width: mitadAncho,
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "Estado: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("${notas['Estado']}")
                    ]))),
          ],
        )
      ]),
    );
  }
}
