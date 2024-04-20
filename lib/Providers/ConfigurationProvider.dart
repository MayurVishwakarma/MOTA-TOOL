// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Services/api_services.dart';
import 'package:motatool/models/ExpiryModel.dart';
import 'package:motatool/models/HolidayMasterModel.dart';
import 'package:motatool/models/LotSizemasterModel.dart';

class ConfigurationProvider extends ChangeNotifier {
  String? _selectedSection = 'BANKNIFTY';
  String? _selectedConfig = 'HOLIDAY';
  List<ExpirydateMasterModel>? _expirydates;
  LotSizeMasterModel? _lotSizeData;
  List<HolidayMasterModel>? _holidays;
  DateTime? _expiryDate;
  String? _selectedInstrument;
  String? get selectedSection => _selectedSection;
  String? get selectedConfig => _selectedConfig;
  List<ExpirydateMasterModel>? get expirydates => _expirydates;
  LotSizeMasterModel? get lotSizeData => _lotSizeData;
  List<HolidayMasterModel>? get holidays => _holidays;
  DateTime? get expiryDate => _expiryDate;
  String? get selectedInstrument => _selectedInstrument;

  updateSelectedSecrionType(String? result) {
    _selectedSection = result;
    notifyListeners();
  }

  updateSelectedConfig(String? res) {
    _selectedConfig = res;
    notifyListeners();
  }

  updateDate(DateTime? res) {
    _expiryDate = res;
    notifyListeners();
  }

  updateSelectedInstrument(String? res) {
    _selectedInstrument = res;
    notifyListeners();
  }

  getExpiryList(String res) async {
    var list = await getExpiryDates(res);
    if (list.isNotEmpty) {
      updateExpiryDatesList(list);
    }
  }

  getLotSizeData(String res) async {
    LotSizeMasterModel list = await getLotSize(res);
    updateLotSizeDetails(list);
  }

  getHiolidayList() async {
    var list = await getAllHoliday();
    if (list.isNotEmpty) {
      updateHolidayList(list);
    }
  }

  updateExpiryDatesList(List<ExpirydateMasterModel>? res) {
    _expirydates = res;
    notifyListeners();
  }

  updateLotSizeDetails(LotSizeMasterModel? res) {
    _lotSizeData = res;
    notifyListeners();
  }

  updateHolidayList(List<HolidayMasterModel>? res) {
    _holidays = res;
    notifyListeners();
  }

  Future<bool>? updateSelectedExpiryData(
    BuildContext context,
    int? id,
    String? expirydate,
  ) {
    if (expirydates != null) {
      final res = updateExpiryDetails(id!, expirydate!);
      return res;
      // if (res == true) {
      //   getCompanyList();
      //   updateSelectedCompany(0);
      //   Utils.showSnackBar(
      //       content: "update successfully!",
      //       context: context,
      //       color: Colors.green);
      // }
    }
    return null;
  }

  Future<bool>? updateSelectedLotSizeData(
      BuildContext context, int? id, int? lotsize, int? maxqty) {
    if (expirydates != null) {
      final res = updateLotDetails(id!, lotsize!, maxqty!);
      return res;
      // if (res == true) {
      //   getCompanyList();
      //   updateSelectedCompany(0);
      //   Utils.showSnackBar(
      //       content: "update successfully!",
      //       context: context,
      //       color: Colors.green);
      // }
    }
    return null;
  }

  Future<bool>? deleteSelectedExpiryData(BuildContext context, int? id) {
    if (id != null) {
      final res = deleteExpiryDetails(id);
      return res;
    }
    return null;
  }

  Future<bool>? deleteSelectedHoliday(BuildContext context, int? date) {
    if (date != null) {
      final res = deleteHoliday(date);
      return res;
    }
    return null;
  }

  Future<bool>? insertExpityData(
      BuildContext context, String? instrument, String? expirydate) {
    if (expirydate != null) {
      final res = insertExpiryDetails(instrument!, expirydate);
      return res;
    }
    return null;
  }

  Future<bool>? insertHolidayData(
      BuildContext context, String? date, String? holiday) {
    if (date != null) {
      final res = insertHolidayDetails(date, holiday!);
      return res;
    }
    return null;
  }

  Future<bool>? updateSelectedHolidayData(
      BuildContext context, int? id, String? date, String? holiday) {
    if (expirydates != null) {
      final res = updateHolidayDetails(id!, date!, holiday!);
      return res;
    }
    return null;
  }

  Future<String?> showCustomDatePicker(
    BuildContext context,
  ) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2042));

    if (date != null) {
      updateDate(date);
      return DateFormat('yyyy-MM-dd').format(date);
    } else {
      return null;
    }
  }
}
