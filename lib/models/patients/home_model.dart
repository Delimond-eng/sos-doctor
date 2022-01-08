class HomeContent {
  Content content;

  HomeContent({this.content});

  HomeContent.fromJson(Map<String, dynamic> json) {
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class Content {
  List<HomeMedecins> medecins;

  Content({this.medecins});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['medecins'] != null) {
      medecins = new List<HomeMedecins>();
      json['medecins'].forEach((v) {
        medecins.add(new HomeMedecins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medecins != null) {
      data['medecins'] = this.medecins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeMedecins {
  String medecinId;
  String nom;
  String photo;
  int cote;
  List<HomeSpecialites> specialites;

  HomeMedecins(
      {this.medecinId, this.nom, this.photo, this.cote, this.specialites});

  HomeMedecins.fromJson(Map<String, dynamic> json) {
    medecinId = json['medecin_id'];
    nom = json['nom'];
    photo = json['photo'];
    cote = json['cote'];
    if (json['specialites'] != null) {
      specialites = new List<HomeSpecialites>();
      json['specialites'].forEach((v) {
        specialites.add(new HomeSpecialites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_id'] = this.medecinId;
    data['nom'] = this.nom;
    data['photo'] = this.photo;
    data['cote'] = this.cote;
    if (this.specialites != null) {
      data['specialites'] = this.specialites.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeSpecialites {
  String specialite;

  HomeSpecialites({this.specialite});

  HomeSpecialites.fromJson(Map<String, dynamic> json) {
    specialite = json['specialite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialite'] = this.specialite;
    return data;
  }
}
