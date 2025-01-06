import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealprovider = Provider((ref) {
  return dummyMeals;
});
