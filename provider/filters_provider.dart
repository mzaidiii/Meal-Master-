import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters { glutenFree, lactosFree, vegitarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super(
          {
            Filters.glutenFree: false,
            Filters.lactosFree: false,
            Filters.vegitarian: false,
            Filters.vegan: false
          },
        );

  void setFilter(Filters filters, bool isActive) {
    state = {...state, filters: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref) {
  return FiltersNotifier();
});
