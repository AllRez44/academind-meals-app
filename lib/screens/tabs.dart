import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/main.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showMealToggleFavoriteMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isMarked = _favoriteMeals.contains(meal);
    setState(() {
      if (isMarked) {
        _favoriteMeals.remove(meal);
        _showMealToggleFavoriteMessage('Meal is no longer in the favorites');
      } else {
        _favoriteMeals.add(meal);
        _showMealToggleFavoriteMessage('Meal was marked as a favorite');
      }
    });
  }

  bool _isMealFavorite(Meal meal) => _favoriteMeals.contains(meal);

  bool _validateMealByFilters(Meal meal) {
    final glutenFreeCheck = _selectedFilters[Filter.glutenFree]!
        ? meal.isGlutenFree == _selectedFilters[Filter.glutenFree]!
        : true;
    final lactoseFreeCheck = _selectedFilters[Filter.lactoseFree]!
        ? meal.isLactoseFree == _selectedFilters[Filter.lactoseFree]!
        : true;
    final vegetarianCheck = _selectedFilters[Filter.vegetarian]!
        ? meal.isVegetarian == _selectedFilters[Filter.vegetarian]!
        : true;
    final veganCheck = _selectedFilters[Filter.vegan]!
        ? meal.isVegan == _selectedFilters[Filter.vegan]!
        : true;

    return (glutenFreeCheck && lactoseFreeCheck && vegetarianCheck && veganCheck);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(activeFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =
        dummyMeals.where((meal) => _validateMealByFilters(meal)).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      isMealFavorite: _isMealFavorite,
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        isMealFavorite: _isMealFavorite,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
