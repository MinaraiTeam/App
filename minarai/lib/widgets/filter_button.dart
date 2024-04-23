import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

/// A custom IconButton that opens a filter menu.
class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showFilterMenu(context),
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }

  /// Opens a modal bottom sheet to display the FilterMenu widget.
  void showFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterMenu(),
      isScrollControlled: true, // Allow the modal to take full height if needed
    );
  }
}

/// A StatefulWidget that allows users to filter results based on different criteria.
class FilterMenu extends StatefulWidget {
  const FilterMenu({Key? key}) : super(key: key);

  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  String _filterBy = 'date';
  String _order = 'ASC';
  int _number = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Adjust the height here by changing the value of the `height` property.
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.6; // 60% of screen height

    return Container(
      height: containerHeight, // Set the container height
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDropdown('Filter By', ['date', 'views', 'comments'], _filterBy, (val) => setState(() => _filterBy = val!)),
          _buildDropdown('Order', ['ASC', 'DESC'], _order, (val) => setState(() => _order = val!)),
          TextField(
            decoration: const InputDecoration(labelText: 'Enter a number'),
            keyboardType: TextInputType.number,
            onChanged: (value) => setState(() => _number = int.tryParse(value) ?? 0),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: _showDatePicker,
            child: const Text('Select Date'),
          ),
          SizedBox(height: 2,),
          Text('Selected Date: ${_selectedDate.toIso8601String()}'),
        ],
      ),
    );
  }

  /// Builds a DropdownButton used for selecting a value from a list.
  Widget _buildDropdown(String title, List<String> options, String currentValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: onChanged,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  /// Displays a DatePicker to select a date.
  void _showDatePicker() {
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
  }
}
