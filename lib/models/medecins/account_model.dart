class Medecins {
  int id;
  String nom;
  String email;
  String identifiant;
  String telephone;
  String password;
  String gender;
  String photo;
  String langue;

  String specialite;
  String entite;
  String experience;
  String periodeDebut;
  String periodeFin;

  String pays;
  String ville;
  String adresse;

  String institut;
  String etude;
  String certificat;

  Medecins({
    this.id,
    this.nom,
    this.email,
    this.telephone,
    this.identifiant,
    this.password,
    this.gender,
    this.photo,
    this.specialite,
    this.entite,
    this.experience,
    this.periodeDebut,
    this.periodeFin,
    this.pays,
    this.ville,
    this.adresse,
    this.institut,
    this.etude,
    this.certificat,
    this.langue,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (json["medecin_id"] != null) json["medecin_id"] = id;
    if (json["nom"] != null) json["nom"] = nom;
    if (json["email"] != null) json["email"] = email;
    if (json["identifiant"] != null) json["identifiant"] = identifiant;
    if (json["telephone"] != null) json["telephone"] = telephone;
    if (json["langue"] != null) json["tlangue"] = langue;
    if (json["pass"] != null) json["pass"] = password;
    if (json["sexe"] != null) json["sexe"] = gender;
    if (json["photo"] != null) json["photo"] = photo;
    if (json["specialite"] != null) json["specialite"] = specialite;
    if (json["entite"] != null) json["entite"] = entite;
    if (json["experience"] != null) json["experience"] = experience;
    if (json["periode_debut"] != null) json["periode_debut"] = periodeDebut;
    if (json["periode_fin"] != null) json["periode_fin"] = periodeFin;
    if (json["pays"] != null) json["pays"] = pays;
    if (json["ville"] != null) json["ville"] = ville;
    if (json["adresse"] != null) json["adresse"] = adresse;
    if (json["institut"] != null) json["institut"] = institut;
    if (json["etude"] != null) json["etude"] = etude;
    if (json["certificat"] != null) json["certificat"] = certificat;
    return json;
  }

  Medecins.fromJson(Map<String, dynamic> data) {
    id = data["medecin_id"];
    nom = data["nom"];
    email = data["email"];
    identifiant = data["identifiant"];
    telephone = data["telephone"];
    password = data["pass"];
    gender = data["sexe"];
    specialite = data["specialite"];
    langue = data["langue"];
    if (data["photo"] != null) photo = data["photo"];
    if (data["specialite"] != null) specialite = data["specialite"];
    if (data["entite"] != null) entite = data["entite"];
    if (data["experience"] != null) experience = data["experience"];
    if (data["periode_debut"] != null) periodeDebut = data["periode_debut"];
    if (data["periode_fin"] != null) periodeFin = data["periode_fin"];
    if (data["pays"] != null) pays = data["pays"];
    if (data["ville"] != null) ville = data["ville"];
    if (data["adresse"] != null) adresse = data["adresse"];
    if (data["institut"] != null) institut = data["institut"];
    if (data["etude"] != null) etude = data["etude"];
    if (data["certificat"] != null) certificat = data["certificat"];
  }
}

class AgendaConfig {
  String medecinId;
  String date;
  String startHour;
  String endHour;
  AgendaConfig({
    this.medecinId,
    this.date,
    this.startHour,
    this.endHour,
  });
}
