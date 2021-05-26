import 'package:aplicacion_peliculas/src/providers/peliculas_provider.dart';
import 'package:aplicacion_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:aplicacion_peliculas/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_swiperTarjetas(), _footer(context)],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        title: Text('Home Page'),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEncines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          FutureBuilder(
              future: peliculasProvider.getPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(peliculas: snapshot.data);
                }
                return Container();
              })
        ],
      ),
    );
  }
}
