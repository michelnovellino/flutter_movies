import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_movies/src/models/movie.model.dart';

class MoviesProvider {
  String _apikey = "7a9054d0ca9107070bf6d1a08fcca6dd";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _page = 0;
  bool _loading = false;
  List<Movie> _popularList = new List();

  final _popularStreamCtrl = StreamController<List<Movie>>.broadcast();

  void disposeStream() {
    _popularStreamCtrl.close();
  }

  //getters
  Function(List<Movie>) get sink => _popularStreamCtrl.sink.add;
  Stream<List<Movie>> get stream => _popularStreamCtrl.stream;

  //futures
  Future<List<Movie>> _response(Uri url) async {
    final response = await http.get(url);
    final decoded = json.decode(response.body);
    final movies = new Movies.fromJson(decoded['results']);
    return movies.items;
  }

  Future<List<Movie>> getPlayingNow(path) async {
    final url = Uri.https(
        _url, '/3/' + path, {'api_key': _apikey, 'language': _language});
    return await _response(url);
  }

  Future<List<Movie>> getPopular() async {
    if(_loading) return [];
    _loading = true;
    _page++;
    final url = Uri.https(_url, '/3/movie/popular',
        {'api_key': _apikey, 'language': _language, 'page': _page.toString()});
    final response = await _response(url);
    _popularList.addAll(response);
    sink(_popularList);
    _loading = false;
    return response;
  }
}
