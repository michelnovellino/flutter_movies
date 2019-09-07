class Movies {
  List<Movie> items = new List();
  Movies();
  Movies.fromJson(List<dynamic> list) {
    if (list == null) return;
    for (var item in list) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });
  Movie.fromJsonMap(Map<String, dynamic> data) {
    popularity = data['popularity'] / 1;
    voteCount = data['vote_count'];
    video = data['video'];
    posterPath = data['poster_path'];
    id = data['id'];
    adult = data['adult'];
    backdropPath = data['backdrop_path'];
    originalLanguage = data['original_language'];
    originalTitle = data['original_title'];
    genreIds = data['genre_ids'].cast<int>();
    title = data['title'];
    voteAverage = data['vote_average'] / 1;
    overview = data['overview'];
    releaseDate = data['release'];
  }
  Movie.getPoster() {
    if (posterPath == null) {
      return 'https://goodyfeed.com/wp-content/uploads/2015/09/error404.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
}
