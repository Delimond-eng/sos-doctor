class MedDiagnostics {
  List<Examens> examens;

  MedDiagnostics({this.examens});

  MedDiagnostics.fromJson(Map<String, dynamic> json) {
    if (json['examens'] != null) {
      examens = <Examens>[];
      json['examens'].forEach((v) {
        examens.add(Examens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (examens != null) {
      data['examens'] = examens.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = {};
    data['examen_id'] = examenId;
    data['examen_document'] = examenDocument;
    return data;
  }
}
