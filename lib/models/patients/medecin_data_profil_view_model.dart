class MedecinDataProfilViewModel {
  Content content;

  MedecinDataProfilViewModel({this.content});

  MedecinDataProfilViewModel.fromJson(Map<String, dynamic> json) {
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
  Profile profile;

  Content({this.profile});

  Content.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  String numeroOrdre;
  List<Langues> langues;
  List<Experiences> experiences;
  List<EtudesFaites> etudesFaites;
  List<Agenda> agenda;
  List<Avis> avis;

  Profile(
      {this.numeroOrdre,
      this.langues,
      this.experiences,
      this.etudesFaites,
      this.agenda,
      this.avis});

  Profile.fromJson(Map<String, dynamic> json) {
    numeroOrdre = json['numero_ordre'];
    if (json['langues'] != null) {
      langues = new List<Langues>();
      json['langues'].forEach((v) {
        langues.add(new Langues.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      experiences = new List<Experiences>();
      json['experiences'].forEach((v) {
        experiences.add(new Experiences.fromJson(v));
      });
    }
    if (json['etudes_faites'] != null) {
      etudesFaites = new List<EtudesFaites>();
      json['etudes_faites'].forEach((v) {
        etudesFaites.add(new EtudesFaites.fromJson(v));
      });
    }
    if (json['agenda'] != null) {
      agenda = new List<Agenda>();
      json['agenda'].forEach((v) {
        agenda.add(new Agenda.fromJson(v));
      });
    }
    if (json['avis'] != null) {
      avis = new List<Avis>();
      json['avis'].forEach((v) {
        avis.add(new Avis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numero_ordre'] = this.numeroOrdre;
    if (this.langues != null) {
      data['langues'] = this.langues.map((v) => v.toJson()).toList();
    }
    if (this.experiences != null) {
      data['experiences'] = this.experiences.map((v) => v.toJson()).toList();
    }
    if (this.etudesFaites != null) {
      data['etudes_faites'] = this.etudesFaites.map((v) => v.toJson()).toList();
    }
    if (this.agenda != null) {
      data['agenda'] = this.agenda.map((v) => v.toJson()).toList();
    }
    if (this.avis != null) {
      data['avis'] = this.avis.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Langues {
  String langue;

  Langues({this.langue});

  Langues.fromJson(Map<String, dynamic> json) {
    langue = json['langue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['langue'] = this.langue;
    return data;
  }
}

class Experiences {
  String entite;
  String experience;
  String periodeDebut;
  String periodeFin;
  String adresseId;
  Adresse adresse;

  Experiences(
      {this.entite,
      this.experience,
      this.periodeDebut,
      this.periodeFin,
      this.adresseId,
      this.adresse});

  Experiences.fromJson(Map<String, dynamic> json) {
    entite = json['entite'];
    experience = json['experience'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    adresseId = json['adresse_id'];
    adresse =
        json['adresse'] != null ? new Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entite'] = this.entite;
    data['experience'] = this.experience;
    data['periode_debut'] = this.periodeDebut;
    data['periode_fin'] = this.periodeFin;
    data['adresse_id'] = this.adresseId;
    if (this.adresse != null) {
      data['adresse'] = this.adresse.toJson();
    }
    return data;
  }
}

class Adresse {
  String pays;
  String ville;
  String adresse;

  Adresse({this.pays, this.ville, this.adresse});

  Adresse.fromJson(Map<String, dynamic> json) {
    pays = json['pays'];
    ville = json['ville'];
    adresse = json['adresse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pays'] = this.pays;
    data['ville'] = this.ville;
    data['adresse'] = this.adresse;
    return data;
  }
}

class EtudesFaites {
  String institut;
  String etude;
  String periodeDebut;
  String periodeFin;
  String certificat;
  String adresseId;
  Adresse adresse;

  EtudesFaites(
      {this.institut,
      this.etude,
      this.periodeDebut,
      this.periodeFin,
      this.certificat,
      this.adresseId,
      this.adresse});

  EtudesFaites.fromJson(Map<String, dynamic> json) {
    institut = json['institut'];
    etude = json['etude'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    certificat = json['certificat'];
    adresseId = json['adresse_id'];
    adresse =
        json['adresse'] != null ? new Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institut'] = this.institut;
    data['etude'] = this.etude;
    data['periode_debut'] = this.periodeDebut;
    data['periode_fin'] = this.periodeFin;
    data['certificat'] = this.certificat;
    data['adresse_id'] = this.adresseId;
    if (this.adresse != null) {
      data['adresse'] = this.adresse.toJson();
    }
    return data;
  }
}

class Agenda {
  String agendaId;
  String date;
  bool isActive = false;
  List<Heures> heures;

  Agenda({this.agendaId, this.date, this.heures});

  Agenda.fromJson(Map<String, dynamic> json) {
    agendaId = json['agenda_id'];
    date = json['date'];
    if (json['heures'] != null) {
      heures = <Heures>[];
      json['heures'].forEach((v) {
        heures.add(new Heures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agenda_id'] = this.agendaId;
    data['date'] = this.date;
    if (this.heures != null) {
      data['heures'] = this.heures.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heures {
  String agendaHeureId;
  String heure;
  bool isSelected = false;

  Heures({this.agendaHeureId, this.heure});

  Heures.fromJson(Map<String, dynamic> json) {
    agendaHeureId = json['agenda_heure_id'];
    heure = json['heure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agenda_heure_id'] = this.agendaHeureId;
    data['heure'] = this.heure;
    return data;
  }
}

class Avis {
  String patient;
  String avis;
  String dateEnregistrement;

  Avis({this.patient, this.avis, this.dateEnregistrement});

  Avis.fromJson(Map<String, dynamic> json) {
    patient = json['patient'];
    avis = json['avis'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient'] = this.patient;
    data['avis'] = this.avis;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
