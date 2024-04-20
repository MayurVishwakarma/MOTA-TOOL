// ignore_for_file: deprecated_member_use, unnecessary_brace_in_string_interps, file_names, use_build_context_synchronously, prefer_final_fields
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Widgets/UserDetailsTile.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' as ex;
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

class UserReportScren extends StatefulWidget {
  const UserReportScren({super.key});

  @override
  State<UserReportScren> createState() => _UserReportScrenState();
}

class _UserReportScrenState extends State<UserReportScren> {
  @override
  void initState() {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    dp.getUserDetailsListnew();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController _message = TextEditingController();

  Future<void> exportToPdf() async {
    final dp = Provider.of<DashboardProvider>(context, listen: false);

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("Ultimate Scaler Private Limited",
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold)),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("User Report",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.normal)),
                    pw.Text(
                        DateFormat("dd MMM-yyyy HH:MM:SS a")
                            .format(DateTime.now()),
                        style: pw.TextStyle(
                            fontSize: 6, fontWeight: pw.FontWeight.normal))
                  ]),
              pw.SizedBox(height: 15),
              _buildPdfTable(context, dp),
            ],
          );
        },
        // orientation: pw.PageOrientation.landscape,
      ),
    );
    try {
      final PathProviderWindows provider = PathProviderWindows();
      final downloadDirectory = await provider.getDownloadsPath();
      final usplDirectory = Directory('${downloadDirectory}\\USPL\\Reports');
      final file = File('${usplDirectory.path}\\user_report.pdf');
      final tpdf = await pdf.save();
      await file.writeAsBytes(tpdf.toList());
    } catch (e) {
      print(e);
    }
    // Open the PDF file
    // You can use the `open_file` package or any other method to open the file
  }

  Future<void> exportToExcel() async {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    // Excel generation code
    final excel = ex.Excel.createExcel();
    final sheet = excel['UserReportList'];
    // Add headers to Excel sheet
    sheet.appendRow([
      'Sr.No.',
      'Name',
      'Broker',
      'Limit',
      'Margin',
      'Mobile no.',
      'LoginId',
      'Subscription Date',
      'Status',
      'Last Login',
      'BankNifty Auto',
      'Nifty Auto',
      'FinNifty Auto',
      'MidCap Auto',
      'Equity Auto',
      'BankNifty %',
      'Nifty %',
      'FinNifty %',
      'MidCap %',
      'Equity %',
      'DeviceId'
    ].map((e) => ex.TextCellValue(e)).toList());

    // Add data to Excel sheet
    for (int index = 0; index < dp.userDetailsList!.length; index++) {
      sheet.appendRow([
        '${index + 1}',
        dp.userDetailsList![index].name.toString(),
        dp.userDetailsList![index].broker.toString(),
        (dp.userDetailsList![index].investLimit ?? 0.0),
        (dp.userDetailsList![index].margin ?? 0.0),
        dp.userDetailsList![index].mobileNo ?? '',
        dp.userDetailsList![index].loginId ?? '',
        DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(
            dp.userDetailsList![index].subscriptionDate ?? '')!),
        (DateTime.tryParse(dp.userDetailsList![index].subscriptionDate ?? '')!
                .isAfter(DateTime.now()))
            ? "ACTIVE"
            : "INACTIVE",
        DateTime.tryParse(dp.userDetailsList![index].lastLogin ?? "") != null
            ? (DateFormat('dd-MMM-yyyy hh:mm:ss a').format(
                DateTime.tryParse(dp.userDetailsList![index].lastLogin ?? '')!
                    .add(const Duration(hours: 5, minutes: 30))))
            : "",
        (dp.userDetailsList![index].isAuto ?? 0) == 1 ? 'ON' : 'OFF',
        (dp.userDetailsList![index].isNiftyOn ?? 0) == 1 ? 'ON' : 'OFF',
        (dp.userDetailsList![index].isFinNiftyOn ?? 0) == 1 ? 'ON' : 'OFF',
        (dp.userDetailsList![index].isMidCapOn ?? 0) == 1 ? 'ON' : 'OFF',
        (dp.userDetailsList![index].isEquityOn ?? 0) == 1 ? 'ON' : 'OFF',
        (dp.userDetailsList![index].bANKNIFTY ?? ''),
        (dp.userDetailsList![index].nIFTY ?? ''),
        (dp.userDetailsList![index].nIFTYFIN ?? ''),
        (dp.userDetailsList![index].mIDCAP ?? ''),
        (dp.userDetailsList![index].eQUITY ?? ''),
        (dp.userDetailsList![index].deviceId ?? '')
            .replaceAll('{', '')
            .replaceAll('}', ''),
      ].map((e) => ex.TextCellValue(e.toString())).toList());
    }

    // Save Excel file
    final PathProviderWindows provider = PathProviderWindows();
    final downloadDirectory = await provider.getDownloadsPath();
    final usplDirectory = Directory('${downloadDirectory}\\USPL\\Reports');
    final file = File('${usplDirectory.path}\\UserReport.xlsx');
    final tempexcel = await excel.encode();
    await file.writeAsBytes(tempexcel!.toList());

    // Open the Excel file
    // You can use the `open_file` package or any other method to open the file
  }

  Future<void> exportToPrint() async {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("Ultimate Scaler Private Limited",
                  style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold)),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("User Report",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.normal)),
                    pw.Text(
                        DateFormat("dd MMM-yyyy HH:mm:ss a")
                            .format(DateTime.now()),
                        style: pw.TextStyle(
                            fontSize: 6, fontWeight: pw.FontWeight.normal))
                  ]),
              pw.SizedBox(height: 15),
              _buildPdfTable(context, dp),
            ],
          );
        },
      ),
    );
    final PathProviderWindows provider = PathProviderWindows();
    final downloadDirectory = await provider.getDownloadsPath();
    final usplDirectory = Directory('${downloadDirectory}\\USPL\\Reports');
    final file = File('${usplDirectory.path}\\user_report.pdf');
    final pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes);
    // Print the PDF
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
  }

  pw.Table _buildPdfTable(pw.Context context, DashboardProvider dp) {
    return pw.Table.fromTextArray(
        headers: _pwbuildHeader()
            .map((e) => pw.Text(e, style: const pw.TextStyle(fontSize: 6)))
            .toList(),
        data: List<List<String>>.generate(
          dp.userDetailsList!.length,
          (index) => [
            '${index + 1}',
            dp.userDetailsList![index].name.toString(),
            dp.userDetailsList![index].broker.toString(),
            (dp.userDetailsList![index].investLimit ?? ''),
            (dp.userDetailsList![index].margin?.toStringAsFixed(0) ?? ''),
            dp.userDetailsList![index].mobileNo ?? '',
            dp.userDetailsList![index].loginId ?? '',
            DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(
                dp.userDetailsList![index].subscriptionDate ?? '')!),
            (DateTime.tryParse(
                        dp.userDetailsList![index].subscriptionDate ?? '')!
                    .isAfter(DateTime.now()))
                ? "ACTIVE"
                : "INACTIVE",
            DateTime.tryParse(dp.userDetailsList![index].lastLogin ?? "") !=
                    null
                ? (DateFormat('dd-MMM-yyyy hh:mm:ss a').format(
                    DateTime.tryParse(
                            dp.userDetailsList![index].lastLogin ?? '')!
                        .add(const Duration(hours: 5, minutes: 30))))
                : "",
            (dp.userDetailsList![index].isAuto ?? 0) == 1 ? 'ON' : 'OFF',
            (dp.userDetailsList![index].isNiftyOn ?? 0) == 1 ? 'ON' : 'OFF',
            (dp.userDetailsList![index].isFinNiftyOn ?? 0) == 1 ? 'ON' : 'OFF',
            (dp.userDetailsList![index].isMidCapOn ?? 0) == 1 ? 'ON' : 'OFF',
            (dp.userDetailsList![index].isEquityOn ?? 0) == 1 ? 'ON' : 'OFF',
            (dp.userDetailsList![index].bANKNIFTY ?? ''),
            (dp.userDetailsList![index].nIFTY ?? ''),
            (dp.userDetailsList![index].nIFTYFIN ?? ''),
            (dp.userDetailsList![index].mIDCAP ?? ''),
            (dp.userDetailsList![index].eQUITY ?? ''),
            (dp.userDetailsList![index].deviceId ?? '')
                .replaceAll('{', '')
                .replaceAll('}', ''),
          ],
        ),
        headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 6,
        ),
        cellStyle: const pw.TextStyle(
          fontSize: 6,
        ),
        cellAlignment: pw.Alignment.center);
  }

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 55,
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      // test();
                      dp.searchUser(searchController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Text("Search")),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 55,
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      dp.getUserDetailsListnew();
                      searchController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Text("Refresh")),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total Users : ${dp.userDetailsList!.length}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    exportToExcel();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Text(
                            "Excel",
                            style: TextStyle(color: Colors.white),
                          ),
                          SvgPicture.asset(
                            'assets/images/execlicon.svg',
                            height: 25,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    exportToPdf();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Text(
                            "PDF",
                            style: TextStyle(color: Colors.white),
                          ),
                          SvgPicture.asset(
                            'assets/images/pdficon.svg',
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    exportToPrint();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Text(
                            "Print",
                            style: TextStyle(color: Colors.white),
                          ),
                          SvgPicture.asset(
                            'assets/images/printicon.svg',
                            color: Colors.white,
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return _userMessage(
                          context,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(5),
                      child: const Row(
                        children: [
                          Text(
                            "Info",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                          )
                          // SvgPicture.asset(
                          //   'assets/images/printicon.svg',
                          //   color: Colors.white,
                          //   height: 25,
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: dp.userDetailsList!.length,
          itemBuilder: (context, index) {
            return UserDetailTile(
              userdata: dp.userDetailsList![index],
            );
          },
        ))
        // Expanded(child: getUserTable(context))
      ],
    ));
  }

  /*Widget getUserTable(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 1500,
        horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        verticalScrollbarStyle: const ScrollbarStyle(
            thumbColor: Colors.deepOrange,
            thickness: 10,
            radius: Radius.circular(50)),
        horizontalScrollbarStyle: const ScrollbarStyle(
            thumbColor: Colors.deepOrange,
            thickness: 10,
            radius: Radius.circular(50)),
        isFixedHeader: true,
        headerWidgets: _buildHeader(),
        leftSideItemBuilder: _buildLeftSideItem,
        rightSideItemBuilder: _buildRightSideItem,
        itemCount: dp.userDetailsList!.length,
        rowSeparatorWidget: const Divider(
          color: Colors.white,
          height: 0.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: ColorManager.balck255,
        rightHandSideColBackgroundColor: ColorManager.balck255,
      ),
    );
  }
*/
  /*List<Widget> _buildHeader() {
    return [
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Sr.No.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Name',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Broker',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Limit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Margin',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Mobile no.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 150,
        height: 56,
        child: const Text('LoginId',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 150,
        height: 56,
        child: const Text('Subscription Date',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 100,
        height: 56,
        child: const Text('Status',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 150,
        height: 56,
        child: const Text('Last Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 150,
        height: 56,
        child: const Text('Auto Treading',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 300,
        height: 56,
        child: const Text('DeviceId',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )
    ];
  }
*/
/*  Widget _buildLeftSideItem(BuildContext context, int index) {
    return Container(
      color: ColorManager.balck255,
      alignment: Alignment.center,
      width: 100,
      height: 60,
      child: Text('${index + 1}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
*/
  List<String> _pwbuildHeader() {
    return [
      'Sr.No.',
      'Name',
      'Broker',
      'Limit',
      'Margin',
      'Mobile no.',
      'LoginId',
      'Subscription Date',
      'Status',
      'Last Login',
      'BankNifty Auto',
      'Nifty Auto',
      'FinNifty Auto',
      'MidCap Auto',
      'Equity Auto',
      'BankNifty %',
      'Nifty %',
      'FinNifty %',
      'MidCap %',
      'Equity %',
      'DeviceId'
    ];
  }

  /*Widget _buildRightSideItem(BuildContext context, int index) {
    final dp = Provider.of<DashboardProvider>(context);
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              dp.userDetailsList![index].name.toString(),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              dp.userDetailsList![index].broker.toString(),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              '₹ ${dp.userDetailsList![index].investLimit ?? ''}',
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              '₹ ${(dp.userDetailsList![index].margin ?? 0).toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              dp.userDetailsList![index].mobileNo ?? '',
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              dp.userDetailsList![index].loginId ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )),
          ),
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(
                  dp.userDetailsList![index].subscriptionDate ?? '')!),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 100,
            height: 56,
            child: Center(
                child: Text(
              (DateTime.tryParse(
                          dp.userDetailsList![index].subscriptionDate ?? '')!
                      .isAfter(DateTime.now()))
                  ? "ACTIVE"
                  : "INACTIVE",
              style: TextStyle(
                  color: (DateTime.tryParse(
                              dp.userDetailsList![index].subscriptionDate ??
                                  '')!
                          .isAfter(DateTime.now()))
                      ? Colors.green
                      : Colors.red),
            )),
          ),
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              DateTime.tryParse(dp.userDetailsList![index].lastLogin ?? "") !=
                      null
                  ? (DateFormat('dd-MMM-yyyy\n hh:mm:ss a').format(
                      DateTime.tryParse(
                              dp.userDetailsList![index].lastLogin ?? '')!
                          .add(const Duration(hours: 5, minutes: 30))))
                  : "",
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              (dp.userDetailsList![index].isAuto ?? 0) == 1 ? 'ON' : 'OFF',
              style: TextStyle(
                color: (dp.userDetailsList![index].isAuto ?? 0) == 1
                    ? Colors.green
                    : Colors.red,
              ),
            )),
          ),
          SizedBox(
            width: 300,
            height: 56,
            child: Center(
                child: Text(
              (dp.userDetailsList![index].deviceId ?? '')
                  .replaceAll('{', '')
                  .replaceAll('}', ''),
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }
*/
  Widget _userMessage(BuildContext context) {
    final cp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Upload Message'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<DashboardProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Expanded(
                        child: TextFormField(
                          controller: _message,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                            labelText: "Message",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_message.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Update'),
                    content: const Text("Are you sure"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            cp
                                .updateCommanMessage(context, _message.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);

                              _message.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            _message.clear();

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Update'),
                    content: const Text("Blank message can not be updated"),
                    actions: [
                      /*TextButton(
                          onPressed: () {
                            cp
                                .updateUserMessage(context,
                                    widget.userdata.userId, _message.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);

                              _message.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                     */
                      TextButton(
                          onPressed: () {
                            _message.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            _message.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
