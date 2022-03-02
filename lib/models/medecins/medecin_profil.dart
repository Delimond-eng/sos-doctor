class MedecinProfil {
  MedecinDatas datas;

  MedecinProfil({this.datas});

  MedecinProfil.fromJson(Map<String, dynamic> json) {
    datas =
        json['profile'] != null ? MedecinDatas.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (datas != null) {
      data['profile'] = datas.toJson();
    }
    return data;
  }
}

class MedecinDatas {
  String medecinId;
  String photo;
  String nom;
  String numOrdre;
  String telephone;
  String email;
  String sexe;
  String pass;
  String medecinStatus;
  String dateEnregistrement;
  List<ProfilSpecialites> profilSpecialites;
  List<ProfilEtudesFaites> profilEtudesFaites;
  List<ProfilAgenda> profilAgenda;
  List<ProfilExperiences> profilExperiences;
  List<ProfilLangues> profilLangues;

  MedecinDatas({
    this.medecinId,
    this.photo,
    this.nom,
    this.numOrdre,
    this.telephone,
    this.email,
    this.sexe,
    this.pass,
    this.medecinStatus,
    this.dateEnregistrement,
    this.profilSpecialites,
    this.profilEtudesFaites,
    this.profilAgenda,
    this.profilExperiences,
    this.profilLangues,
  });

