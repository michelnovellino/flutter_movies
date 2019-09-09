class Cast {
  List<Actor> items = new List();
  Cast();
  Cast.fromJson(List<dynamic> list) {
    if(list == null) return;
    list.forEach((el){
      final actor = Actor.fromJsonMap(el);
      items.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });
  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }
    getProfileImage() {
    if (profilePath == null) {
      return 'https://www.foroelectricidad.com/styles/canvas/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
