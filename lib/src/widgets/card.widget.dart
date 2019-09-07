import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_movies/src/models/movie.model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * .70,
        itemHeight: _screenSize.height * .50,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                fadeInDuration: Duration(seconds: 2),
                image: NetworkImage(movies[index].getPoster()),
                fit: BoxFit.cover
              ));
        },
        itemCount: movies.length,
      ),
    );
  }
}
