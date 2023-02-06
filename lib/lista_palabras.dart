import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HistorialPalabras extends StatefulWidget {
  const HistorialPalabras(
      {Key? key, required this.historial, required this.favoritos})
      : super(key: key);

  final List<WordPair> favoritos;
  final List<WordPair> historial;

  @override
  State<HistorialPalabras> createState() => _HistorialPalabrasState();
}

class _HistorialPalabrasState extends State<HistorialPalabras> {
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  void agregarFavoritos(WordPair palabraSel) {
    setState(() {
      if (widget.favoritos.contains(palabraSel)) {
        widget.favoritos.remove(palabraSel);
      } else {
        widget.favoritos.add(palabraSel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        reverse: true,
        padding: const EdgeInsets.only(top: 20),
        initialItemCount: widget.historial.length,
        itemBuilder: (context, index, animation) {
          final palabraSel = widget.historial[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  agregarFavoritos(palabraSel);
                },
                icon: widget.favoritos.contains(palabraSel)
                    ? const Icon(Icons.favorite, size: 12)
                    : const SizedBox(),
                label: Text(
                  palabraSel.asLowerCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
