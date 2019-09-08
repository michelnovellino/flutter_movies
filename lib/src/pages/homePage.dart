import 'package:flutter/material.dart';
import 'package:flutter_movies/src/widgets/card.widget.dart';
import 'package:flutter_movies/src/providers/movies.provider.dart';
import 'package:flutter_movies/src/widgets/multicarousel.widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold(
        appBar: AppBar(
          title: Text('homePage'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_renderSwiper(), _renderBody(context)],
          ),
        ));
  }

  Widget _renderSwiper() {
    return FutureBuilder(
      future: moviesProvider.getPlayingNow('movie/now_playing'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 350.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _renderBody(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MultiCarousel(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopular);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
