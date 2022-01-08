class ConsultRDV {
  List<ConsultationsRdv> consultationsRdv;

  ConsultRDV({this.consultationsRdv});

  ConsultRDV.fromJson(Map<String, dynamic> json) {
    if (json['consultations_rdv'] != null) {
      consultationsRdv = <ConsultationsRdv>[];
      json['consultations_rdv'].forEach((v) {
        consultationsRdv.add(new ConsultationsRdv.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consultationsRdv != null) {
      data['consultations_rdv'] =
          this.consultationsRdv.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultationsRdv {
  String consultationRdvId;
  String medecinId;
  String date;
  String heureDebut;
  String heureFin;
  MedecinRdv medecin;
  List<Consulting> consultations;

  ConsultationsRdv({
    this.consultationRdvId,
    this.medecinId,
    this.date,
    this.heureDebut,
    this.heureFin,
    this.medecin,
    this.consultations,
  });

  ConsultationsRdv.fromJson(Map<String, dynamic> json) {
    consultationRdvId = json['consultation_rdv_id'];
    medecinId = json['medecin_id'];
    date = json['date'];
    heureDebut = json['heure_debut'];
    heureFin = json['heure_fin'];
    medecin = json['medecin'] != null
        ? new MedecinRdv.fromJson(json['medecin'])
        : null;
    if (json['consultation'] != null) {
      consultations = <Consulting>[];
      json['consultation'].forEach((v) {
        consultations.add(new Consulting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_rdv_id'] = this.consultationRdvId;
    data['medecin_id'] = this.medecinId;
    data['date'] = this.date;
    data['heure_debut'] = this.heureDebut;
    data['heure_fin'] = this.heureFin;
    if (this.medecin != null) {
      data['medecin'] = this.medecin.toJson();
    }
    if (this.consultations != null) {
      data['consultation'] = this.consultations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedecinRdv {
  String nom;
  String photo;
  String telephone;
  String email;
  String sexe;

  MedecinRdv({this.nom, this.photo, this.telephone, this.email, this.sexe});

  MedecinRdv.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    photo = json['photo'];
    telephone = json['telephone'];
    email = json['email'];
    sexe = json['sexe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['photo'] = this.photo;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['sexe'] = this.sexe;
    return data;
  }
}

class Consulting {
  String consultationId;
  String consultationReference;

  Consulting({this.consultationId, this.consultationReference});

  Consulting.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    consultationReference = json['consultation_reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_id'] = this.consultationId;
    data['consultation_reference'] = this.consultationReference;
    return data;
  }
}
