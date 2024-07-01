import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/filter_switch.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  void _onToggleFilter(bool filter, bool newValue) {
    setState(() {
      filter = newValue;
    });
  }

  void _onToggleGlutenFreeFilter(bool value) => setState(() {
    setState(() {
      _glutenFreeFilterSet = value;
    });
  });

  void _onToggleVegetarianFilter(bool value) => setState(() {
    setState(() {
      _vegetarianFilterSet = value;
    });
  });

  void _onToggleVeganFilter(bool value) => setState(() {
    setState(() {
      _veganFilterSet = value;
    });
  });

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'meals') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const TabsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: Column(
        children: [
          FilterSwitch(
            title: 'Glutten-free',
            subtitle: 'Only include gluten-free meals',
            value: _glutenFreeFilterSet,
            onChanged: _onToggleGlutenFreeFilter,
          ),
          FilterSwitch(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals',
            value: _vegetarianFilterSet,
            onChanged: _onToggleVegetarianFilter,
          ),
          FilterSwitch(
            title: 'Vegan',
            subtitle: 'Only include vegan meals',
            value: _veganFilterSet,
            onChanged: _onToggleVeganFilter,
          ),
        ],
      ),
    );
  }
}
