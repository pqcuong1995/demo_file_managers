import 'package:demo_file_manager/model/Item.dart';
import 'package:demo_file_manager/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableItem = 'item';
const String tableUser = 'user';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('database.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future _createTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const idType2 = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const title = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableItem(
      ${ItemFields.cId} $idType,
      ${ItemFields.cTitle} $title,
      ${ItemFields.ctype} $title,
      ${ItemFields.cPath} $textType
    )
    ''');
    await db.execute('''
    CREATE TABLE $tableUser(
      ${UserField.cId} $idType,
      ${UserField.cPassword} $textType
    )
    ''');
  }

  Future<void> insertItem(Item item) async {
    final db = await instance.database;
    db!.insert(tableItem, item.toMap());
  }

  Future<void> savePassword(User user) async {
    final db = await instance.database;
    db!.insert(tableUser, user.toJson());
  }

  Future<List<User>?> getUser() async {
    final db = await instance.database;
    final maps = await db!.query(tableUser);
    if(maps.isNotEmpty){
      return maps.map((e) => User.fromJson(e)).toList();
    }else{
      return null;
    }
  }

  Future<void> insertListItem(List<Item> items) async {
    final db = await instance.database;
    for (Item item in items) {
      db!.insert(tableItem, item.toMap());
    }
  }

  Future<List<Item>?> readAllItem() async {
    final db = await instance.database;
    final maps = await db!.query(tableItem);
    if (maps.isNotEmpty) {
      return maps.map((element) => Item.fromMap(element)).toList();
    } else {
      return null;
    }
  }

  Future<Item?> getOneItemById(int id) async {
    final db = await instance.database;
    final maps = await db!
        .query(tableItem, where: '${ItemFields.cId}=?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Item.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
