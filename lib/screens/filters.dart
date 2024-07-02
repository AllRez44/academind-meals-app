import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/filter_switch.dart';
import 'package:meals/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.activeFilters});

  final Map<Filter, bool> activeFilters;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _glutenFreeFilterSet;
  bool? _lactoseFreeFilterSet;
  bool? _vegetarianFilterSet;
  bool? _veganFilterSet;

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

  void _onToggleLactoseFreeFilter(bool value) => setState(() {
    setState(() {
      _lactoseFreeFilterSet = value;
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

/*
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
*/

  @override
  void initState() {
    _glutenFreeFilterSet = widget.activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.activeFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.activeFilters[Filter.vegan]!;
    super.initState();
  }

  void _onPopScreen(bool didPop) {
    if (didPop) return;
    Navigator.of(context).pop({
      Filter.glutenFree: _glutenFreeFilterSet!,
      Filter.lactoseFree: _lactoseFreeFilterSet!,
      Filter.vegetarian: _vegetarianFilterSet!,
      Filter.vegan: _veganFilterSet!,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: _setScreen),
      body: PopScope(
        canPop: false,
        onPopInvoked: _onPopScreen,
        child: Column(
          children: [
            FilterSwitch(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals',
              value: _glutenFreeFilterSet!,
              onChanged: _onToggleGlutenFreeFilter,
            ),
            FilterSwitch(
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals',
              value: _lactoseFreeFilterSet!,
              onChanged: _onToggleLactoseFreeFilter,
            ),
            FilterSwitch(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals',
              value: _vegetarianFilterSet!,
              onChanged: _onToggleVegetarianFilter,
            ),
            FilterSwitch(
              title: 'Vegan',
              subtitle: 'Only include vegan meals',
              value: _veganFilterSet!,
              onChanged: _onToggleVeganFilter,
            ),
          ],
        ),
      ),
    );
  }
}
