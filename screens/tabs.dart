import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favorite_provider.dart';
import 'package:meals/provider/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/provider/filters_provider.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactosFree: false,
  Filters.vegitarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _selectedPageindex = 0;
  Map<Filters, bool> _selevtedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meal = ref.watch(mealprovider);
    final activeFilter = ref.watch(filterProvider);
    final availableMeals = meal.where((meal) {
      if (activeFilter[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filters.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filters.vegitarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeScreen = CategoryScreen(
      availableMeal: availableMeals,
    );
    var activepageTitle = "categories";

    if (_selectedPageindex == 1) {
      final favoriteMeal = ref.watch(favoritesMeals);
      activeScreen = MealsScreen(
        meal: favoriteMeal,
      );
      activepageTitle = "Favorites";
    }

    void _setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filter') {
        final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
              currentFiltets: _selevtedFilters,
            ),
          ),
        );
        setState(() {
          _selevtedFilters = result ?? kInitialFilters;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageindex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ]),
    );
  }
}
