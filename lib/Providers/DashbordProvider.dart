// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Services/api_services.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/models/CompanyMasterModel.dart';
import 'package:motatool/models/DailyLoginModel.dart';
import 'package:motatool/models/UserDetailsModel.dart';
import 'package:motatool/models/is_auto_mode.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

enum Keys {
  user,
  apiKey,
  accessToken,
  requestToken,
  apiSecret,
  userType,
  zerodha,
  aliceblue,
  iciciDirect,
  zerodhaMargin,
  kotakUser
}

class DashboardProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  String? _selecteduser;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _pdfString;
  String? _logText;
  bool? _bankniftyauto = true;
  bool? _niftyauto = false;
  bool? _finniftyauto = false;
  bool? _midcapauto = false;
  bool? _equityauto = false;
  String? get selecteduser => _selecteduser;
  String? _selectedLoguser;
  String? get selectLoguser => _selectedLoguser;
  String? _fileName;
  String? _userName;
  String? _broker;
  int? _selectedCompany;
  DateTime? _selectedDate;
  String? _selectedExhange;
  IsAutoModel? _isAutoModel;
  IsAutoModel? get isAutoModel => _isAutoModel;
  String? _selectedSection = 'BANKNIFTY';
  List<CompanyMasterModel> _allcompany = [];
  final List<CompanyMasterModel> _backupComanyList = [];
  List<CompanyMasterModel>? get backupComanyList => _backupComanyList;
  List<String> _dropdownItems = ['NSE', 'BSE'];
  DateTime? get selectedDate => _selectedDate;
  List<UserDetailsModel>? _userDetailsList = [];
  List<DailyLoginModel>? _dailyLoginList = [];
  List<UserDetailsModel>? get userDetailsList => _userDetailsList;
  List<UserDetailsModel>? _backupList = [];
  List<UserDetailsModel>? get backupList => _backupList;
  List<DailyLoginModel>? get dailyLoginList => _dailyLoginList;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  String? get pdfString => _pdfString;
  String? get logText => _logText;
  bool? get bankniftyauto => _bankniftyauto;
  bool? get niftyauto => _niftyauto;
  bool? get finniftyauto => _finniftyauto;
  bool? get midcapauto => _midcapauto;
  bool? get equityauto => _equityauto;
  String? get fileName => _fileName;
  String? get userName => _userName;
  String? get broker => _broker;
  String? get selectedExchange => _selectedExhange;
  List<String> get dropdownItems => _dropdownItems;
  List<CompanyMasterModel> get allcomapny => _allcompany;
  int? get selectedCompany => _selectedCompany;
  String? get selectedSection => _selectedSection;

  updatePageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  updateselectedItem(String? result) {
    _selectedExhange = result;
    notifyListeners();
  }

  updateBankNiftyAuto(bool res) {
    _bankniftyauto = res;
    notifyListeners();
  }

  updateNiftyAuto(bool res) {
    _niftyauto = res;
    notifyListeners();
  }

  updateFinNiftyAuto(bool res) {
    _finniftyauto = res;
    notifyListeners();
  }

  updateMidcapAuto(bool res) {
    _midcapauto = res;
    notifyListeners();
  }

  updateselectedDate(DateTime d) {
    _selectedDate = d;
    notifyListeners();
  }

  updateFileName(String res) {
    _fileName = res;
    notifyListeners();
  }

  updatepdfString(String? res) {
    _pdfString = res;
    notifyListeners();
  }

  updateEquityAuto(bool res) {
    _equityauto = res;
    notifyListeners();
  }

  updateTradeData(List<UserDetailsModel> list) {
    _userDetailsList = list;
    notifyListeners();
  }

  updateCompanyListData(List<CompanyMasterModel> list) {
    _allcompany = list;
    notifyListeners();
  }

  updateSelecteduser(String? res) {
    _selecteduser = res;
    notifyListeners();
  }

  updateSelectedLoguser(String? res) {
    _selectedLoguser = res;
    UserDetailsModel userDetails =
        backupList!.where((element) => element.loginId == res).first;
    _userName = ("${userDetails.userId}_${userDetails.firstName}");
    _broker = userDetails.broker;
    notifyListeners();
  }

  updateLogText(String? res) {
    try {
      _logText = utf8.decode(base64.decode((res ?? '').replaceAll('"', '')));
    } catch (e) {
      _logText = 'No Data Found';
    }
    notifyListeners();
  }

  updateSelectedCompany(int res) {
    _selectedCompany = res;
    notifyListeners();
  }
  // updateUserName(String? res) {
  //   if (res != null) {
  //     UserDetailsModel userDetails =
  //         backupList!.where((element) => element.loginId == res).first;
  //     _userName = ("${userDetails.userId}_${userDetails.firstName}");
  //     _broker = userDetails.broker;
  //     notifyListeners();
  //   } else {}
  // }

  updateDailyLoginData(List<DailyLoginModel> list) {
    _dailyLoginList = list;
    notifyListeners();
  }

  getUserDetailsListnew() async {
    final data = await getUserDetailsList();
    updateTradeData(data);
    _backupList = data;
  }

  getCompanyList() async {
    final data = await getAllCompanyList();
    updateCompanyListData(data);
  }

  getDailyLoginDetailsListnew() async {
    final data = await getDailyLoginDetailsList(
        selecteduser,
        DateFormat('yyyy-MM-dd').format(fromDate!),
        DateFormat('yyyy-MM-dd').format(toDate!));
    updateDailyLoginData(data);
  }

  Future getUserLogFileString(BuildContext context) async {
    print(fileName);
    final data =
        await GetPDFbyPath(context, fileName!, broker!, selectedSection!);
    updatepdfString(data.replaceAll('""', ''));
  }

  updateSelectedSecrionType(String? result) {
    _selectedSection = result;
    notifyListeners();
  }

  searchUser(String name) {
    if ((_backupList ?? []).isNotEmpty) {
      _userDetailsList = _backupList;
    }
    final templist = (userDetailsList ?? []).where((e) {
      if ((e.name ?? "").toLowerCase().contains(name)) {
        return true;
      }
      return false;
    }).toList();
    updateTradeData(templist);
  }

  searchCompany(String name) {
    if ((_backupComanyList).isNotEmpty) {
      _allcompany = _backupComanyList;
    }
    final templist = (allcomapny).where((e) {
      if ((e.symbol ?? "").toLowerCase().contains(name.toLowerCase())) {
        return true;
      }
      return false;
    }).toList();
    updateCompanyListData(templist);
  }

  updateDate({DateTime? from, DateTime? to}) {
    if (from != null) {
      _fromDate = from;
    }
    if (to != null) {
      _toDate = to;
    }
  }

  Future<String?> showCustomDatePicker(BuildContext context,
      {bool isFirstDate = false}) async {
    final date = await showDatePicker(
        context: context,
        initialDate: (isFirstDate)
            ? fromDate ?? DateTime.now()
            : toDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: (isFirstDate)
            ? DateTime(2042)
            : fromDate!.add(const Duration(days: 29)));

    if (date != null) {
      if (isFirstDate == true) {
        updateDate(from: date);
        // Automatically set to date to 30 days from the selected from date
        DateTime maxToDate = date.add(const Duration(days: 29));
        if (toDate == null || toDate!.isAfter(maxToDate)) {
          updateDate(to: maxToDate);
        }
      } else {
        updateDate(to: date);
      }
      return DateFormat('dd-MM-yyyy').format(date);
    } else {
      return null;
    }
  }

  updateIsAutoModel(IsAutoModel? newIsAutoModel) {
    _isAutoModel = newIsAutoModel;
    notifyListeners();
  }

  Future updateIsAuto(BuildContext context) async {
    try {
      if (isAutoModel != null) {
        final res = await updateAutoTrade(isAutoModel!.toJson());
        if (res == true) {
          Utils.showSnackBar(context: context, content: 'Updated Succesfully');
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future updateIsLocal(BuildContext context, int userId, int isLocal) async {
    try {
      final res = await updateTradeLocation(userId, isLocal);
      if (res == true) {
        Utils.showSnackBar(context: context, content: 'Updated Succesfully');
      }
    } catch (e) {
      return null;
    }
  }

  //   getIsAutoModel() {
  //   if (userDetails != null) {
  //     final newModel = IsAutoModel(
  //         loginId: userDetails?.loginId ?? "",
  //         bnPercent: userDetails?.bankNifty,
  //         nfPercent: userDetails?.niftyFin,
  //         nPercent: userDetails?.nifty,
  //         eqPercent: userDetails?.equity,
  //         mcPercent: userDetails?.midcap,
  //         bnIsAuto: userDetails?.isAuto,
  //         eqIsAuto: userDetails?.isEquityOn,
  //         mcIsAuto: userDetails?.isMidCapOn,
  //         nIsAuto: userDetails?.isNiftyOn,
  //         nfIsAuto: userDetails?.isFinNiftyOn);
  //     updateIsAutoModel(newModel);
  //   }
  // }

  getIsAutoModel(UserDetailsModel? user) {
    if (user != null) {
      final newModel = IsAutoModel(
          loginId: user.loginId ?? "",
          bnPercent: user.bANKNIFTY,
          nfPercent: user.nIFTYFIN,
          nPercent: user.nIFTY,
          eqPercent: user.eQUITY,
          mcPercent: user.mIDCAP,
          bnIsAuto: user.isAuto,
          eqIsAuto: user.isEquityOn,
          mcIsAuto: user.isMidCapOn,
          nIsAuto: user.isNiftyOn,
          nfIsAuto: user.isFinNiftyOn);
      updateIsAutoModel(newModel);
    } else {
      return null;
    }
  }

  submitIsAuto(
      BuildContext context, UserDetailsModel? user, IsAutoModel data) async {
    // data = bankNifty ? 1 : 0;
    if (user != null) {
      // final data = getIsAutoModel(user);
      final res = await updateAutoTrade(data.toJson());
      if (res == true) {
        Utils.showSnackBar(
            content: "update successfully!",
            context: context,
            color: Colors.green);
      }
    }
  }

  getTrueFalse(int? i) {
    if (i == 1) {
      return true;
    }
    return false;
  }

  Future<bool> writeJsonToFile(String jsonData) async {
    try {
      final PathProviderWindows provider = PathProviderWindows();
      final downloadDirectory = await provider.getDownloadsPath();
      final usplDirectory =
          Directory('$downloadDirectory/USPL/User Logs/$selectedSection');

      if (!usplDirectory.existsSync()) {
        usplDirectory.createSync(
            recursive: true); // Create the "USPL" directory if it doesn't exist
      }
      final jsonFile = File('${usplDirectory.path}/$fileName.txt');
      await jsonFile.writeAsString(jsonData);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool>? updateSelectedCompanyData(BuildContext context, int? id,
      String? symbol, String? exchange, String? companyName) {
    if (companyName != null) {
      final res = updateCompanyDetails(id!, symbol!, exchange!, companyName);
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

  Future<bool>? updateCommanMessage(BuildContext context, String? message) {
    if (message != null) {
      final res = updateCommanMsg(message);
      return res;
    }
    return null;
  }

  Future<bool>? updateUserMessage(
      BuildContext context, int? userId, String? message) {
    if (message != null) {
      final res = updateUserMsg(userId!, msg: message);
      return res;
    }
    return null;
  }

  Future<bool>? deleteSelectedCompanyData(
      BuildContext context, String? symbol, String? exchange) {
    if (symbol != null) {
      final res = deleteCompanyDetails(symbol, exchange!);
      return res;
      // if (res == true) {
      //   getCompanyList();
      //   Utils.showSnackBar(
      //       content: "Record Deleted successfully!",
      //       context: context,
      //       color: Colors.green);
      // }
    }
    return null;
  }

  Future<bool>? insertCompanyData(BuildContext context, String? symbol,
      String? exchange, String? companyName) {
    if (companyName != null) {
      final res = insertCompanyDetails(symbol!, exchange!, companyName);
      return res;
    }
    return null;
  }

  Future<void> selectDateNow(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      updateselectedDate(picked);
    }
  }
}
