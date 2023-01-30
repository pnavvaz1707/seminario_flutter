import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var opcionSeleccionada = 0;
  var palabraActual = WordPair.random();
  var favoritos = <WordPair>[];

  void siguientePalabra() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      palabraActual = WordPair.random();
    });
  }

  void agregarFavoritos() {
    setState(() {
      if (favoritos.contains(palabraActual)) {
        favoritos.remove(palabraActual);
      } else {
        favoritos.add(palabraActual);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    IconData iconoFavorito;
    if (favoritos.contains(palabraActual)) {
      iconoFavorito = Icons.favorite;
    } else {
      iconoFavorito = Icons.favorite_border;
    }
    Widget pagina;
    switch (opcionSeleccionada) {
      case 0:
        pagina = Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Theme.of(context).colorScheme.inverseSurface,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  palabraActual.asPascalCase,
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
                    onPressed: siguientePalabra,
                    child: const Text("Siguiente")),
              ],
            ),
          ],
        );
        break;
      case 1:
        pagina = PaginaPrincipal(favoritos: favoritos);
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: siguientePalabra,
          tooltip: 'Increment',
          child: const Icon(Icons.delete),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key, this.favoritos});

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
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          for (WordPair par in favoritos)
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text(
                par.asPascalCase,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
        ],
      ),
    );
  }
}