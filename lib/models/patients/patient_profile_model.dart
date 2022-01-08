class PatientProfile {
  Profile profile;

  PatientProfile({this.profile});

  PatientProfile.fromJson(Map<String, dynamic> json) {
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
  String patientId;
  String nom;
  String sexe;
  String email;
  String telephone;
  String pass;
  String patientStatus;
  String dateEnregistrement;

  Profile(
      {this.patientId,
      this.nom,
      this.sexe,
      this.email,
      this.telephone,
      this.pass,
      this.patientStatus,
      this.dateEnregistrement});

  Profile.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    nom = json['nom'];
    sexe = json['sexe'];
    email = json['email'];
    telephone = json['telephone'];
    pass = json['pass'];
    patientStatus = json['patient_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['nom'] = this.nom;
    data['sexe'] = this.sexe;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['pass'] = this.pass;
    data['patient_status'] = this.patientStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
