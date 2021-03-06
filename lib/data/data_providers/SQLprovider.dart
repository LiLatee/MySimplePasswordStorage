import 'package:aes_crypt/aes_crypt.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../database/database.dart';
import '../entities/account_data_entity.dart';
import '../entities/app_secret_key_entity.dart';
import '../entities/field_data_entity.dart';
import 'base_data_provider.dart';

class SQLprovider implements BaseDataProvider {
  SQLprovider._();
  static final SQLprovider _instance = SQLprovider._internal();

  SQLprovider._internal();
  factory SQLprovider() => _instance;

  // static final SQLprovider _instance = SQLprovider._internal();
  // static final db = SQLprovider();

  // factory SQLprovider() {
  //   return _instance;
  // }

  // SQLprovider._internal();

  static late AppDatabase _SQL_DB;
  initDB() async {
    _SQL_DB =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  String getDatabasePath() {
    return (_SQL_DB.getDatabaseObject() as sqflite.Database).path.toString();
  }

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    // await Future.delayed(Duration(seconds: 3));
    return await _SQL_DB.accountDao.addAccount(accountData);
  }

  Future<void> deleteAccount({required AccountDataEntity accountData}) async {
    return await _SQL_DB.accountDao.deleteAccount(accountData);
  }

  Future<void> updateAccount({required AccountDataEntity accountData}) async {
    return await _SQL_DB.accountDao.updateAccount(accountData);
  }

  Future<AccountDataEntity?> getAccountById(String uuid) async {
    return await _SQL_DB.accountDao.getAccountById(uuid);
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    return await _SQL_DB.accountDao.getAllAccounts();
  }

  Future<void> addField({required FieldDataEntity fieldData}) async {
    return await _SQL_DB.fieldDao.insertField(fieldData);
  }

  Future<void> updateField({required FieldDataEntity fieldData}) async {
    return await _SQL_DB.fieldDao.updateField(fieldData);
  }

  Future<void> deleteField({required FieldDataEntity fieldData}) async {
    return await _SQL_DB.fieldDao.deleteField(fieldData);
  }

  Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountData}) async {
    return await _SQL_DB.fieldDao.getFieldsOfAccount(accountData.uuid!);
  }

  //! AppSecretKey
  Future<void> saveAppSecretKey(
      {required AppSecretKeyEntity appSecretKeyEntity}) async {
    return await _SQL_DB.appSecretKeyDao.insert(appSecretKeyEntity);
  }

  Future<void> importAppSecretKey() async {
    await _SQL_DB.appSecretKeyDao.importAppSecretKey();
  }

  Future<String> exportAppSecretKey({
    required AesCrypt aesCrypt,
    required String databasePath,
    required String path,
  }) async {
    return await _SQL_DB.appSecretKeyDao
        .exportAppSecretKey(aesCrypt, databasePath, path);
  }
}
