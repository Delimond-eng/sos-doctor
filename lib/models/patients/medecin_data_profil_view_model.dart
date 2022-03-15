class MedecinDataProfilViewModel {
  Content content;

  MedecinDataProfilViewModel({this.content});

  MedecinDataProfilViewModel.fromJson(Map<String, dynamic> json) {
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (content != null) {
      data['content'] = content.toJson();
    }
    return data;
  }
}

class Content {
  Profile profile;

  Content({this.profile});

  Content.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (profile != null) {
      data['profile'] = profile.toJson();
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
  List<OrdreMedecin> medecinOrdres;

  Profile({
    this.numeroOrdre,
    this.langues,
    this.experiences,
    this.etudesFaites,
    this.agenda,
    this.avis,
    this.medecinOrdres,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    numeroOrdre = json['numero_ordre'];
    if (json['ordre_medecin'] != null) {
      medecinOrdres = <OrdreMedecin>[];
      json['ordre_medecin'].forEach((v) {
        medecinOrdres.add(OrdreMedecin.fromJson(v));
      });
    }
    if (json['langues'] != null) {
      langues = <Langues>[];
      json['langues'].forEach((v) {
        langues.add(Langues.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences.add(Experiences.fromJson(v));
      });
    }
    if (json['etudes_faites'] != null) {
      etudesFaites = <EtudesFaites>[];
      json['etudes_faites'].forEach((v) {
        etudesFaites.add(EtudesFaites.fromJson(v));
      });
    }
    if (json['agenda'] != null) {
      agenda = <Agenda>[];
      json['agenda'].forEach((v) {
        agenda.add(Agenda.fromJson(v));
      });
    }
    if (json['avis'] != null) {
      avis = <Avis>[];
      json['avis'].forEach((v) {
        avis.add(Avis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numero_ordre'] = numeroOrdre;
    if (langues != null) {
      data['langues'] = langues.map((v) => v.toJson()).toList();
    }
    if (experiences != null) {
      data['experiences'] = experiences.map((v) => v.toJson()).toList();
    }
    if (etudesFaites != null) {
      data['etudes_faites'] = etudesFaites.map((v) => v.toJson()).toList();
    }
    if (agenda != null) {
      data['agenda'] = agenda.map((v) => v.toJson()).toList();
    }
    if (avis != null) {
      data['avis'] = avis.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdreMedecin {
  String numeroOrdre;
  String document;
  String pays;

  OrdreMedecin({this.numeroOrdre, this.document, this.pays});

  OrdreMedecin.fromJson(Map<String, dynamic> json) {
    numeroOrdre = json['numero_ordre'];
    document = json['document'];
    pays = json['pays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numero_ordre'] = numeroOrdre;
    data['document'] = document;
    data['pays'] = pays;
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
    final Map<String, dynamic> data = {};
    data['langue'] = langue;
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
        json['adresse'] != null ? Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['entite'] = entite;
    data['experience'] = experience;
    data['periode_debut'] = periodeDebut;
    data['periode_fin'] = periodeFin;
    data['adresse_id'] = adresseId;
    if (adresse != null) {
      data['adresse'] = adresse.toJson();
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
    final Map<String, dynamic> data = {};
    data['pays'] = pays;
    data['ville'] = ville;
    data['adresse'] = adresse;
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

  EtudesFaites({
    this.institut,
    this.etude,
    this.periodeDebut,
    this.periodeFin,
    this.certificat,
    this.adresseId,
    this.adresse,
  });

  EtudesFaites.fromJson(Map<String, dynamic> json) {
    institut = json['institut'];
    etude = json['etude'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    certificat = json['certificat'];
    adresseId = json['adresse_id'];
    adresse =
        json['adresse'] != null ? Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['institut'] = institut;
    data['etude'] = etude;
    data['periode_debut'] = periodeDebut;
    data['periode_fin'] = periodeFin;
    data['certificat'] = certificat;
    data['adresse_id'] = adresseId;
    if (adresse != null) {
      data['adresse'] = adresse.toJson();
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
        heures.add(Heures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['agenda_id'] = agendaId;
    data['date'] = date;
    if (heures != null) {
      data['heures'] = heures.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = {};
    data['agenda_heure_id'] = agendaHeureId;
    data['heure'] = heure;
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
    final Map<String, dynamic> data = {};
    data['patient'] = patient;
    data['avis'] = avis;
    data['date_enregistrement'] = dateEnregistrement;
    return data;
  }
}
