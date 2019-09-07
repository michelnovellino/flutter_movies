import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_movies/src/models/movie.model.dart';

class MoviesProvider {
  String _apikey = "7a9054d0ca9107070bf6d1a08fcca6dd";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Movie>> get(path) async {
    final url =
        Uri.https(_url, '/3/'+ path, {'api_key': _apikey, 'language': _language});

      final response = await http.get(url);
      final decoded = json.decode(response.body);
      final movies = new Movies.fromJson(decoded['results']);
      return movies.items;
  }
}
