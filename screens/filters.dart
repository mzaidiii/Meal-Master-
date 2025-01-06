import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key, required this.currentFiltets});
  final Map<Filters, bool> currentFiltets;
  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

var _glutenFree = false;
var _lactosFree = false;
var _vegitarianFree = false;
var _veganFree = false;

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filterProvider);
    _glutenFree = activeFilter[Filters.glutenFree]!;
    _lactosFree = activeFilter[Filters.lactosFree]!;
    _vegitarianFree = activeFilter[Filters.vegitarian]!;
    _veganFree = activeFilter[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Yours Filters ...'),
        ),
        body: PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            if (didPop) return;
            Navigator.of(context).pop({
              Filters.glutenFree: _glutenFree,
              Filters.lactosFree: _lactosFree,
              Filters.vegitarian: _vegitarianFree,
              Filters.vegan: _veganFree,
            });
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFree,
                onChanged: (ischecked) {
                  setState(() {
                    _glutenFree = ischecked;
                  });
                },
                title: Text(
                  'Gluten-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'These are the Gluten free meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              SwitchListTile(
                value: _lactosFree,
                onChanged: (ischecked) {
                  setState(() {
                    _lactosFree = ischecked;
                  });
                },
                title: Text(
                  'Lactos-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'These are the Lactos free meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              SwitchListTile(
                value: _vegitarianFree,
                onChanged: (ischecked) {
                  setState(() {
                    _vegitarianFree = ischecked;
                  });
                },
                title: Text(
                  'vegitarian',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'These are the vegitarian  meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              SwitchListTile(
                value: _veganFree,
                onChanged: (ischecked) {
                  setState(() {
                    _veganFree = ischecked;
                  });
                },
                title: Text(
                  'Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'These are the vegan meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
