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
    return FutureBuilder(
      future: moviesProvider.get('movie/now_playing'),
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
}
