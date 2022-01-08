class ContentConfig {
  Config config;

  ContentConfig({this.config});

  ContentConfig.fromJson(Map<String, dynamic> json) {
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    return data;
  }
}

class Config {
  List<Specialites> specialites;
  List<Langues> langues;

  Config({this.specialites, this.langues});

  Config.fromJson(Map<String, dynamic> json) {
    if (json['specialites'] != null) {
      specialites = <Specialites>[];
      json['specialites'].forEach((v) {
        specialites.add(new Specialites.fromJson(v));
      });
    }
    if (json['langues'] != null) {
      langues = <Langues>[];
      json['langues'].forEach((v) {
        langues.add(new Langues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specialites != null) {
      data['specialites'] = this.specialites.map((v) => v.toJson()).toList();
    }
    if (this.langues != null) {
      data['langues'] = this.langues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specialites {
  String specialiteId;
  String specialite;
  bool isActive = false;

  Specialites({this.specialiteId, this.specialite});

  Specialites.fromJson(Map<String, dynamic> json) {
    specialiteId = json['specialite_id'];
    specialite = json['specialite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialite_id'] = this.specialiteId;
    data['specialite'] = this.specialite;
    return data;
  }
}

class Langues {
  String langueId;
  String langue;

  Langues({this.langueId, this.langue});

  Langues.fromJson(Map<String, dynamic> json) {
    langueId = json['langue_id'];
    langue = json['langue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['langue_id'] = this.langueId;
    data['langue'] = this.langue;
    return data;
  }
}
