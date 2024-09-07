import 'dart:io';
import 'package:mes_envies/Models/Article.dart';
import 'package:mes_envies/Models/ItemList.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {

  //2 Tables
  //Table 1 => Liste de mes envies. Ex: Liste informatique, liste de noel (Nom et un Identifiant)
  //Table 2 => Liste des objects. Un ps5, un nouveau clavier. (Nom, prix, magasin, image, l'id de la liste, leur propre id)
  //INTEGER, TEXT, REAL
  //INTEGER PRIMARY KEY pour id unique
  // TEXT NOT NULL

  //Accéder à la Database
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate
    );
  }

  onCreate(Database database, int version) async {
    //Table 1
    await database.execute('''
    CREATE TABLE list (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
    )
    ''');

    //Table 2
    await database.execute('''
    CREATE TABLE article (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL,
    shop TEXT,
    image TEXT,
    list INTEGER
    )
    ''');
  }

  //Obtenir données
  Future<List<ItemList>> allItems() async {
    Database db = await database;
    const query = 'SELECT * FROM list';
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => ItemList.fromMap(map)).toList();
  }

  Future<List<Article>> articlesFromId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query(
      'article',
      where: 'list = ?',
      whereArgs: [id]
    );
    return mapList.map((map) => Article.fromMap(map)).toList();
  }

  //Ajouter des données
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert('list', {"name": text});
    return true;
  }

  Future<bool> upsert(Article article) async {
    Database db = await database;
    (article.id == null)
    ? article.id = await db.insert('article', article.toMap())
        : await db.update('article', article.toMap(),  where: 'id = ?', whereArgs: [article.id]);
    return true;
  }

  //Supprimer liste
  Future<bool> removeItem(ItemList itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id = ?', whereArgs: [itemList.id]);
    //Supprimer aussi tous les articles liés.
    await db.delete('article', where: 'list = ?', whereArgs: [itemList.id]);
    return true;
  }


}