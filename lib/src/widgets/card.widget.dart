import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> movies;
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
              child: new Image.network(
                "http://via.placeholder.com/288x188",
                fit: BoxFit.fill,
              ));
        },
        itemCount: movies.length,
      ),
    );
  }
}
