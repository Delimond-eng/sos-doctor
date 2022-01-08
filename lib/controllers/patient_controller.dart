// ignore_for_file: deprecated_member_use, prefer_collection_literals
import 'package:get/get.dart';
import 'package:sos_docteur/models/configs_model.dart';
import 'package:sos_docteur/models/inernal_data_model.dart';
import 'package:sos_docteur/models/patients/consult_rdv_model.dart';
import 'package:sos_docteur/models/patients/home_model.dart';
import 'package:sos_docteur/models/patients/patient_diagnostics_model.dart';
import 'package:sos_docteur/models/patients/patient_profile_model.dart';
import 'package:sos_docteur/services/db_service.dart';
import 'package:sos_docteur/services/globals_api/globals_api.dart';
import 'package:sos_docteur/services/patient_api_services/patient_api.dart';
import 'package:sos_docteur/utilities/utilities.dart';

class PatientController extends GetxController {
  static PatientController instance = Get.find();
  // ignore: deprecated_member_use, prefer_collection_literals
  var platformMedecins = List<HomeMedecins>().obs;

  var specialities = List<Specialites>().obs;
  var langues = List<Langues>().obs;

  var currentMedecins = List<IMedecins>().obs;

  var diagnostics = List<ExamensPatient>().obs;

  var user = PatientProfile().obs;

  @override
  onInit() {
    super.onInit();
    refreshDatas();
  }

  Future<List<ConsultationsRdv>> viewRdvs({String key}) async {
    var rdvs = await PatientApi.voirRdvEnLigne(key: key);
    if (rdvs != null) {
      var data = rdvs.consultationsRdv;
      if (data.isEmpty) {
        return [];
      } else {
        return data;
      }
    } else {
      return null;
    }
  }

  Future<List<HomeMedecins>> get medecinsList async {
    var homeDatas = await PatientApi.viewHomeContents();
    if (homeDatas != null) {
      var data = homeDatas.content.medecins;
      return data;
    } else {
      return null;
    }
  }

  Future<void> refreshDatas() async {
    var patientId = storage.read("patient_id");
    //var homeDatas = await PatientApi.viewHomeContents();

    /*if (homeDatas != null) {
      platformMedecins.value = homeDatas.content.medecins;
    }*/
    var s = await GlobalApi.viewHomeConfigs();
    if (s != null) {
      specialities.value = s.config.specialites;
      langues.value = s.config.langues;
    }
    var m = await DBService.getCurrentSearch();
    if (m != null) {
      currentMedecins.value = m;
    }

    if (patientId != null) {
      await refreshProfile();
      var d = await PatientApi.voirDiagnostics();
      if (d != null) {
        diagnostics.value = d.examens;
      }
    }
  }

  Future<void> refreshCurrents() async {
    var m = await DBService.getCurrentSearch();
    if (m != null) {
      currentMedecins.value = m;
    }
  }

  Future<void> refreshDiagnostics() async {
    var d = await PatientApi.voirDiagnostics();
    if (d != null) {
      diagnostics.value = d.examens;
    }
  }

  Future<void> refreshProfile() async {
    var patient = await PatientApi.viewProfil();
    if (patient != null) {
      user.value = patient;
    }
  }
}
