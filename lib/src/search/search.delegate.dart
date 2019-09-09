import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.model.dart';
import 'package:flutter_movies/src/providers/movies.provider.dart';

class Search extends SearchDelegate {
final movieProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      if(query.isEmpty) return Container();

      return FutureBuilder(
        future: movieProvider.search(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data;
            return ListView(
              children: data.map((el){
                el.uniqueId = '${el.id}--search';
                  return ListTile(
                    leading: Hero(
                      tag: el.uniqueId,

                                          child: FadeInImage(
                        image: NetworkImage(el.getPoster()),
                        placeholder: AssetImage('assets/img/no-image.jpg')
                        ),
                    ),
                      title: Text(el.title, overflow: TextOverflow.ellipsis),
                      subtitle: Text(el.originalTitle, overflow: TextOverflow.ellipsis),
                      onTap: (){
                        close(context, null);
                        Navigator.pushNamed(context, 'single',arguments: el);
                      },
                  );
                }).toList(),
            );
          }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
          }
        },
      );
}


/*
class Search extends SearchDelegate {
  final movies = [
    'it',
    'batman',
    'aquaman',
    'wonder woman',
    'deadpool',
    'x-men',
    'wolverine',
    'jhon wick',
    'rapido y furioso',
    'rey leon'
  ];
  final latest = ['spiderman', 'it'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggest = (query.isEmpty)
        ? latest
        : movies.where((el) => 
           el.toLowerCase().startsWith(query.toLowerCase())
          ).toList();
    return ListView.builder(
      itemCount:suggest.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggest[index]),
          onTap: (){},
        );
      },
    );
  }
}

*/