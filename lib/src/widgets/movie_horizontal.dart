import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        height: _screenSize.height * 0.2,
        child: PageView(
          pageSnapping: false,
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          children: _tarjetas(context),
        ));
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
