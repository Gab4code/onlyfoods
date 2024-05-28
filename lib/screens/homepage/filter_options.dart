import 'package:flutter/material.dart';

class FilterOptions {
  static Future<Set<String>?> show(BuildContext context, Set<String> selectedFilters) async {
    final selected = Set<String>.from(selectedFilters);

    final result = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterOptionTile(title: 'Mains', selectedFilters: selected),  //passes widget.title to gridview
                FilterOptionTile(title: 'Pasta', selectedFilters: selected),
                FilterOptionTile(title: 'Snacks', selectedFilters: selected),
                FilterOptionTile(title: 'Drinks', selectedFilters: selected),
                FilterOptionTile(title: 'Dessert', selectedFilters: selected),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selected);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    return result;
  }
}

class FilterOptionTile extends StatefulWidget {
  final String title;
  final Set<String> selectedFilters;

  const FilterOptionTile({Key? key, required this.title, required this.selectedFilters}) : super(key: key);

  @override
  _FilterOptionTileState createState() => _FilterOptionTileState();
}

class _FilterOptionTileState extends State<FilterOptionTile> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.selectedFilters.contains(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {        //enable or disable selectedfilter
            widget.selectedFilters.add(widget.title);
          } else {
            widget.selectedFilters.remove(widget.title);
          }
        });
      },
    );
  }
}