  MedecinDatas.fromJson(Map<String, dynamic> json) {
    medecinId = json['medecin_id'];
    photo = json['photo'];
    nom = json['nom'];
    numOrdre = json['numero_ordre'];
    telephone = json['telephone'];
    email = json['email'];
    sexe = json['sexe'];
    pass = json['pass'];
    medecinStatus = json['medecin_status'];
    dateEnregistrement = json['date_enregistrement'];
    if (json['specialites'] != null) {
      profilSpecialites = <ProfilSpecialites>[];
      json['specialites'].forEach((v) {
        profilSpecialites.add(ProfilSpecialites.fromJson(v));
      });
    }
    if (json['etudes'] != null) {
      profilEtudesFaites = <ProfilEtudesFaites>[];
      json['etudes'].forEach((v) {
        profilEtudesFaites.add(ProfilEtudesFaites.fromJson(v));
      });
    }
    if (json['agenda'] != null) {
      profilAgenda = <ProfilAgenda>[];
      json['agenda'].forEach((v) {
        profilAgenda.add(ProfilAgenda.fromJson(v));
      });
    }

    if (json['experiences'] != null) {
      profilExperiences = <ProfilExperiences>[];
      json['experiences'].forEach((v) {
        profilExperiences.add(ProfilExperiences.fromJson(v));
      });
    }

    if (json['langues'] != null) {
      profilLangues = <ProfilLangues>[];
      json['langues'].forEach((v) {
        profilLangues.add(ProfilLangues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['medecin_id'] = medecinId;
    data['photo'] = photo;
    data['nom'] = nom;
    data['numero_ordre'] = numOrdre;
    data['telephone'] = telephone;
    data['email'] = email;
    data['sexe'] = sexe;
    data['pass'] = pass;
    data['medecin_status'] = medecinStatus;
    data['date_enregistrement'] = dateEnregistrement;
    if (profilSpecialites != null) {
      data['specialites'] = profilSpecialites.map((v) => v.toJson()).toList();
    }
    if (profilEtudesFaites != null) {
      data['etudes'] = profilEtudesFaites.map((v) => v.toJson()).toList();
    }
    if (profilAgenda != null) {
      data['agenda'] = profilAgenda.map((v) => v.toJson()).toList();
    }

    if (profilExperiences != null) {
      data['experiences'] = profilExperiences.map((v) => v.toJson()).toList();
    }

    if (profilLangues != null) {
      data['langues'] = profilLangues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfilSpecialites {
  String specialiteId;
  String specialite;

  ProfilSpecialites({this.specialiteId, this.specialite});

  ProfilSpecialites.fromJson(Map<String, dynamic> json) {
    specialiteId = json['specialite_id'];
    specialite = json['specialite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['specialite_id'] = specialiteId;
    data['specialite'] = specialite;
    return data;
  }
}

class ProfilExperiences {
  String medecinExperienceId;
  String medecinId;
  String entite;
  String experience;
  String periodeDebut;
  String periodeFin;
  String adresseId;
  String medecinExperienceStatus;
  String dateEnregistrement;
  String pays;
  String ville;
  String adresse;
  String adresseStatus;

  ProfilExperiences({
    this.medecinExperienceId,
    this.medecinId,
    this.entite,
    this.experience,
    this.periodeDebut,
    this.periodeFin,
    this.adresseId,
    this.medecinExperienceStatus,
    this.dateEnregistrement,
    this.pays,
    this.ville,
    this.adresse,
    this.adresseStatus,
  });

  ProfilExperiences.fromJson(Map<String, dynamic> json) {
    medecinExperienceId = json['medecin_experience_id'];
    medecinId = json['medecin_id'];
    entite = json['entite'];
    experience = json['experience'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    adresseId = json['adresse_id'];
    medecinExperienceStatus = json['medecin_experience_status'];
    dateEnregistrement = json['date_enregistrement'];
    pays = json['pays'];
    ville = json['ville'];
    adresse = json['adresse'];
    adresseStatus = json['adresse_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['medecin_experience_id'] = medecinExperienceId;
    data['medecin_id'] = medecinId;
    data['entite'] = entite;
    data['experience'] = experience;
    data['periode_debut'] = periodeDebut;
    data['periode_fin'] = periodeFin;
    data['adresse_id'] = adresseId;
    data['medecin_experience_status'] = medecinExperienceStatus;
    data['date_enregistrement'] = dateEnregistrement;
    data['pays'] = pays;
    data['ville'] = ville;
    data['adresse'] = adresse;
    data['adresse_status'] = adresseStatus;
    return data;
  }
}

class ProfilEtudesFaites {
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
  String pays;
  String ville;
  String adresse;
  String adresseStatus;

  ProfilEtudesFaites({
    this.medecinEtudesFaiteId,
    this.medecinId,
    this.institut,
    this.etude,
    this.periodeDebut,
    this.periodeFin,
    this.certificat,
    this.adresseId,
    this.medecinEtudesFaitesStatus,
    this.dateEnregistrement,
    this.pays,
    this.ville,
    this.adresse,
    this.adresseStatus,
  });

  ProfilEtudesFaites.fromJson(Map<String, dynamic> json) {
    medecinEtudesFaiteId = json['medecin_etudes_faite_id'];
    medecinId = json['medecin_id'];
    institut = json['institut'];
    etude = json['etude'];
    periodeDebut = json['periode_debut'];
    periodeFin = json['periode_fin'];
    certificat = json['certificat'];
    pays = json['pays'];
    ville = json['ville'];
    adresse = json['adresse'];
    adresseStatus = json['adresse_status'];
    medecinEtudesFaitesStatus = json['medecin_etudes_faites_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['medecin_etudes_faite_id'] = medecinEtudesFaiteId;
    data['medecin_id'] = medecinId;
    data['institut'] = institut;
    data['etude'] = etude;
    data['periode_debut'] = periodeDebut;
    data['periode_fin'] = periodeFin;
    data['certificat'] = certificat;
    data['medecin_etudes_faites_status'] = medecinEtudesFaitesStatus;
    data['date_enregistrement'] = dateEnregistrement;
    data['pays'] = pays;
    data['ville'] = ville;
    data['adresse'] = adresse;
    data['adresse_status'] = adresseStatus;
    return data;
  }
}

class ProfilAgenda {
  String agendaId;
  String date;
  List<HeuresDispo> heures;

  ProfilAgenda({this.agendaId, this.date, this.heures});

  ProfilAgenda.fromJson(Map<String, dynamic> json) {
    agendaId = json['agenda_id'];
    date = json['date'];
    if (json['heures'] != null) {
      heures = <HeuresDispo>[];
      json['heures'].forEach((v) {
        heures.add(HeuresDispo.fromJson(v));
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

class HeuresDispo {
  String agendaHeureId;
  String heure;

  HeuresDispo({this.agendaHeureId, this.heure});

  HeuresDispo.fromJson(Map<String, dynamic> json) {
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

class ProfilLangues {
  String langueId;
  String langue;

  ProfilLangues({this.langueId, this.langue});

  ProfilLangues.fromJson(Map<String, dynamic> json) {
    langueId = json['langue_id'];
    langue = json['langue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['langue_id'] = langueId;
    data['langue'] = langue;
    return data;
  }
}
