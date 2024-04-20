import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:collection/collection.dart';
import 'package:motatool/Services/api_services.dart';
import 'package:motatool/models/OptionPriceModel.dart';
import 'package:motatool/models/TradeDataModel.dart';

class TradeProvider extends ChangeNotifier {
  List<String> _dropdownItems = [];
  int? _selectedTreadid;
  List<String> get dropdownItems => _dropdownItems;
  List<TradeDataModel>? _futureTrade = [];
  List<TradeDataModel>? get futureTrade => _futureTrade;
  bool? _isLoader = false;
  bool _isVisible = false;
  bool? get isLoader => _isLoader;
  bool get isVisible => _isVisible;
  String? _selectedItem;
  String? get selectedItem => _selectedItem;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  DateTime? _fromDate;
  DateTime? _toDate;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  List<OptionPriceModel> _optionList = [];
  List<OptionPriceModel> get optionList => _optionList;
  int? get selectedTreadid => _selectedTreadid;

  updateselectedItem(String? result) {
    _selectedItem = result;
    notifyListeners();
  }

  updateOptionList(List<OptionPriceModel> list) {
    _optionList = list;
    notifyListeners();
  }

  updateDropdown(List<String> newItems) {
    _dropdownItems = newItems;
    notifyListeners();
  }

  updateFromDate(DateTime? newDate) {
    _fromDate = newDate;
    notifyListeners();
  }

  updateIsLoader(bool res) {
    _isLoader = res;
    notifyListeners();
  }

  updateToDate(DateTime? newDate) {
    _toDate = newDate;
    notifyListeners();
  }

  updateTradeData(List<TradeDataModel> list) {
    _futureTrade = list;
    getInstrumentDropdown();
  }

  updateselectedDate(DateTime d) {
    _selectedDate = d;

    notifyListeners();
  }

  updateSelectedTread(int res) {
    _selectedTreadid = res;
    notifyListeners();
  }

  updateIsVisible(bool value) {
    if (_isVisible != value) {
      _isVisible = value;
      notifyListeners();
    }
  }

  getInstrumentDropdown() {
    List<String> temp = [];
    var tempList = (futureTrade ?? []).map((e) => e.instrument).toList();
    for (var item in tempList) {
      if (!temp.contains(item)) {
        temp.add(item ?? "");
      }
    }
    updateDropdown(temp);
  }

  DateTime combineDateTime(TimeOfDay time, DateTime date) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  TimeOfDay getTimeOfDay(DateTime now) {
    TimeOfDay formattedTime = TimeOfDay(hour: now.hour, minute: now.minute);

    return formattedTime;
  }

  Future<void> fromselectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: getTimeOfDay(fromDate ?? DateTime.now()) ?? TimeOfDay.now(),
    );

    if (picked != null) {
      updateFromDate((combineDateTime(picked, selectedDate!)));
    }
  }

  Future<void> toselectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: getTimeOfDay(toDate ?? DateTime.now()) ?? TimeOfDay.now(),
    );
    if (picked != null) {
      updateToDate(combineDateTime(picked, selectedDate!));
    }
  }

  Duration calculateTimeDifference(DateTime fromTime, DateTime toTime) {
    final DateTime fromDateTime =
        DateTime(1, 1, 1, fromTime.hour, fromTime.minute);
    final DateTime toDateTime = DateTime(1, 1, 1, toTime.hour, toTime.minute);

    Duration difference = toDateTime.difference(fromDateTime);

    return difference;
  }

  getTradeData(DateTime? date) async {
    if (date != null) {
      updateDropdown([]);
      final data =
          await getTradeDataBydate(DateFormat('yyyy-MM-dd').format(date));
      updateTradeData(data);
    }
  }

  double getmaxvalue(List<double>? res) {
    var result = 0.0;
    if (res != null) {
      result = (res.max + 10.0);
    }
    return result;
  }

  double getminvalue(List<double>? res) {
    var result = 0.0;
    if (res != null) {
      result = (res.min - 10.0);
    }
    return result;
  }

  getOptionPrice() async {
    if (fromDate != null && toDate != null) {
      final data = await getTradePrice(selectedItem ?? '', fromDate!, toDate!);
      updateOptionList(data);
      updateIsLoader(false);
    }
  }

  Future<void> selectDateNow(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      updateDropdown([]);
      updateselectedItem(null);
      updateselectedDate(picked);
      getTradeData(picked);
    }
  }
}
