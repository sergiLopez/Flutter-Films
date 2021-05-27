import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent) {
        siguientePagina();
      }
    });

    return Container(
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          itemCount: peliculas.length,
          itemBuilder: (context, i) {
            return _tarjeta(context, peliculas[i]);
          },
          pageSnapping: false,
          controller: _pageController,
        ));
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: pelicula.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPoserImg()),
                  placeholder: AssetImage('assets/no_image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.of(context).pushNamed('detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPoserImg()),
                placeholder: AssetImage('assets/no_image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
