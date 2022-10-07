
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica1/models/tareas_model.dart';
import 'package:practica1/models/users_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final nombreBD = 'TAREASBD';
  static final versionDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, nombreBD);
    return await openDatabase(
      rutaBD,
      version: versionDB,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    String query =
        "CREATE TABLE tblTareas( idTarea INTEGER PRIMARY KEY, dscTarea VARCHAR(100), fechaEnt DATE)";
    await db.execute(query);
    String query2 =
        "CREATE TABLE tblUsers( idUser INTEGER PRIMARY KEY, imageUser VARCHAR(100), nameUser VARCHAR(100), emailUser VARCHAR(100), phoneUser VARCHAR(100), gitUser VARCHAR(100))";
    await db.execute(query2);   
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.insert(nomTabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(
      nomTabla,
      row,
      where: 'idTarea = ?',
      whereArgs: [row['idTarea']],
    );
  }
  Future<int> actualizarUsers(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(
      nomTabla,
      row,
      where: 'idUser = ?',
      whereArgs: [row['idUser']],
    );
  }

  Future<int> eliminar(int idTarea, String nomTabla) async {
    var conexion = await database;
    return await conexion.delete(
      nomTabla,
      where: 'idTarea=?',
      whereArgs: [idTarea],
    );
  }
  Future<int> eliminarUser(int idUser, String nomTabla) async {
    var conexion = await database;
    return await conexion.delete(
      nomTabla,
      where: 'idUser=?',
      whereArgs: [idUser],
    );
  }

  Future<List<TareasDAO>> getAllTareas() async {
    var conexion = await database;
    var result = await conexion.query('tblTareas');
    return result.map((mapTarea) => TareasDAO.fromJSON(mapTarea)).toList();
  }
  Future<List<UsersDAO>> getUser() async {
    var conexion = await database;
    var result = await conexion.query('tblUsers');
    return result.map((mapUser) => UsersDAO.fromJSON(mapUser)).toList();
  }

}