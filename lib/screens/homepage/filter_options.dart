import 'package:flutter/material.dart';

class FilterOptions {
  static Future<Set<String>?> show(BuildContext context, Set<String> selectedFilters) async {
    final selected = Set<String>.from(selectedFilters);

    final result = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Filter',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color.fromARGB(255, 155, 2, 2), fontFamily: 'Poppins'),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterOptionTile(title: 'Mains', selectedFilters: selected),
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
              child: Text(
                'Apply',
                style: TextStyle(color: Color.fromARGB(255, 155, 2, 2), fontFamily: 'Poppins', fontSize: 16),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
        );
      },
    );

    return result;
  }
}

class FilterOptionTile extends StatefulWidget {
  final String title;
  final Set<String> selectedFilters;

  FilterOptionTile({required this.title, required this.selectedFilters});

  @override
  _FilterOptionTileState createState() => _FilterOptionTileState();
}

class _FilterOptionTileState extends State<FilterOptionTile> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.selectedFilters.contains(widget.title);

    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: isSelected ? Color.fromARGB(255, 155, 2, 2) : Colors.black,
        ),
      ),
      trailing: Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: isSelected ? Color.fromARGB(255, 155, 2, 2) : Colors.grey,
      ),
      onTap: () {
        setState(() {
          if (isSelected) {
            widget.selectedFilters.remove(widget.title);
          } else {
            widget.selectedFilters.add(widget.title);
          }
        });
      },
    );
  }
}
