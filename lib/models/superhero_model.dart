class SuperheroModel {
  final String id;
  final String name;
  final Powerstats? powerstats;
  final Biography? biography;
  final Appearance? appearance;
  final Work? work;
  final Connections? connections;
  final Image? image;
  SuperheroModel({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.biography,
    required this.appearance,
    required this.work,
    required this.connections,
    required this.image,
  });

  factory SuperheroModel.fromJson(json) {
    return SuperheroModel(
      id: json['id'],
      name: json['name'],
      powerstats: json['powerstats'] != null
          ? new Powerstats.fromJson(json['powerstats'])
          : null,
      biography: json['biography'] != null
          ? new Biography.fromJson(json['biography'])
          : null,
      appearance: json['appearance'] != null
          ? new Appearance.fromJson(json['appearance'])
          : null,
      work: json['work'] != null ? new Work.fromJson(json['work']) : null,
      connections: json['connections'] != null
          ? new Connections.fromJson(json['connections'])
          : null,
      image: json['image'] != null ? new Image.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.powerstats != null) {
      data['powerstats'] = this.powerstats!.toJson();
    }
    if (this.biography != null) {
      data['biography'] = this.biography!.toJson();
    }
    if (this.appearance != null) {
      data['appearance'] = this.appearance!.toJson();
    }
    if (this.work != null) {
      data['work'] = this.work!.toJson();
    }
    if (this.connections != null) {
      data['connections'] = this.connections!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Powerstats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;
  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory Powerstats.fromJson(json) {
    return Powerstats(
      intelligence: json['intelligence'],
      strength: json['strength'],
      speed: json['speed'],
      durability: json['durability'],
      power: json['power'],
      combat: json['combat'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intelligence'] = this.intelligence;
    data['strength'] = this.strength;
    data['speed'] = this.speed;
    data['durability'] = this.durability;
    data['power'] = this.power;
    data['combat'] = this.combat;
    return data;
  }
}

class Biography {
  final String fullname;
  final String alterEgos;
  final List<String> aliases;
  final String place;
  final String first;
  final String publisher;
  final String alignment;
  Biography({
    required this.fullname,
    required this.alterEgos,
    required this.aliases,
    required this.place,
    required this.first,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(json) {
    return Biography(
      fullname: json['fullname'],
      alterEgos: json['alter-egos'],
      aliases: json['aliases'].cast<String>(),
      place: json['place'],
      first: json['first'],
      publisher: json['publisher'],
      alignment: json['alignment'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['alter-egos'] = this.alterEgos;
    data['aliases'] = this.aliases;
    data['place'] = this.place;
    data['first'] = this.first;
    data['publisher'] = this.publisher;
    data['alignment'] = this.alignment;
    return data;
  }
}

class Appearance {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;
  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  factory Appearance.fromJson(json) {
    return Appearance(
      gender: json['gender'],
      race: json['race'],
      height: json['height'].cast<String>(),
      weight: json['weight'].cast<String>(),
      eyeColor: json['eye-color'],
      hairColor: json['hair-color'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eye-color'] = this.eyeColor;
    data['hair-color'] = this.hairColor;
    return data;
  }
}

class Work {
  final String occupation;
  final String base;

  Work({
    required this.occupation,
    required this.base,
  });

  factory Work.fromJson(json) {
    return Work(
      occupation: json['occupation'],
      base: json['base'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupation'] = this.occupation;
    data['base'] = this.base;
    return data;
  }
}

class Connections {
  final String group;
  final String relatives;
  Connections({
    required this.group,
    required this.relatives,
  });

  factory Connections.fromJson(json) {
    return Connections(
      group: json['group'],
      relatives: json['relatives'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['relatives'] = this.relatives;
    return data;
  }
}

class Image {
  final String url;
  Image({
    required this.url,
  });

  factory Image.fromJson(json) {
    return Image(url: json['url']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
