import 'package:flutter/material.dart';
import 'package:flutter_movies/src/widgets/card_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(movies: [1,2,3,4,5]);
  }
}
