import 'package:flutter/material.dart';

class FilterOptions {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterOptionTile(title: 'Meals'),
                FilterOptionTile(title: 'Beverages'),
                FilterOptionTile(title: 'Desserts'),
                FilterOptionTile(title: 'Vegetables'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class FilterOptionTile extends StatefulWidget {
  final String title;

  const FilterOptionTile({Key? key, required this.title}) : super(key: key);

  @override
  _FilterOptionTileState createState() => _FilterOptionTileState();
}

class _FilterOptionTileState extends State<FilterOptionTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
