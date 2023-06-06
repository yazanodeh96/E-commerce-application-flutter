import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import '../../model/Cart_model.dart';
import '../../model/Home_model.dart';
import 'constans.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database? _database;
  Future<Database> get database async {
    _database = await initDb();
    return _database!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct3.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $tableCartProduct3(
        $columnTitle TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnPrice INTEGER NOT NULL,
        $columndescription TEXT NOT NULL,
        $columnProductID TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL)
       ''');
    });
  }

//  $columnQuantity INTEGER NOT NULL,
  insert(HomeModel model) async {
    var dbCLient = await database;
    await dbCLient.insert(
      tableCartProduct3,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // getAllProduct();
  }

  UpdateProduct(HomeModel model) async {
    var dbCLient = await database;
    return await dbCLient.update(tableCartProduct3, model.toJson(),
        where: '$columnProductID = ?', whereArgs: [model.productID]);
  }

  Future<void> clearDatabase() async {
    // Open the database
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'CartProduct3.db'),
      );
    }

    // Clear the database tables
    await _database?.transaction((txn) async {
      await txn.rawDelete('DELETE FROM CartProduct3');
    });
  }

  Future<List<HomeModel>> getAllProduct() async {
    print("initDB executed");

    var dbCLient = await database;
    List<Map> maps = await dbCLient.query(tableCartProduct3);
    List<HomeModel> list = maps.isNotEmpty
        ? maps.map((product) => HomeModel.fromJson(product)).toList()
        : [];
    print(list);
    return list;
  }
}
