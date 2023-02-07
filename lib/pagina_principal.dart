import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:seminario_flutter/lista_palabras.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({
    super.key,
    required this.favoritos,
    required this.historial,
  });

  final List<WordPair> favoritos;
  final List<WordPair> historial;

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  GlobalKey? historyListKey;

  var palabraActual = WordPair.random();

  void siguientePalabra() {
    setState(() {
      var animatedList = historyListKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0);
      widget.historial.insert(0, palabraActual);
      palabraActual = WordPair.random();
    });
  }

  void agregarFavoritos([WordPair? palabraSel]) {
    palabraSel = palabraSel ?? palabraActual;
    setState(() {
      if (widget.favoritos.contains(palabraSel)) {
        widget.favoritos.remove(palabraSel);
      } else {
        widget.favoritos.add(palabraSel!);
      }
      if (!widget.historial.contains(palabraActual)) {
        widget.historial.insert(0, palabraActual);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData iconoFavorito;
    if (widget.favoritos.contains(palabraActual)) {
      iconoFavorito = Icons.favorite;
    } else {
      iconoFavorito = Icons.favorite_border;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: HistorialPalabras(
              favoritos: widget.favoritos, historial: widget.historial),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              palabraActual.asPascalCase,
              //"${palabraActual.asPascalCase} num ${widget.historial.length}",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: agregarFavoritos,
              child: Icon(iconoFavorito),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: siguientePalabra, child: const Text("Siguiente")),
          ],
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
