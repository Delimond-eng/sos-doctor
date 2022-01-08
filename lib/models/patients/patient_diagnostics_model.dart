class PatientDiagnostics {
  List<ExamensPatient> examens;

  PatientDiagnostics({this.examens});

  PatientDiagnostics.fromJson(Map<String, dynamic> json) {
    if (json['examens'] != null) {
      examens = new List<ExamensPatient>();
      json['examens'].forEach((v) {
        examens.add(new ExamensPatient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.examens != null) {
      data['examens'] = this.examens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamensPatient {
  String examenId;
  String examenDocument;
  List<Diagnostiques> diagnostiques;

  ExamensPatient({this.examenId, this.examenDocument, this.diagnostiques});

  ExamensPatient.fromJson(Map<String, dynamic> json) {
    examenId = json['examen_id'];
    examenDocument = json['examen_document'];
    if (json['diagnostiques'] != null) {
      diagnostiques = new List<Diagnostiques>();
      json['diagnostiques'].forEach((v) {
        diagnostiques.add(new Diagnostiques.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examen_id'] = this.examenId;
    data['examen_document'] = this.examenDocument;
    if (this.diagnostiques != null) {
      data['diagnostiques'] =
          this.diagnostiques.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diagnostiques {
  String diagnostique;

  Diagnostiques({this.diagnostique});

  Diagnostiques.fromJson(Map<String, dynamic> json) {
    diagnostique = json['diagnostique'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diagnostique'] = this.diagnostique;
    return data;
  }
}
