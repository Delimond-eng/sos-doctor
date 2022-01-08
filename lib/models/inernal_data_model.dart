import 'patients/home_model.dart';

class IMedecins {
  int id;
  String medecinId;
  String photo;
  String nom;
  String specialite;
  String cote;
  List<HomeSpecialites> specialites;
  IMedecins(
      {this.id,
      this.medecinId,
      this.photo,
      this.nom,
      this.specialite,
      this.cote,
      this.specialites});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['medecin_id'] = medecinId;
    data['photo'] = photo;
    data['nom'] = nom;
    data['specialite'] = specialite;
    data['cote'] = cote;

    return data;
  }

  IMedecins.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    medecinId = map['medecin_id'];
    photo = map['photo'];
    nom = map['nom'];

    specialite = map['specialite'];
    cote = map['cote'];
    if (map['specialites'] != null) {
      // ignore: deprecated_member_use
      specialites = List<HomeSpecialites>();
      map['specialites'].forEach((v) {
        specialites.add(HomeSpecialites.fromJson(v));
      });
    }
  }
}
