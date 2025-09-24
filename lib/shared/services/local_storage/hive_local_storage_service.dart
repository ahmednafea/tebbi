import 'package:hive_flutter/hive_flutter.dart';

class HiveLocalStorageService {
  /// Initializes Hive
  static Future<void> initialize() => Hive.initFlutter();

  /// Opens the given box
  static Future<Box<dynamic>> openBox(String boxName) => Hive.openBox<dynamic>(boxName);

  /// Closes the given box
  static Future<void> closeBox(String boxName) => Hive.close();

  /// Deletes all boxes
  static Future<void> deleteAllBoxes() => Hive.deleteFromDisk();

  /// Returns the box with the given name
  static Box<dynamic> getBox(String boxName) => Hive.box<dynamic>(boxName);

  /// Registers a new box with the given name if it's not already opened
  static Future<void> registerUninitializedBox(String name) async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox<dynamic>(name);
    }
  }

  /// Deletes the entry with the given id from the box with the given name
  static Future<void> deleteEntry(String boxKey, String id) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    if (box.containsKey(id)) {
      await box.delete(id);
    }
  }

  /// Returns true if the box with the given name contains an entry with the given id
  static bool containsEntry(String boxKey, String id) {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    return box.containsKey(id);
  }

  /// Deletes all entries from the box with the given name
  static Future<void> deleteAllEntries(String boxKey) async {    
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    await box.clear();
  }

  /// Saves the object with the given id to the box with the given name
  static Future<void> saveEntry(String boxKey, String id, dynamic object) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    await box.put(id, object);
  }

  /// Saves all entries in the given map to the box with the given name
  static Future<void> saveAllEntries(String boxKey, Map<String, dynamic> entries) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    await box.putAll(entries);
  }

  /// Returns a list of all entries in the box with the given name
  static List<dynamic> getAllEntries(String boxKey) {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);

    return box.values.toList();
  }

  /// Returns the entry with the given id from the box with the given name
  static dynamic getEntry(String boxKey, String id) {
    final Box<dynamic> box = Hive.box<dynamic>(boxKey);
    final dynamic singleObject = box.get(id);
    return singleObject;
  } 
}
