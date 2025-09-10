import 'package:hive_flutter/hive_flutter.dart';
import 'hiveBoxConst.dart';

class HiveFunctions {
  // Box which will use to store the things
  static final userBox = Hive.box(userHiveBox);

  // Create or add single data in hive
  static createUser(Map data) {
    userBox.add(data);
  }

  // Get All data  stored in hive
  static List getAllUsers() {
    final data = userBox.keys.map((key) {
      final value = userBox.get(key);
      return {"key": key, "name": value["name"], "email": value['email']};
    }).toList();

    return data.reversed.toList();
  }

  // update data for particular user in hive
  static updateUser(int key, Map data) {
    userBox.put(key, data);
  }

  // delete data for particular user in hive
  static deleteUser(int key) {
    return userBox.delete(key);
  }
}