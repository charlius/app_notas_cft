import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SimpleTable extends StatefulWidget {
  final horario;
  SimpleTable({Key key, @required this.horario}) : super(key: key);
  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  final List<String> items = [
    'LUNES',
    'MARTES',
    'MIERCOLES',
    'JUEVES',
    'VIERNES',
    'SABADO',
  ];
  String selectedValue = "LUNES";

  DropdownButtonHideUnderline dropbox() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Dia',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
          print(widget.horario[selectedValue]);
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.yellow,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 160,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Color(0xff5808e5),
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xff5808e5),
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }

  Container container_notas(horario, index) {
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${horario['nombreramo']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Hora: ${horario['hora']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Seleciona tu horario por dia "), dropbox()]),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 400,
            child: GridView.count(
              // Crea una grid con 2 columnas. Si cambias el scrollDirection a
              // horizontal, esto produciría 2 filas.
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.1,
              padding: const EdgeInsets.all(10.0),
              // Genera 100 Widgets que muestran su índice en la lista
              children:
                  List.generate(widget.horario[selectedValue].length, (index) {
                return container_notas(
                    widget.horario[selectedValue][index], index);
              }),
            ),
          )
        ],
      )),
    );
  }
}
