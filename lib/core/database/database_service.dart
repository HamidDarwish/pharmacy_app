import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late Database _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pharmacy.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    print('✅ Database initialized at: $path');
    return _database;
  }

  Future<void> _onCreate(Database db, int version) async {
    // جدول دوا
    await db.execute('''
      CREATE TABLE medicines (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        genericName TEXT,
        barcode TEXT UNIQUE,
        quantity INTEGER DEFAULT 0,
        minQuantity INTEGER DEFAULT 10,
        unitPrice REAL NOT NULL,
        expiryDate TEXT,
        batch TEXT,
        category TEXT,
        manufacturer TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // جدول فروش
    await db.execute('''
      CREATE TABLE sales (
        id TEXT PRIMARY KEY,
        saleDate TEXT NOT NULL,
        totalAmount REAL NOT NULL,
        discountAmount REAL DEFAULT 0,
        finalAmount REAL NOT NULL,
        paymentMethod TEXT NOT NULL,
        customerName TEXT,
        customerPhone TEXT,
        notes TEXT,
        saleUserId TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');

    // جدول آیتم‌های فروش
    await db.execute('''
      CREATE TABLE sale_items (
        id TEXT PRIMARY KEY,
        saleId TEXT NOT NULL,
        medicineId TEXT NOT NULL,
        medicineName TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unitPrice REAL NOT NULL,
        batchNumber TEXT,
        FOREIGN KEY (saleId) REFERENCES sales(id),
        FOREIGN KEY (medicineId) REFERENCES medicines(id)
      )
    ''');

    // جدول موجودی
    await db.execute('''
      CREATE TABLE inventory (
        id TEXT PRIMARY KEY,
        medicineId TEXT NOT NULL UNIQUE,
        quantity INTEGER DEFAULT 0,
        lastUpdated TEXT NOT NULL,
        FOREIGN KEY (medicineId) REFERENCES medicines(id)
      )
    ''');

    // جدول کاربران
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL UNIQUE,
        passwordHash TEXT NOT NULL,
        fullName TEXT NOT NULL,
        role TEXT NOT NULL,
        isActive INTEGER DEFAULT 1,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');

    print('✅ All tables created successfully');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // برای update های آینده
  }

  Database get database => _database;

  Future<void> closeDatabase() async {
    await _database.close();
  }
}