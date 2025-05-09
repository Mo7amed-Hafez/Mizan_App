import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  // جدول الأقساط
  static const String tableInstallments = 'installments';
  static const String columnId = 'id';
  static const String columnAmount = 'amount';
  static const String columnDate = 'date';
  static const String columnNote = 'note';

  // إنشاء قاعدة البيانات
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // إنشاء القاعدة
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'installments.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // إنشاء جدول الأقساط
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableInstallments(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAmount TEXT,
        $columnDate TEXT,
        $columnNote TEXT
      )
    ''');
  }

  // إضافة قسط جديد
  Future<void> insertInstallment(Map<String, String> installment) async {
    final db = await database;
    await db.insert(
      tableInstallments,
      installment,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // جلب جميع الأقساط
  Future<List<Map<String, dynamic>>> getInstallments() async {
    final db = await database;
    return await db.query(tableInstallments);
  }

  // حذف القسط
  Future<void> deleteInstallment(int id) async {
    final db = await database;
    await db.delete(
      tableInstallments,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // تحديث القسط
  Future<void> updateInstallment(Map<String, String> installment) async {
    final db = await database;
    await db.update(
      tableInstallments,
      installment,
      where: '$columnId = ?',
      whereArgs: [installment['id']],
    );
  }
}
