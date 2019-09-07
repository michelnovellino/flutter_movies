import 'package:flutter/material.dart';
import 'package:flutter_movies/src/widgets/card.widget.dart';
import 'package:flutter_movies/src/providers/movies.provider.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homePage'),
      ),
      body: _renderSwiper(),
    );
  }

  Widget _renderSwiper() {
    moviesProvider.get('movie/now_playing');
    return CardSwiper(movies: [1,2,3,4,5]);
  }
}
