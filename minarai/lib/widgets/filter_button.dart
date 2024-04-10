import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //showFilterMenu(context);
      },
      icon: Icon(Icons.filter_alt_rounded),
    );
  }

  void showFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return FilterMenu();
      },
    );
  }
}



class FilterMenu extends StatefulWidget {
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  String _filterBy = 'Date';
  String _order = 'Asc';
  int _number = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButton<String>(
            value: _filterBy,
            onChanged: (value) {
              setState(() {
                _filterBy = value!;
              });
            },
            items: <String>['Date', 'Views', 'Comments'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: _order,
            onChanged: (value) {
              setState(() {
                _order = value!;
              });
            },
            items: <String>['Asc', 'Desc'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Enter a number'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _number = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2025, 12, 31),
                onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                currentTime: DateTime.now(),
                locale: LocaleType.es,
              );
            },
            child: Text(
              'Select Date',
            ),
          ),
          Text('Selected Date: ${_selectedDate.toIso8601String()}'),
        ],
      ),
    );
  }
}