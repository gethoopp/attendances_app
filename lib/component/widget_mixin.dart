import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

mixin WidgetMixin<T extends StatefulWidget> on State<T> {
  Future<void> showMyDialog(final String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[Text(message)]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showCalendar({
    required DateTime selectedDate,
    required void Function(DateTime)? onDateChange,
  }) {
    return EasyTheme(
      data: EasyTheme.of(context).copyWithState(
        selectedDayTheme: DayThemeData(
          backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        ),
        unselectedDayTheme: DayThemeData(
          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        selectedCurrentDayTheme: DayThemeData(
          backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        ),
      ),
      child: EasyDateTimeLinePicker(
        firstDate: DateTime.now(),
        lastDate: DateTime(2026, 12, 20),
        focusedDate: selectedDate,
        headerOptions: HeaderOptions(headerType: HeaderType.none),
        selectionMode: SelectionMode.alwaysFirst(),
        onDateChange: onDateChange,
      ),
    );
  }
}
