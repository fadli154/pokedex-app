class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json["name"], url: json["url"]);
  }

  // 🔥 ambil ID dari URL
  String get id {
    return url.split("/")[6];
  }

  // 🔥 generate image URL
  String get imageUrl {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }
}
