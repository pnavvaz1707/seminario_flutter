import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'pagina_favoritos.dart';
import 'pagina_principal.dart';

class CuerpoAplicacion extends StatefulWidget {
  const CuerpoAplicacion({super.key, required this.title});

  final String title;

  @override
  State<CuerpoAplicacion> createState() => _CuerpoAplicacionState();
}

class _CuerpoAplicacionState extends State<CuerpoAplicacion> {
  var opcionSeleccionada = 0;
  var favoritos = <WordPair>[];
  var historial = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    Widget pagina;
    switch (opcionSeleccionada) {
      case 0:
        pagina = PaginaPrincipal(favoritos: favoritos, historial: historial);
        break;
      case 1:
        pagina = PaginaFavoritos(favoritos: favoritos);
        break;
      default:
        throw UnimplementedError(
            'No hay widget para la opción  $opcionSeleccionada');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text("Inicio")),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text("Favoritos")),

                ],
                selectedIndex: opcionSeleccionada,
                onDestinationSelected: (value) {
                  setState(() {
                    opcionSeleccionada = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                child: pagina,
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
