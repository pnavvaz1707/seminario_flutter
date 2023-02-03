import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PaginaFavoritos extends StatelessWidget {
  const PaginaFavoritos({super.key, this.favoritos});

  final favoritos;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Tienes ${favoritos.length} palabras en favoritos",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary,
              ),
            ),
          ),
          for (WordPair par in favoritos)
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text(
                par.asPascalCase,
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimary,
                ),
              ),
            )
        ],
      ),
    );
  }
}