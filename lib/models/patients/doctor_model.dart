class Doctor {
  Reponse reponse;

  Doctor({this.reponse});

  Doctor.fromJson(Map<String, dynamic> json) {
    reponse =
        json['reponse'] != null ? new Reponse.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reponse != null) {
      data['reponse'] = this.reponse.toJson();
    }
    return data;
  }
}

class Reponse {
  String medecinId;
  String photo;
  String nom;
  String telephone;
  String email;
  String sexe;
  String pass;
  String medecinStatus;
  String dateEnregistrement;
  List<Specialites> specialites;
  List<Experiences> experiences;
  List<EtudesFaites> etudesFaites;
  List<Agenda> agenda;

  Reponse({
    this.medecinId,
    this.photo,
    this.nom,
    this.telephone,
    this.email,
    this.sexe,
    this.pass,
    this.medecinStatus,
    this.dateEnregistrement,
    this.specialites,
    this.experiences,
    this.etudesFaites,
    this.agenda,
  });

  Reponse.fromJson(Map<String, dynamic> json) {
    medecinId = json['medecin_id'];
    photo = json['photo'];
    nom = json['nom'];
    telephone = json['telephone'];
    email = json['email'];
    sexe = json['sexe'];
    pass = json['pass'];
    medecinStatus = json['medecin_status'];
    dateEnregistrement = json['date_enregistrement'];
    if (json['specialites'] != null) {
      specialites = new List<Specialites>();
      json['specialites'].forEach((v) {
        specialites.add(new Specialites.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_id'] = this.medecinId;
    data['photo'] = this.photo;
    data['nom'] = this.nom;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['sexe'] = this.sexe;
    data['pass'] = this.pass;
    data['medecin_status'] = this.medecinStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    if (this.specialites != null) {
      data['specialites'] = this.specialites.map((v) => v.toJson()).toList();
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
    return data;
  }
}

class Specialites {
  String medecinSpecialiteId;
  String medecinId;
  String specialite;
  String medecinSpecialiteStatus;
  String dateEnregistrement;

  Specialites(
      {this.medecinSpecialiteId,
      this.medecinId,
      this.specialite,
      this.medecinSpecialiteStatus,
      this.dateEnregistrement});

  Specialites.fromJson(Map<String, dynamic> json) {
    medecinSpecialiteId = json['medecin_specialite_id'];
    medecinId = json['medecin_id'];
    specialite = json['specialite'];
    medecinSpecialiteStatus = json['medecin_specialite_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_specialite_id'] = this.medecinSpecialiteId;
    data['medecin_id'] = this.medecinId;
    data['specialite'] = this.specialite;
    data['medecin_specialite_status'] = this.medecinSpecialiteStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}

class Experiences {
  String medecinExperienceId;
  String medecinId;
  String entite;
  String experience;
  String periodeDebut;
  String periodeFin;
  String adresseId;
  String medecinExperienceStatus;
  String dateEnregistrement;
  Adresse adresse;

  Experiences(
      {this.medecinExperienceId,
      this.medecinId,
      this.entite,
      this.experience,
      this.periodeDebut,
      this.periodeFin,
      this.adresseId,
      this.medecinExperienceStatus,
      this.dateEnregistrement,
      this.adresse});

  Experiences.fromJson(Map<String, dynamic> json) {
    medecinExperienceId = json['medecin_experience_id'];
    medecinId = json['medecin_id'];
    entite = json['entite'];
    experience = json['experience'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    adresseId = json['adresse_id'];
    medecinExperienceStatus = json['medecin_experience_status'];
    dateEnregistrement = json['date_enregistrement'];
    adresse =
        json['adresse'] != null ? new Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_experience_id'] = this.medecinExperienceId;
    data['medecin_id'] = this.medecinId;
    data['entite'] = this.entite;
    data['experience'] = this.experience;
    data['periode_debut'] = this.periodeDebut;
    data['periode_fin'] = this.periodeFin;
    data['adresse_id'] = this.adresseId;
    data['medecin_experience_status'] = this.medecinExperienceStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
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
  String medecinEtudesFaiteId;
  String medecinId;
  String institut;
  String etude;
  String periodeDebut;
  String periodeFin;
  String certificat;
  String adresseId;
  String medecinEtudesFaitesStatus;
  String dateEnregistrement;
  Adresse adresse;

  EtudesFaites(
      {this.medecinEtudesFaiteId,
      this.medecinId,
      this.institut,
      this.etude,
      this.periodeDebut,
      this.periodeFin,
      this.certificat,
      this.adresseId,
      this.medecinEtudesFaitesStatus,
      this.dateEnregistrement,
      this.adresse});

  EtudesFaites.fromJson(Map<String, dynamic> json) {
    medecinEtudesFaiteId = json['medecin_etudes_faite_id'];
    medecinId = json['medecin_id'];
    institut = json['institut'];
    etude = json['etude'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    certificat = json['certificat'];
    adresseId = json['adresse_id'];
    medecinEtudesFaitesStatus = json['medecin_etudes_faites_status'];
    dateEnregistrement = json['date_enregistrement'];
    adresse =
        json['adresse'] != null ? new Adresse.fromJson(json['adresse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_etudes_faite_id'] = this.medecinEtudesFaiteId;
    data['medecin_id'] = this.medecinId;
    data['institut'] = this.institut;
    data['etude'] = this.etude;
    data['periode_debut'] = this.periodeDebut;
    data['periode_fin'] = this.periodeFin;
    data['certificat'] = this.certificat;
    data['adresse_id'] = this.adresseId;
    data['medecin_etudes_faites_status'] = this.medecinEtudesFaitesStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    if (this.adresse != null) {
      data['adresse'] = this.adresse.toJson();
    }
    return data;
  }
}

class Agenda {
  String medecinDatesDisponibleId;
  String medecinId;
  String date;
  String medecinDateDisponibleStatus;
  String dateEnregistrement;
  bool isActive = false;
  List<Heures> heures;

  Agenda({
    this.medecinDatesDisponibleId,
    this.medecinId,
    this.date,
    this.medecinDateDisponibleStatus,
    this.dateEnregistrement,
    this.heures,
  });

  Agenda.fromJson(Map<String, dynamic> json) {
    medecinDatesDisponibleId = json['medecin_dates_disponible_id'];
    medecinId = json['medecin_id'];
    date = json['date'];
    medecinDateDisponibleStatus = json['medecin_date_disponible_status'];
    dateEnregistrement = json['date_enregistrement'];
    if (json['heures'] != null) {
      heures = new List<Heures>();
      json['heures'].forEach((v) {
        heures.add(new Heures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_dates_disponible_id'] = this.medecinDatesDisponibleId;
    data['medecin_id'] = this.medecinId;
    data['date'] = this.date;
    data['medecin_date_disponible_status'] = this.medecinDateDisponibleStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    if (this.heures != null) {
      data['heures'] = this.heures.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heures {
  String medecinHeuresDisponibleId;
  String medecinDatesDisponibleId;
  String medecinId;
  String heureDebut;
  String heureFin;
  String medecinHeuresDisponibleStatus;
  String dateEnregistrement;
  bool isSelected = false;

  Heures(
      {this.medecinHeuresDisponibleId,
      this.medecinDatesDisponibleId,
      this.medecinId,
      this.heureDebut,
      this.heureFin,
      this.medecinHeuresDisponibleStatus,
      this.dateEnregistrement});

  Heures.fromJson(Map<String, dynamic> json) {
    medecinHeuresDisponibleId = json['medecin_heures_disponible_id'];
    medecinDatesDisponibleId = json['medecin_dates_disponible_id'];
    medecinId = json['medecin_id'];
    heureDebut = json['heure_debut'];
    heureFin = json['heure_fin'];
    medecinHeuresDisponibleStatus = json['medecin_heures_disponible_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medecin_heures_disponible_id'] = this.medecinHeuresDisponibleId;
    data['medecin_dates_disponible_id'] = this.medecinDatesDisponibleId;
    data['medecin_id'] = this.medecinId;
    data['heure_debut'] = this.heureDebut;
    data['heure_fin'] = this.heureFin;
    data['medecin_heures_disponible_status'] =
        this.medecinHeuresDisponibleStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
