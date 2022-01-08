class ScheduleModel {
  List<ConsultationsRdv> consultationsRdv;

  ScheduleModel({this.consultationsRdv});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    if (json['consultations_rdv'] != null) {
      consultationsRdv = List<ConsultationsRdv>();
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
  String patientId;
  String nom;
  String telephone;
  String consultationDate;
  String heureDebut;
  String heureFin;
  List<Consultation> consultations;

  ConsultationsRdv(
      {this.consultationRdvId,
      this.patientId,
      this.nom,
      this.telephone,
      this.consultationDate,
      this.heureDebut,
      this.heureFin,
      this.consultations});

  ConsultationsRdv.fromJson(Map<String, dynamic> json) {
    consultationRdvId = json['consultation_rdv_id'];
    patientId = json['patient_id'];
    nom = json['nom'];
    telephone = json['telephone'];
    consultationDate = json['consultation_date'];
    heureDebut = json['heure_debut'];
    heureFin = json['heure_fin'];
    /*if (json['consultation'] != null) {
      consultations = List<Consultation>();
      json['consultation'].forEach((v) {
        consultations.add(new Consultation.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_rdv_id'] = this.consultationRdvId;
    data['patient_id'] = this.patientId;
    data['nom'] = this.nom;
    data['telephone'] = this.telephone;
    data['consultation_date'] = this.consultationDate;
    data['heure_debut'] = this.heureDebut;
    data['heure_fin'] = this.heureFin;
    if (this.consultations != null) {
      data['consultation'] = this.consultations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Consultation {
  String consultationId;
  String consultationReference;

  Consultation({this.consultationId, this.consultationReference});

  Consultation.fromJson(Map<String, dynamic> json) {
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
