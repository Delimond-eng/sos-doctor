import 'dart:convert';
import 'package:sos_docteur/models/patients/account_model.dart';
import 'package:sos_docteur/models/patients/consult_rdv_model.dart';
import 'package:sos_docteur/models/patients/doctor_model.dart';
import 'package:sos_docteur/models/patients/home_model.dart';
import 'package:sos_docteur/models/patients/medecin_data_profil_view_model.dart';
import 'package:sos_docteur/models/patients/patient_diagnostics_model.dart';
import 'package:sos_docteur/models/patients/patient_profile_model.dart';

import '../../index.dart';

class PatientApi {
  //patient api request

  ///register account
  ///endpoint: [patients/account/registeraccount]
  ///method:[post]
  ///@param:[nom, email, telephone, pass, sexe]
  // ignore: missing_return

  static Future<Patient> registerAccount({Patient patient}) async {
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "nom": patient.patientNom,
          "email": patient.patientEmail,
          "telephone": patient.patientPhone,
          "pass": patient.patientPass,
          "sexe": patient.patientSexe
        },
        method: "post",
        url: "connexion/patients/registeraccount",
      );
    } catch (err) {
      // ignore: avoid_print
      print("error from patient register account : $err");
    }

    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      } else {
        var data = json["reponse"]["data"];
        if (json["reponse"]["status"] == "success") {
          var result = Patient.fromJson(data);
          return result;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  //register account
  ///endpoint: [patients/account/login]
  ///method:[post]
  ///@param:[identifiant,pass]
  // ignore: missing_return

  static Future<Patient> login({Patient patient}) async {
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "identifiant": patient.patientIdentifiant,
          "pass": patient.patientPass
        },
        method: "post",
        url: "connexion/patients/login",
      );
    } catch (err) {
      // ignore: avoid_print
      print("error from patient register account : $err");
    }

    if (response != null) {
      var json = jsonDecode(response);
      print(json);
      if (json["error"] != null) {
        return null;
      } else {
        var data = json["reponse"]["data"];
        if (json["reponse"]["status"] == "success") {
          var result = Patient.fromJson(data);
          storage.write("isPatient", true);
          storage.write("patient_id", result.patientId);
          storage.write("patient_name", result.patientNom);
          storage.write("patient_email", result.patientEmail);
          return result;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  static Future<PatientProfile> viewProfil() async {
    var patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        method: "post",
        url: "patients/profile",
        body: <String, dynamic>{"patient_id": patientId},
      );
    } catch (err) {
      print("error from annulation consultation $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return PatientProfile.fromJson(json);
    } else {
      return null;
    }
  }

  static Future editProfil({String key, dynamic value}) async {
    var patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        method: "post",
        url: "patients/profile/modifier",
        body: <String, dynamic>{
          "patient_id": patientId,
          key: value,
        },
      );
    } catch (err) {
      print("error from annulation consultation $err");
    }
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

  static Future<HomeContent> viewHomeContents() async {
    var response;
    DateTime _now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int nowTimestamp = _now.microsecondsSinceEpoch;

    if (storage.read('$nowTimestamp') == null) {
      try {
        response = await DApi.request(
          method: "get",
          url: "content/home",
        );
      } catch (err) {
        print("error from annulation consultation $err");
      }
      if (response != null) {
        var json = jsonDecode(response);
        storage.write('$nowTimestamp', json);

        if (json["error"] != null) {
          return null;
        }
        return HomeContent.fromJson(json);
      } else {
        return null;
      }
    } else {
      DateTime _lastDate = _now.subtract(const Duration(days: 1));
      int _lastTimestamp = _lastDate.microsecondsSinceEpoch;
      //print(_lastTimestamp);
      storage.remove('$_lastTimestamp');
      var data = storage.read('$nowTimestamp');
      return HomeContent.fromJson(data);
    }
  }

  static Future evaluerMedecin(
      {String consultId, String evaluation, String key}) async {
    print(evaluation);
    var patientId = storage.read("patient_id");
    var response;
    try {
      switch (key) {
        case "coter":
          response = await DApi.request(
              method: "post",
              url: "patients/consultations/coter",
              body: <String, dynamic>{
                "patient_id": patientId,
                "consultation_rdv_id": consultId,
                "cote": evaluation
              });
          break;
        case "avis":
          response = await DApi.request(
              method: "post",
              url: "patients/consultations/avis",
              body: <String, dynamic>{
                "patient_id": patientId,
                "consultation_rdv_id": consultId,
                "avis": evaluation
              });
          break;
      }
    } catch (err) {
      print("error from annulation consultation $err");
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

//recherche et filtrage de données du médecin
  static Future<HomeContent> searchContents({specialiteId, langueId}) async {
    print("langue $langueId");
    print("specialite $specialiteId");
    var response;
    try {
      response = await DApi.request(
        method: "post",
        url: "content/recherche",
        body: <String, dynamic>{
          "langue_id": langueId.isEmpty ? null : langueId,
          "specialite_id": specialiteId.isEmpty ? null : specialiteId,
        },
      );
    } catch (err) {
      print("error from recherche $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      if (json["content"]["medecins"].isEmpty) {
        return null;
      }
      return HomeContent.fromJson(json);
    } else {
      return null;
    }
  }

//voir le médecin de prêt
  static Future<MedecinDataProfilViewModel> viewMedecinProfil(
      String medecinId) async {
    var response;
    try {
      response = await DApi.request(
        method: "post",
        body: <String, dynamic>{
          "medecin_id": medecinId,
        },
        url: "content/medecin",
      );
    } catch (err) {
      print("error from view single medecin $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json['error'] != null) {
        return null;
      }
      return MedecinDataProfilViewModel.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<Doctor> findMedecin(String medecinId) async {
    var response;
    try {
      response = await DApi.request(
        method: "post",
        body: <String, dynamic>{
          "medecin_id": medecinId,
        },
        url: "content/medecins/view",
      );
    } catch (err) {
      print("error from view single medecin $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json['error'] != null) {
        return null;
      }
      return Doctor.fromJson(json);
    } else {
      return null;
    }
  }

  static Future annulerRdvEnLigne({String consultId}) async {
    var patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "patient_id": patientId,
          "consultation_rdv_id": consultId,
        },
        method: "post",
        url: "patients/consultations/rdv/annuler",
      );
    } catch (err) {
      print("error from annulation consultation $err");
    }
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

  static Future<ConsultRDV> voirRdvEnLigne({String key}) async {
    var patientId = storage.read("patient_id");
    var response;
    try {
      switch (key) {
        case "encours":
          response = await DApi.request(
            body: <String, dynamic>{
              "patient_id": patientId,
            },
            method: "post",
            url: "patients/consultations/rdv/voir",
          );
          break;
        case "anterieur":
          response = await DApi.request(
            body: <String, dynamic>{
              "patient_id": patientId,
            },
            method: "post",
            url: "patients/consultations/rdv/voir/anterieur",
          );
          break;
      }
    } catch (err) {
      print("error from annulation consultation $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return ConsultRDV.fromJson(json);
    } else {
      return null;
    }
  }

  static Future prendreRdvEnLigne({String dateId, String heureId}) async {
    String patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "patient_id": patientId,
          "agenda_heure_id": heureId
        },
        method: "post",
        url: "patients/consultations/rdv",
      );
    } catch (err) {
      print("error from annulation consultation $err");
    }

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

  static Future<PatientDiagnostics> voirDiagnostics() async {
    var patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{"patient_id": patientId},
        method: "post",
        url: "patients/diagnostiques/voir",
      );
    } catch (err) {
      print("error from annulation consultation $err");
    }

    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return PatientDiagnostics.fromJson(json);
    } else {
      return null;
    }
  }

  static Future uploadExamens({String file}) async {
    String patientId = storage.read("patient_id");
    var response;
    try {
      response = await DApi.request(
        body: <String, dynamic>{
          "patient_id": patientId,
          "examen_document": file
        },
        method: "post",
        url: "patients/diagnostiques/uploadexamens",
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
