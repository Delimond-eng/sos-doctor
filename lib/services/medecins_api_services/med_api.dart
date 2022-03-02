import 'dart:convert';

import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/models/medecins/medecin_profil.dart';
import 'package:sos_docteur/models/medecins/medecins_examens_diagnostics_model.dart';
import 'package:sos_docteur/models/medecins/schedule_model.dart';

class MedecinApi {
  //medecin api request

  ///register account
  ///endpoint: [/medecins/compte/register]
  ///method:[post]
  ///@param:[nom, email, telephone, pass, sexe]
  // ignore: missing_return
  static Future<Medecin> registerAccount({Medecins medecin}) async {
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "nom": medecin.nom,
          "email": medecin.email,
          "telephone": medecin.telephone,
          "pass": medecin.password,
          "sexe": medecin.gender
        },
        method: "post",
        url: "connexion/medecins/registeraccount",
      );
    } catch (err) {
      // ignore: avoid_print
      print("error from medecin register account : $err");
    }

    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      } else {
        if (json["reponse"]["status"] == "success") {
          var data = json["reponse"]["data"];
          var result = Medecin.fromJson(data);
          return result;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  ///start and end consulting video call
  ///endpoint [medecins/consultations/commencer] [medecins/consultations/cloturer]
  ///@param [consultId] and [consultRef] for starting
  ///@param [consultId] for closing
  // ignore: missing_return

  static Future consulting(
      {String consultId, String consultRef, String key}) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      switch (key) {
        case "start":
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "consultation_rdv_id": consultId,
              "consultation_reference": consultRef
            },
            method: "post",
            url: "medecins/consultations/commencer",
          );
          break;
        case "end":
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "consultation_id": consultId,
            },
            method: "post",
            url: "medecins/consultations/cloturer",
          );
          storage.remove("consult_id");
          break;
      }
    } catch (err) {
      // ignore: avoid_print
      print("error from medecin register account : $err");
    }

    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      print(json);
      return json;
    } else {
      return null;
    }
  }

  ///medecin login
  ///endpoint [/medecins/compte/login]
  ///@param [email] or [telephone]
  ///@param [pass]
  // ignore: missing_return
  static Future<Medecin> login({Medecins medecin}) async {
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "identifiant": medecin.identifiant,
          "pass": medecin.password
        },
        method: "post",
        url: "connexion/medecins/login",
      );
    } catch (err) {
      print("error from medecin login $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      if (json["reponse"]["status"] == "success") {
        var data = json["reponse"]["data"];
        var result = Medecin.fromJson(data);
        storage.write("medecin_id", result.medecinId);
        storage.write("medecin_nom", result.nom);
        storage.write("medecin_email", result.email);
        storage.write("photo", result.photo);
        storage.write("isMedecin", true);
        //storage.write("photo", result.reponse.data.photo);
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  ///register medecin profil
  ///@param [key] (experience,specialite,etude, avatar)
  ///@param [medecin Object] toJson from medecin Model

  static Future configProfil({String key, Medecins medecin}) async {
    String medecinId = storage.read("medecin_id");
    var response;
    switch (key) {
      case "experience":
        try {
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "experience": medecin.experience,
              "entite": medecin.entite,
              "periode_debut": medecin.periodeDebut,
              "periode_fin": medecin.periodeFin,
              "pays": medecin.pays,
              "ville": medecin.ville,
              "adresse": medecin.adresse
            },
            method: "post",
            url: "medecins/profile/configuration/experiences",
          );
        } catch (err) {
          print("error from medecin profil config experiences : $err");
        }
        break;
      case "specialite":
        try {
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "specialite_id": medecin.specialite,
            },
            method: "post",
            url: "medecins/profile/configuration/specialites",
          );
        } catch (err) {
          print("error from medecin profil config specialites : $err");
        }
        break;
      case "etude":
        try {
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "institut": medecin.institut,
              "etude": medecin.etude,
              "periode_debut": medecin.periodeDebut,
              "periode_fin": medecin.periodeFin,
              "certificat": medecin.certificat,
              "ville": medecin.ville,
              "pays": medecin.pays,
              "adresse": medecin.adresse
            },
            method: "post",
            url: "medecins/profile/configuration/etudesfaites",
          );
        } catch (err) {
          print("error from medecin profil config etudesfaites : $err");
        }
        break;

      case "avatar":
        try {
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "photo": medecin.photo,
            },
            method: "post",
            url: "medecins/profile/configuration/photo",
          );
        } catch (err) {
          print("error from medecin profil config photo : $err");
        }
        break;
      //en cours
      case "langue":
        try {
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
              "langue_id": medecin.langue,
            },
            method: "post",
            url: "medecins/profile/configuration/langues",
          );
        } catch (err) {
          print("error from medecin profil config langue : $err");
        }
    }
    print(response);
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return json;
    } else {
      return null;
    }
  }

  static Future<MedecinProfil> voirProfil() async {
    String medecinId = storage.read("medecin_id");
    try {
      var response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
        },
        method: "post",
        url: "medecins/profile/voir",
      );
      if (response != null) {
        var res = jsonDecode(response);
        print(medecinId);
        if (res["error"] != null) {
          return null;
        }
        return MedecinProfil.fromJson(res);
      } else {
        return null;
      }
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
  }

  ///medecin agenda configuration fat
  ///first step
  ///@param [medecin_id]
  ///@param [date] format dd-MM-yyyy
  ///
  ///2d step
  ///@param [medecin_id]
  ///@param [medecin_dates_disponible_id]
  ///@param [heure_debut] format hh:mm
  ///@param [heure_fin] format hh:mm
  ///@param [key] selector
  static Future configAgenda({AgendaConfig agenda}) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
          "date": agenda.date,
        },
        method: "post",
        url: "medecins/agenda/enregistrer/date",
      );

      if (response != null) {
        var json = jsonDecode(response);
        if (json["error"] != null) {
          return null;
        }
        var agendaId = json["reponse"]["agenda_id"];
        response = await DApi.request(
          body: <String, dynamic>{
            "medecin_id": medecinId,
            "agenda_id": agendaId,
            "heure_debut": agenda.startHour,
            "heure_fin": agenda.endHour
          },
          method: "post",
          url: "medecins/agenda/enregistrer/heure",
        );
        var res = jsonDecode(response);
        if (res["error"] != null) {
          return null;
        }
        return res;
      } else {
        return null;
      }
    } catch (error) {
      print("error from agenda configuration : $error");
      return null;
    }
  }

