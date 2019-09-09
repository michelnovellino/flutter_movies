import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_movies/src/models/movie.model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _renderCard(context),
    );
  }

  Widget _renderCard(context) {
    final _screenSize = MediaQuery.of(context).size;
    final movieObj = Swiper(
      layout: SwiperLayout.STACK,
      itemWidth: _screenSize.width * .50,
      itemHeight: _screenSize.height * .35,
      itemBuilder: (BuildContext context, int index) {
        movies[index].uniqueId = '${movies[index].id}--card';
        return Hero(
          tag: movies[index].uniqueId,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'single', arguments: movies[index]);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fadeInDuration: Duration(seconds: 2),
                    image: NetworkImage(movies[index].getPoster()),
                    fit: BoxFit.cover)),
          ),
        );
      },
      itemCount: movies.length,
    );

    return movieObj;
  }
}
