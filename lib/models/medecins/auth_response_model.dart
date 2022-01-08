class Medecin {
  String medecinId;
  String photo;
  String nom;
  String telephone;
  String email;
  String sexe;
  String pass;
  String medecinStatus;
  String dateEnregistrement;

  Medecin(
      {this.medecinId,
      this.photo,
      this.nom,
      this.telephone,
      this.email,
      this.sexe,
      this.pass,
      this.medecinStatus,
      this.dateEnregistrement});

  Medecin.fromJson(Map<String, dynamic> json) {
    medecinId = json['medecin_id'];
    photo = json['photo'];
    nom = json['nom'];
    telephone = json['telephone'];
    email = json['email'];
    sexe = json['sexe'];
    pass = json['pass'];
    medecinStatus = json['medecin_status'];
    dateEnregistrement = json['date_enregistrement'];
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
    return data;
  }
}
