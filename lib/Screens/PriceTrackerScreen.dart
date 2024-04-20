// ignore_for_file: file_names, deprecated_member_use, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Widgets/TreadDetailsTile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' as ex;
import 'package:motatool/Providers/trade_provider.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:printing/printing.dart';

class PriceTrackerScreen extends StatefulWidget {
  const PriceTrackerScreen({super.key});

  @override
  State<PriceTrackerScreen> createState() => _PriceTrackerScreenState();
}

class _PriceTrackerScreenState extends State<PriceTrackerScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fromtimeController = TextEditingController();
  final TextEditingController _totimeController = TextEditingController();

  @override
  void initState() {
    final td = Provider.of<TradeProvider>(context, listen: false);
    td.getTradeData(DateTime.now());
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    td.updateselectedDate(DateTime.now());
    super.initState();
  }

  pw.Table _buildPdfTable(pw.Context context, TradeProvider dp) {
    return pw.Table.fromTextArray(
        headers: _pwbuildHeader()
            .map((e) => pw.Text(e, style: const pw.TextStyle(fontSize: 6)))
            .toList(),
        data: List<List<String>>.generate(
          dp.futureTrade!.length,
          (index) => [
            '${index + 1}',
            DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(dp.futureTrade?[index].entryTime ?? ''))
                .toString(),
            DateFormat("HH:mm:ss")
                .format(DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                    .add(const Duration(hours: 5, minutes: 30)))
                .toString(),
            "${dp.futureTrade?[index].instrument}",
            DateFormat("HH:mm:ss").format(
                DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                    .add(const Duration(hours: 5, minutes: 30))),
            DateFormat("HH:mm:ss").format(DateTime.parse(
                    dp.futureTrade?[index].exitTime ??
                        DateTime.now().toString())
                .add(const Duration(hours: 5, minutes: 30))),
            "${dp.futureTrade?[index].entryPrice?.toStringAsFixed(1)}",
            ((dp.futureTrade?[index].exitPrice ?? 0).toStringAsFixed(1)),
            ((dp.futureTrade?[index].pointsGain ?? 0.0).toStringAsFixed(1)),
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

  Future<void> exportToPdf() async {
    final dp = Provider.of<TradeProvider>(context, listen: false);

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
                    pw.Text("Option Price Report",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.normal)),
                    pw.Text(DateFormat("dd MMM-yyyy").format(dp.selectedDate!),
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
    final file = File(
        '${usplDirectory.path}\\OptionPriceReport_${DateFormat("dd MMM-yyyy").format(dp.selectedDate!)}.pdf');
    final tpdf = await pdf.save();
    await file.writeAsBytes(tpdf.toList());

    // Open the PDF file
    // You can use the `open_file` package or any other method to open the file
  }

  Future<void> exportToExcel() async {
    final dp = Provider.of<TradeProvider>(context, listen: false);
    // Excel generation code
    final excel = ex.Excel.createExcel();
    final sheet = excel[
        'OptionPriceReport ${DateFormat('dd MMM-yyyy').format(dp.selectedDate!)}'];
    // Add headers to Excel sheet
    sheet.appendRow([
      'Sr. No',
      'Date',
      'Entry Time',
      'Instrument',
      'Exit Time',
      'Exit Time',
      'Entry Price',
      'Exit Price',
      'Points Gain',
    ].map((e) => ex.TextCellValue(e)).toList());

    // Add data to Excel sheet
    for (int index = 0; index < dp.futureTrade!.length; index++) {
      sheet.appendRow([
        (index + 1),
        DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(dp.futureTrade?[index].entryTime ?? '')),
        DateFormat("HH:mm:ss").format(
            DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                .add(const Duration(hours: 5, minutes: 30))),
        "${dp.futureTrade?[index].instrument}",
        DateFormat("HH:mm:ss").format(
            DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                .add(const Duration(hours: 5, minutes: 30))),
        DateFormat("HH:mm:ss").format(DateTime.parse(
                dp.futureTrade?[index].exitTime ?? DateTime.now().toString())
            .add(const Duration(hours: 5, minutes: 30))),
        dp.futureTrade?[index].entryPrice ?? 0.0,
        dp.futureTrade?[index].exitPrice ?? 0.0,
        dp.futureTrade?[index].pointsGain ?? 0.0
      ].map((e) => ex.TextCellValue(e.toString())).toList());
    }

    // Save Excel file
    final PathProviderWindows provider = PathProviderWindows();
    final downloadDirectory = await provider.getDownloadsPath();
    final usplDirectory = Directory('${downloadDirectory}\\USPL\\Reports');
    final file = File(
        '${usplDirectory.path}\\OptionPriceReport ${DateFormat('dd MMM yyyy').format(dp.selectedDate!)}.xlsx');
    final tempexcel = await excel.encode();
    await file.writeAsBytes(tempexcel!.toList());

    // Open the Excel file
    // You can use the `open_file` package or any other method to open the file
  }

  Future<void> exportToPrint() async {
    final dp = Provider.of<TradeProvider>(context, listen: false);
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
                    pw.Text("Option Price Report",
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

  @override
  Widget build(BuildContext context) {
    final td = Provider.of<TradeProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateTimePicker(
                  labelText: 'Select Date',
                  controller: _dateController,
                  onTap: () {
                    td.selectDateNow(context).whenComplete(() {
                      if (td.selectedDate != null) {
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(td.selectedDate!);
                      }
                      ;
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildDropdownButton(),
                const SizedBox(
                  width: 10,
                ),
                _buildDateTimePicker(
                  labelText: 'Select From Time',
                  controller: _fromtimeController,
                  // onTap: () => td.fromselectTime(context),
                  onTap: () => td.fromselectTime(context).whenComplete(() {
                    _fromtimeController.text =
                        DateFormat("HH:mm").format(td.fromDate!);
                  }),
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildDateTimePicker(
                  labelText: 'Select To Time',
                  controller: _totimeController,
                  onTap: () => td.toselectTime(context).whenComplete(() {
                    _totimeController.text =
                        DateFormat("HH:mm").format(td.toDate!);
                  }),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        if (td.calculateTimeDifference(
                                td.fromDate!, td.toDate!) <
                            const Duration(hours: 1)) {
                          td.getOptionPrice();
                          td.updateIsLoader(true);
                          td.updateIsVisible(true);
                        } else {
                          _showAboutDialog(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: const Text('Generate')),
                )
              ],
            ),
          ),
          (td.isLoader!)
              ? const CircularProgressIndicator()
              : (td.isVisible)
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                                maximum: td.optionList.isNotEmpty
                                    ? td.getmaxvalue(td.optionList
                                        .map((e) => e.tradePrice ?? 0.0)
                                        .toList())
                                    : 100,
                                minimum: td.optionList.isNotEmpty
                                    ? td.getminvalue(td.optionList
                                        .map((e) => e.tradePrice ?? 0.0)
                                        .toList())
                                    : 0.0),
                            zoomPanBehavior: ZoomPanBehavior(
                                enablePinching: true,
                                enablePanning: true,
                                enableDoubleTapZooming: true,
                                enableMouseWheelZooming: true),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              decimalPlaces: 2,
                              canShowMarker: true,
                              builder: (data, point, series, pointIndex,
                                  seriesIndex) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // const Text("Time :"),
                                          Text(td.optionList[pointIndex].time!),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // const Text("Points Gain :"),
                                          Text((td.optionList[pointIndex]
                                                      .tradePrice ??
                                                  0)
                                              .toStringAsFixed(2)),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              // header: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                            ),
                            series: [
                              LineSeries(
                                dataSource: td.optionList,
                                pointColorMapper: (datum, index) {
                                  if (td.optionList
                                      .map((e) => e.tradePrice)
                                      .toList()[index]
                                      .toString()
                                      .contains("-")) {
                                    return Colors.red;
                                  } else {
                                    return Colors.green;
                                  }
                                },
                                dataLabelMapper: (datum, index) {
                                  return datum.toString();
                                },
                                xValueMapper: (datum, index) =>
                                    td.optionList[index].time,
                                yValueMapper: (datum, index) =>
                                    td.optionList[index].tradePrice,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No of Treads ${td.futureTrade?.length}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: td.futureTrade!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  td.updateSelectedTread(index);
                  td.updateIsVisible(false);
                  td.updateselectedItem(td.futureTrade![index].instrument);
                  td.updateFromDate(
                      DateTime.tryParse(td.futureTrade![index].entryTime!)!
                          .add(const Duration(hours: 5, minutes: 30)));
                  _fromtimeController.text =
                      DateFormat("HH:mm").format(td.fromDate!);
                  td.updateToDate(
                      DateTime.tryParse(td.futureTrade![index].exitTime!)!
                          .add(const Duration(hours: 5, minutes: 30)));
                  _totimeController.text =
                      DateFormat("HH:mm").format(td.toDate!);
                },
                child: TreadDetailTile(
                  tradeData: td.futureTrade![index],
                  id: index,
                ),
              );
            },
          ))
          /*Expanded(
            child: Padding(
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
                itemCount: dp.futureTrade!.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.white,
                  height: 0.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: ColorManager.balck255,
                rightHandSideColBackgroundColor: ColorManager.balck255,
              ),
            ),
          ),
        */
        ],
      ),
    );
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Error",
                  style: TextStyle(fontSize: 24),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Please select a time duration of 1 hour.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancle"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateTimePicker({
    required String labelText,
    required TextEditingController controller,
    required Function() onTap,
  }) {
    return Expanded(
      child: TextField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        onTap: onTap,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton() {
    final td = Provider.of<TradeProvider>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(3.5),
          child: DropdownButton(
            dropdownColor: ColorManager.balck255,
            isExpanded: true,
            underline: const Divider(color: Colors.transparent),
            hint: const Text('Instrument'),
            style: const TextStyle(color: Colors.white),
            value: td.selectedItem,
            onChanged: (newValue) {
              td.updateselectedItem(newValue.toString());
            },
            items: td.dropdownItems.map((key) {
              return DropdownMenuItem(
                value: key,
                child: FittedBox(
                  child: Text(
                    key,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<String> _pwbuildHeader() {
    return [
      'Sr.No.',
      'Date',
      'Time',
      'Instrument',
      'Entry time',
      'Exit time',
      'Entry Price',
      'Exit Price',
      'Points Gain'
    ];
  }

  List<Widget> _buildHeader() {
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
        width: 150,
        height: 56,
        child: const Text('Date',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 150,
        height: 56,
        child: const Text('Time',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 400,
        height: 56,
        child: const Text('Instrument',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 160,
        height: 56,
        child: const Text('Entry time',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 160,
        height: 56,
        child: const Text('Exit time',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 160,
        height: 56,
        child: const Text('Entry Price',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 160,
        height: 56,
        child: const Text('Exit Price',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        width: 160,
        height: 56,
        child: const Text('Points Gain',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    ];
  }

  Widget _buildLeftSideItem(BuildContext context, int index) {
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

  Widget _buildRightSideItem(BuildContext context, int index) {
    final dp = Provider.of<TradeProvider>(context);
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              DateFormat("yyyy-MM-dd").format(
                  DateTime.parse(dp.futureTrade?[index].entryTime ?? '')),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 150,
            height: 56,
            child: Center(
                child: Text(
              DateFormat("HH:mm:ss").format(
                  DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                      .add(const Duration(hours: 5, minutes: 30))),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 400,
            height: 56,
            child: Center(
                child: Text(
              "${dp.futureTrade?[index].instrument}",
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 160,
            height: 56,
            child: Center(
                child: Text(
              DateFormat("HH:mm:ss").format(
                  DateTime.parse(dp.futureTrade?[index].entryTime ?? '')
                      .add(const Duration(hours: 5, minutes: 30))),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 160,
            height: 56,
            child: Center(
                child: Text(
              DateFormat("HH:mm:ss").format(DateTime.parse(
                      dp.futureTrade?[index].exitTime ??
                          DateTime.now().toString())
                  .add(const Duration(hours: 5, minutes: 30))),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 160,
            height: 56,
            child: Center(
                child: Text(
              "${dp.futureTrade?[index].entryPrice?.toStringAsFixed(1)}",
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 160,
            height: 56,
            child: Center(
                child: Text(
              (dp.futureTrade?[index].exitPrice ?? 0).toStringAsFixed(1),
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            width: 160,
            height: 56,
            child: Center(
                child: Text(
              (dp.futureTrade?[index].pointsGain ?? 0.0).toStringAsFixed(1),
              style: TextStyle(
                  color: (dp.futureTrade?[index].pointsGain ?? 00).isNegative
                      ? Colors.red
                      : Colors.green),
            )),
          ),
        ],
      ),
    );
  }
}
