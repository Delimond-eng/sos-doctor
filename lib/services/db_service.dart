import 'package:sos_docteur/constants/controllers.dart';
import 'package:sos_docteur/models/inernal_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database _db;
  static const String DB_NAME = 'sos_doctor.db';

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'sos_doctor.db');
    Database db;
    if (db != null) {
      return db;
    }
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  static _onCreate(Database db, int version) async {
    try {
      await db.transaction((txn) async {
        await db.execute(
            "CREATE TABLE medecins(id INTEGER PRIMARY KEY AUTOINCREMENT, medecin_id TEXT, photo TEXT, nom TEXT,specialite TEXT, cote TEXT)");
      });
    } catch (err) {
      print("error from transaction");
    }
  }

  static Future insertNewMedecin({IMedecins medecin, String where}) async {
    var dbClient = await initDb();
    try {
      await dbClient.transaction((txn) async {
        var maps = await txn
            .query("medecins", where: "medecin_id = ?", whereArgs: [where]);
        if (maps.isEmpty || maps == null) {
          var id = await txn.insert("medecins", medecin.toMap());
          print("last insert id : $id");
        }
      });
      await patientController.refreshCurrents();
    } catch (err) {
      print("error from medecin insert to local $err");
    }
  }

  static Future<List<IMedecins>> getCurrentSearch() async {
    var dbClient = await initDb();
    List<Map> medecinsResults;
    List<IMedecins> medecins;
    try {
      medecinsResults = await dbClient.query("medecins", orderBy: "id DESC");
    } catch (err) {
      print("error from medecin get current statement $err");
    }

    if (medecinsResults.isNotEmpty) {
      medecins = List<IMedecins>();
      medecinsResults.forEach((e) {
        medecins.add(IMedecins.fromMap(e));
      });
      return medecins;
    } else {
      return null;
    }
  }
}
