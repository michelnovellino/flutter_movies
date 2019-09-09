import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.model.dart';

class MultiCarousel extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  MultiCarousel({@required this.movies, @required this.nextPage});
  final _controller = PageController(initialPage: 1, viewportFraction: 0.4);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 300.0) {
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height * .40,
      child: PageView.builder(
        controller: _controller,
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _renderMovies(context, movies[i]);
        },
        pageSnapping: false,
      ),
    );
  }

  Widget _renderMovies(BuildContext context, Movie movie) {
    final _screenSize = MediaQuery.of(context).size;
    movie.uniqueId = '${movie.id}--popular';
    final movieObj = Container(
      margin: EdgeInsets.only(right: 25.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  image: NetworkImage(movie.getPoster()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.fill,
                  height: _screenSize.height * .30,
                  width: _screenSize.width * .40,
                )),
          ),
          SizedBox(
            height: _screenSize.height * 0.01,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
    return GestureDetector(
        child: movieObj,
        onTap: () {
          Navigator.pushNamed(context, 'single', arguments: movie);
        });
  }

/*   List<Widget> _movies(context) {
    final _screenSize = MediaQuery.of(context).size;

    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 25.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  image: NetworkImage(movie.getPoster()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.fill,
                  height: _screenSize.height * .30,
                  width: _screenSize.width * .40,
                )),
            SizedBox(
              height: _screenSize.height * 0.01,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  } */
}
