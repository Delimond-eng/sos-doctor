class MedDiagnostics {
  List<Examens> examens;

  MedDiagnostics({this.examens});

  MedDiagnostics.fromJson(Map<String, dynamic> json) {
    if (json['examens'] != null) {
      examens = new List<Examens>();
      json['examens'].forEach((v) {
        examens.add(new Examens.fromJson(v));
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

class Examens {
  String examenId;
  String examenDocument;

  Examens({this.examenId, this.examenDocument});

  Examens.fromJson(Map<String, dynamic> json) {
    examenId = json['examen_id'];
    examenDocument = json['examen_document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examen_id'] = this.examenId;
    data['examen_document'] = this.examenDocument;
    return data;
  }
}
