import 'package:aplicacion_peliculas/src/models/actores_model.dart';
import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:aplicacion_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _crearAppbar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _crearCasting(pelicula),
          ]),
        )
      ],
    ));
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPoserImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget crearActoresPageView(List<Actor> actores) {
    return SizedBox(
        height: 200.0,
        child: PageView.builder(
            pageSnapping: false,
            controller: PageController(initialPage: 1, viewportFraction: 0.3),
            itemCount: actores.length,
            itemBuilder: (context, index) {
              return _actorTarjeta(actores[index]);
            }));
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
        child: Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                height: 150.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no_image.jpg'),
                image: NetworkImage(actor.getFoto()))),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }
}

Widget _crearAppbar(Pelicula pelicula) {
  return SliverAppBar(
    pinned: true,
    elevation: 2.0,
    backgroundColor: Colors.indigo,
    expandedHeight: 200.0,
    floating: false,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(pelicula.title),
      background: FadeInImage(
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
          placeholder: AssetImage('assets/no_image.jpg'),
          image: NetworkImage(pelicula.getBackgroundImg())),
    ),
  );
}
