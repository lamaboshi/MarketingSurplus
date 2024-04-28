import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences? _sharedPreference;

  Future<SharedPreferences?> init() async {
    _sharedPreference ??= await SharedPreferences.getInstance();
    return _sharedPreference;
  }

  Future<bool> deleteDataByKey(String key) => _sharedPreference!.remove(key);

  void saveData(String key, dynamic value) =>
      _sharedPreference!.setString(key, value.toString());

  void saveBooleanData(String key, bool value) =>
      _sharedPreference!.setBool(key, value);

  bool? getBooleanData(String key) => _sharedPreference?.getBool(key);

  void deleteAllKeys() => _sharedPreference!.clear();

  bool containsKey(String keyDate) => _sharedPreference!.containsKey(keyDate);

  String? getData(String key) {
    if (_sharedPreference!.containsKey(key)) {
      return _sharedPreference!.get(key).toString();
    }
    return null;
  }

  List<String> getAllKeysContainsSubString(String substring) {
    return _sharedPreference!
        .getKeys()
        .toList()
        .where((element) => element.contains(substring))
        .toList();
  }
}
