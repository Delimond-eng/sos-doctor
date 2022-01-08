class Patient {
  String patientId;
  String patientNom;
  String patientEmail;
  String patientPhone;
  String patientIdentifiant;
  String patientSexe;
  String patientPass;
  Patient({
    this.patientId,
    this.patientNom,
    this.patientEmail,
    this.patientPhone,
    this.patientIdentifiant,
    this.patientSexe,
    this.patientPass,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["nom"] = patientNom;
    json["email"] = patientEmail;
    json["telephone"] = patientPhone;
    if (json["identifiant"] != null) {
      json["identifiant"] = patientIdentifiant;
    }
    json["sexe"] = patientSexe;
    json["pass"] = patientPass;

    return json;
  }

  Patient.fromJson(Map<String, dynamic> data) {
    patientId = data["patient_id"];
    patientNom = data["nom"];
    patientIdentifiant = data["identifiant"];
    patientEmail = data["email"];
    patientPhone = data["telephone"];
    patientSexe = data["sexe"];
    patientPass = data["pass"];
  }
}
