import 'package:hive/hive.dart';

class HiveManager {
  static late Box box;
  static Future<void> init() async {
    box = await Hive.openBox('userBox');
  }

  static Future<void> addToList(String listName, int movieId) async {
    List<int> currentList = box.get(listName, defaultValue: <int>[])?.cast<int>() ?? [];

    if (!currentList.contains(movieId)) {
      currentList.add(movieId);
    }

    await box.put(listName, currentList);
  }

  static Future<void> removeFromToWatchList(int movieId) async {
    List<int> currentList = (box.get('toWatchList', defaultValue: <int>[])).cast<int>();
    // Ensure the list contains the ID
    if (currentList.contains(movieId)) {
      currentList.remove(movieId);
      await box.put('toWatchList', currentList);
      //print("✅ Removed $movieId → $currentList");
    } else {
      // print("⚠️ $movieId not found in list");
    }
  }

  static List<int> getToWatchList() {
    return box.get('toWatchList', defaultValue: <int>[])?.cast<int>() ?? [];
  }

  static void printToWatchList() {
    List<int> list = getToWatchList();
    print("To Watch List: $list");
  }

  static bool isMovieInToWatchList(int movieId) {
    List<int> currentList = getToWatchList();
    return currentList.contains(movieId);
  }
}
