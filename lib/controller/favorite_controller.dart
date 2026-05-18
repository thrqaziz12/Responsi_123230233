import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/meal_model.dart';

class FavoriteController extends GetxController {
  late Box<Meal> _favoriteBox;
  var favorites = <Meal>[].obs;

  @override
  void onInit() {
    super.onInit();
    _favoriteBox = Hive.box<Meal>('favorites');
    _loadFavorites();
  }

  void _loadFavorites() {
    favorites.value = _favoriteBox.values.toList();
  }

  bool isFavorite(String idMeal) {
    return favorites.any((m) => m.idMeal == idMeal);
  }

  Future<void> toggleFavorite(Meal meal) async {
    final existing = _favoriteBox.values
        .firstWhereOrNull((m) => m.idMeal == meal.idMeal);
    if (existing != null) {
      await existing.delete();
    } else {
      await _favoriteBox.add(meal);
    }
    _loadFavorites();
  }

  Future<void> removeFromFavorite(Meal meal) async {
    final existing = _favoriteBox.values
        .firstWhereOrNull((m) => m.idMeal == meal.idMeal);
    if (existing != null) {
      await existing.delete();
      _loadFavorites();
    }
  }
}
