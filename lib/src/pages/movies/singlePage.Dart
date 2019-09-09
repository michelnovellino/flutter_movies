import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/casting.model.dart';
import 'package:flutter_movies/src/models/movie.model.dart';
import 'package:flutter_movies/src/providers/movies.provider.dart';

class SinglePage extends StatelessWidget {
  final _provider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _renderAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 12.0,
            ),
            _renderHeader(context, movie),
            _renderBody(movie),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Reparto',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            _renderCast(movie.id.toString())
          ]))
        ],
      ),
    );
  }

  Widget _renderAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 175.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            overflow: TextOverflow.ellipsis),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(movie.getPosterbackdrop()),
          fadeInDuration: Duration(seconds: 1),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _renderHeader(BuildContext context, Movie movie) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: FadeInImage(
                  height: _screenSize.height * .28,
                  width: _screenSize.width * .32,
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getPoster()),
                  fadeInDuration: Duration(seconds: 1),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: _screenSize.width * .05),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle,
                    style: TextStyle(), overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString())
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _renderBody(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Center(
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _renderCast(String id) {
    return FutureBuilder(
      future: _provider.getCast(id),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActors(context, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActors(BuildContext context, List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        itemCount: actors.length,
        itemBuilder: (context, i) {
          return _actorCard(actors[i]);
        },
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getProfileImage()),
              fit: BoxFit.fill,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