//en cours
  static Future voirAgenda() async {
    String medecinId = storage.read("medecin_id");
    try {
      var response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
        },
        method: "post",
        url: "medecins/agenda/consulter",
      );

      if (response != null) {
        var res = jsonDecode(response);
        if (res["error"] != null) {
          return null;
        }
        return res;
      } else {
        return null;
      }
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
  }

//en cours
  static Future enregistrerNumOrdre(
      {String numero, String pays, String file}) async {
    String medecinId = storage.read("medecin_id");
    try {
      var response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
          "numero_ordre": numero,
          "pays": pays,
          "document": file,
        },
        method: "post",
        url: "medecins/profile/configuration/ordremedecin",
      );

      if (response != null) {
        var res = jsonDecode(response);
        if (res["error"] != null) {
          return null;
        }
        return res;
      } else {
        return null;
      }
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
  }

  //en cours

  static Future diagnostiquerExamens(
      {String examenId, String diagnostic}) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
          "examen_id": examenId,
          "diagnostique": diagnostic
        },
        method: "post",
        url: "medecins/examens/diagnostique",
      );
    } catch (err) {
      print("error from medecin voir agenda $err");
    }

    if (response != null) {
      var res = jsonDecode(response);
      if (res["error"] != null) {
        return null;
      }
      return res;
    } else {
      return null;
    }
  }

  //en cours
  static Future<ScheduleModel> voirRdvs({String key}) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      switch (key) {
        case "encours":
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
            },
            method: "post",
            url: "medecins/agenda/consulter",
          );
          break;
        case "anterieur":
          response = await DApi.request(
            body: <String, dynamic>{
              "medecin_id": medecinId,
            },
            method: "post",
            url: "medecins/agenda/consulter/anterieur",
          );
          break;
      }
    } catch (err) {
      print("error from medecin voir agenda $err");
    }

    if (response != null) {
      var res = jsonDecode(response);
      if (res["error"] != null) {
        return null;
      }
      return ScheduleModel.fromJson(res);
    } else {
      return null;
    }
  }

//en cours
  static Future<MedDiagnostics> voirExamens() async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
        },
        method: "post",
        url: "medecins/examens/voir",
      );
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
    if (response != null) {
      var res = jsonDecode(response);
      if (res["error"] != null) {
        return null;
      }
      return MedDiagnostics.fromJson(res);
    } else {
      return null;
    }
  }

  static Future deleteProfile({
    String subUrl,
    String key,
    dynamic value,
  }) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
          key: value,
        },
        method: "post",
        url: "medecins/profile/configuration/$subUrl/supprimer",
      );
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
    print(response);
    if (response != null) {
      var res = jsonDecode(response);
      if (res["error"] != null) {
        return null;
      }
      return res;
    } else {
      return null;
    }
  }

  static Future updateProfile({
    String key,
    dynamic value,
  }) async {
    String medecinId = storage.read("medecin_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "medecin_id": medecinId,
          key: value,
        },
        method: "post",
        url: "medecins/profile/configuration/compte",
      );
    } catch (err) {
      print("error from medecin voir agenda $err");
    }
    if (response != null) {
      var res = jsonDecode(response);
      if (res["error"] != null) {
        return null;
      }
      return res;
    } else {
      return null;
    }
  }
}
