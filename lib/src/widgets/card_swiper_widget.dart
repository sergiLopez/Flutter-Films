import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.4,
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: peliculas[index].id,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('detalle', arguments: peliculas[index]);
                  },
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPoserImg()),
                    placeholder: AssetImage('assets/no_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
      ),
    );
  }
}
