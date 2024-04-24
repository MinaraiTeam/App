import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as date_picker;
import 'package:intl/intl.dart';
import 'package:minarai/enums/config.dart';

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
  int _number = 0;
  
  // Filters
  String _filterBy = '*';  
  String _order = 'ASC';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double containerHeight = screenHeight * 0.6; // 60% of screen height
    double containerWidth = screenWidth * 0.8; // 80% of screen width

    return Container(
      height: containerHeight,
      width: containerWidth,
      color: Config.backgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter By:', style: TextStyle(color: Config.fontText, fontSize: Config.h3)),
          _buildDropdown('Filter By', ['*', 'date', 'views', 'comments'], ['All', 'Date', 'Views', 'Comments'], _filterBy,
              (val) => setState(() => _filterBy = val!)),
          SizedBox(height: 15),
          Text('Order:', style: TextStyle(color: Config.fontText, fontSize: Config.h3)),
          _buildDropdown('Order', ['ASC', 'DESC'], ['Ascending', 'Descending'], _order,
              (val) => setState(() => _order = val!)),
          SizedBox(height: 15),
          Text('Date:', style: TextStyle(color: Config.fontText, fontSize: Config.h3)),
          Row(
            children: [
              GestureDetector(
                onTap: _showDatePicker,
                child: Container(
                  color: Colors.transparent,
                  child: Icon(Icons.calendar_month_outlined, color: Config.fontText, size: Config.iconW,)),
              ),
              SizedBox(width: 15,),
              Text(DateFormat('dd/MM/yyyy').format(_selectedDate), style: TextStyle(color: Config.fontText, fontSize: Config.hMini),)
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a DropdownButton used for selecting a value from a list.
  Widget _buildDropdown(String title, List<String> optionValues, List<String> optionNames, String currentValue, ValueChanged<String?> onChanged) {
    List<DropdownMenuItem<String>> dropdownItems = [];
 
    for (int i = 0; i < optionValues.length; i++) {
      dropdownItems.add(
        DropdownMenuItem<String>(
          value: optionValues[i],
          child: Text(optionNames[i], style: TextStyle(color: Config.fontText),),
        ),
      );
    }

    return DropdownButton<String>(
      isExpanded: true,
      dropdownColor: Config.secondaryColor,
      value: optionValues[optionValues.indexOf(currentValue)],
      onChanged: onChanged,
      items: dropdownItems,
    );
  }

  /// Displays a DatePicker to select a date.
  void _showDatePicker() {
    date_picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2024, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() {
          _selectedDate = date;
          // Optionally, you might want to format the date immediately for display or use.
          String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
          print("Selected Date: $formattedDate"); // For debugging
        });
      },
      currentTime: _selectedDate,
      locale: date_picker.LocaleType.es,
      theme: date_picker.DatePickerTheme(
        backgroundColor: Config.backgroundColor,
        itemStyle: TextStyle(color: Config.fontText),
        doneStyle: TextStyle(color: Config.fontText, fontSize: 16, fontWeight: FontWeight.bold),
        cancelStyle: TextStyle(color: Config.errorColor, fontSize: 16, fontWeight: FontWeight.bold),
      ), 
    );
  }
}
