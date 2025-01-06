import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteProvider extends StateNotifier<List<Meal>> {
  FavoriteProvider() : super([]);
  bool toggleFavoriteMeals(Meal meal) {
    final isfavoriteMeal = state.contains(meal);
    if (isfavoriteMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMeals =
    StateNotifierProvider<FavoriteProvider, List<Meal>>((ref) {
  return FavoriteProvider();
});
