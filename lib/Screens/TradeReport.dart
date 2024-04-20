// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Providers/TradeBookProvider.dart';
import 'package:motatool/Widgets/Summry_widget.dart';
import 'package:motatool/Widgets/custom_textfield.dart';
import 'package:motatool/Widgets/empty.dart';
import 'package:motatool/Widgets/history_container.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TradeReportScreen extends StatefulWidget {
  const TradeReportScreen({super.key});

  @override
  State<TradeReportScreen> createState() => _TradeReportScreenState();
}

class _TradeReportScreenState extends State<TradeReportScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  int noOfDays = 1;

  @override
  void initState() {
    final tdp = Provider.of<TradeBookProvider>(context, listen: false);
    fromDateController.text = tdp.getFirstDateString();
    toDateController.text = tdp.getTodayDateString();
    tdp.updateDate(from: tdp.getFirstDate(), to: DateTime.now());
    tdp.updateBalnce(100000);
    noOfDays = countSelectedDates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tdp.getTradeHistoryModelList(context);
      tdp.getNifty50TradeHistoryList(context);
    });
    super.initState();
  }

  int countSelectedDates() {
    final tdp = Provider.of<TradeBookProvider>(context, listen: false);
    var res = tdp.fromDate
        ?.difference(tdp.toDate!.add(const Duration(days: 1)))
        .inDays
        .abs();
    return res!.toInt();
  }

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final tdp = Provider.of<TradeBookProvider>(context);
    final dp = Provider.of<DashboardProvider>(context);
    // final positionList = dp.kotakPositionList;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'BANKNIFTY');
                                        tdp.getTradeHistoryModelList(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'BANKNIFTY'
                                                ? Colors.deepOrange
                                                : null,
                                            border: tdp.selectedSection !=
                                                    'BANKNIFTY'
                                                ? Border.all(
                                                    color: Colors.white)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'BANKNIFTY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('NIFTY');
                                        tdp.getNifty50TradeHistoryList(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'NIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'NIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'NIFTY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'NIFTY-FIN');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'NIFTY-FIN'
                                                ? Colors.deepOrange
                                                : null,
                                            border: tdp.selectedSection !=
                                                    'NIFTY-FIN'
                                                ? Border.all(
                                                    color: Colors.white)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'NIFTY-FIN',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'MID-CAP');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'MID-CAP'
                                                ? Colors.deepOrange
                                                : null,
                                            border:
                                                tdp.selectedSection != 'MID-CAP'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'MID-CAP',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('STOCK');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'STOCK'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'STOCK'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'STOCK OPTIONS',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('EQUITY');
                                        tdp.getEquityTradeHistoryList(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'EQUITY'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'EQUITY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'EQUITY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4, child: _getReportWidget(tdp.selectedSection))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _getReportWidget(String? res) {
    final tdp = Provider.of<TradeBookProvider>(context);
    switch (res) {
      case 'BANKNIFTY':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      nameController: fromDateController,
                      name: "From Date",
                      readOnly: true,
                      onTap: () async {
                        final result = await tdp.showCustomDatePicker(context,
                            isFirstDate: true); //isFirstDate: true
                        if (result != null) {
                          toDateController.text =
                              DateFormat('dd-MM-yyyy').format(tdp.toDate!);
                          fromDateController.text = result;
                        }
                      },
                    )),
                    Expanded(
                      child: CustomTextField(
                        nameController: toDateController,
                        name: "To Date",
                        readOnly: true,
                        onTap: () async {
                          final result =
                              await tdp.showCustomDatePicker(context);
                          if (result != null) {
                            toDateController.text = result;
                          }
                        },
                      ),
                    ),
                    Container(
                        width: 50,
                        height: 70,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: IconButton(
                            onPressed: () async {
                              if (fromDateController.text.isNotEmpty &&
                                  toDateController.text.isNotEmpty) {
                                noOfDays = countSelectedDates();
                                tdp.updateBalnce(100000);
                                tdp.getTradeHistoryModelList(context);
                              } else {
                                Utils.showSnackBar(
                                    context: context,
                                    content: "Please select Date");
                              }
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'report',
                            groupValue: tdp.reportType,
                            onChanged: (value) {
                              tdp.updateReportType(value);
                            },
                          ),
                          Text(
                            'Report',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'trend',
                            groupValue: tdp.reportType,
                            onChanged: (value) {
                              tdp.updateReportType(value);
                            },
                          ),
                          Text(
                            'Trend',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'fixmargin',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Fixed Margin',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'fixlot',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Fixed Lot',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'cumilative',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Cumilative',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (tdp.tradeHistoryModelList.isEmpty) const EmptyWidget(),
              if (tdp.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
              if (!tdp.isLoading)
                if (tdp.reportType == 'report')
                  Expanded(
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(
                            Colors.deepOrange), // Set the color you desire
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _firstController,
                        thickness: 10,
                        trackVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _firstController,
                          itemCount: tdp.tradeHistoryModelList.length,
                          itemBuilder: (context, index) {
                            return PLReportContainer(
                              tradeHistoryModel:
                                  tdp.tradeHistoryModelList[index],
                              balenceAmount: tdp
                                  .getRemainingAmount(
                                      tdp.tradeHistoryModelList, index)
                                  .toDouble(),
                            ); //PLReportContainer(tradeHistoryModel:tdp.tradeHistoryModelList[index],);
                          },
                        ),
                      ),
                    ),
                  ),
              if (!tdp.isLoading)
                if (tdp.reportType == 'trend')
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enableDoubleTapZooming: true,
                          enableMouseWheelZooming: true),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        decimalPlaces: 2,
                        canShowMarker: true,
                        builder:
                            (data, point, series, pointIndex, seriesIndex) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (data as num).isNegative
                                    ? const Color.fromARGB(255, 201, 16, 3)
                                    : Colors.green),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Date :"),
                                    Text(DateFormat("dd-MM-yyyy").format(tdp
                                        .tradeHistoryModelList[pointIndex]
                                        .buyTime!)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Points Gain :"),
                                    Text((tdp.tradeHistoryModelList[pointIndex]
                                                .pointsGain ??
                                            0)
                                        .toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("P&L :"),
                                    Text((tdp.tradeHistoryModelList[pointIndex]
                                                .profitLoss ??
                                            0)
                                        .toStringAsFixed(2)),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        header: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                      ),
                      series: [
                        StackedColumnSeries(
                          dataSource: tdp.tradeHistoryModelList
                              .map((e) => e.profitLoss)
                              .toList(),
                          pointColorMapper: (datum, index) {
                            if (tdp.tradeHistoryModelList
                                .map((e) => e.profitLoss)
                                .toList()[index]
                                .toString()
                                .contains("-")) {
                              return ColorManager.red;
                            } else {
                              return ColorManager.green;
                            }
                          },
                          dataLabelMapper: (datum, index) {
                            return datum.toString();
                          },
                          xValueMapper: (datum, index) => index + 1,
                          yValueMapper: (datum, index) => datum,
                        )
                      ],
                    ),
                  ),
              if (tdp.reportType == 'report')
                Column(
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(12)
                          // border: const Border(
                          //   top: BorderSide(color: Colors.white, width: 2),
                          // ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Total P&L : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                "${tdp.getTotalPL().toStringAsFixed(2)} ₹",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: (tdp.getTotalPL().isNegative)
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Total Points : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    tdp.getTotalPointsGain().toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: (tdp
                                                .getTotalPointsGain()
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Avg point per day : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    (tdp.getTotalPointsGain() / noOfDays)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: ((tdp.getTotalPointsGain() /
                                                    noOfDays)
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SummryContainer(
                      tradeHistoryModel: tdp.tradeHistoryModelList,
                      balenceAmount: tdp.getTotalPL().toDouble(),
                    )
                  ],
                ),
            ],
          ),
        );
      case 'NIFTY':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      nameController: fromDateController,
                      name: "From Date",
                      readOnly: true,
                      onTap: () async {
                        final result = await tdp.showCustomDatePicker(context,
                            isFirstDate: true); //isFirstDate: true
                        if (result != null) {
                          toDateController.text =
                              DateFormat('dd-MM-yyyy').format(tdp.toDate!);
                          fromDateController.text = result;
                        }
                      },
                    )),
                    Expanded(
                      child: CustomTextField(
                        nameController: toDateController,
                        name: "To Date",
                        readOnly: true,
                        onTap: () async {
                          final result =
                              await tdp.showCustomDatePicker(context);
                          if (result != null) {
                            toDateController.text = result;
                          }
                        },
                      ),
                    ),
                    Container(
                        width: 50,
                        height: 70,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: IconButton(
                            onPressed: () async {
                              if (fromDateController.text.isNotEmpty &&
                                  toDateController.text.isNotEmpty) {
                                noOfDays = countSelectedDates();
                                tdp.updateBalnce(100000);
                                tdp.getNifty50TradeHistoryList(context);
                              } else {
                                Utils.showSnackBar(
                                    context: context,
                                    content: "Please select Date");
                              }
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'report',
                            groupValue: tdp.reportType,
                            onChanged: (value) {
                              tdp.updateReportType(value);
                            },
                          ),
                          Text(
                            'Report',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'trend',
                            groupValue: tdp.reportType,
                            onChanged: (value) {
                              tdp.updateReportType(value);
                            },
                          ),
                          Text(
                            'Trend',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'fixmargin',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Fixed Margin',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'fixlot',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Fixed Lot',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.deepOrange,
                            value: 'cumilative',
                            groupValue: tdp.selectedRType,
                            onChanged: (value) {
                              tdp.updateSelectedRType(value);
                            },
                          ),
                          const Text(
                            'Cumilative',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (tdp.tradeHistoryModelList.isEmpty) const EmptyWidget(),
              if (tdp.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
              if (!tdp.isLoading)
                if (tdp.reportType == 'report')
                  Expanded(
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(
                            Colors.deepOrange), // Set the color you desire
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _firstController,
                        thickness: 10,
                        trackVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _firstController,
                          itemCount: tdp.tradeHistoryModelList.length,
                          itemBuilder: (context, index) {
                            return PLReportContainer(
                              tradeHistoryModel:
                                  tdp.tradeHistoryModelList[index],
                              balenceAmount: tdp
                                  .getRemainingAmount(
                                      tdp.tradeHistoryModelList, index)
                                  .toDouble(),
                            ); //PLReportContainer(tradeHistoryModel:tdp.tradeHistoryModelList[index],);
                          },
                        ),
                      ),
                    ),
                  ),
              if (!tdp.isLoading)
                if (tdp.reportType == 'trend')
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enableDoubleTapZooming: true,
                          enableMouseWheelZooming: true),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        decimalPlaces: 2,
                        canShowMarker: true,
                        builder:
                            (data, point, series, pointIndex, seriesIndex) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (data as num).isNegative
                                    ? const Color.fromARGB(255, 201, 16, 3)
                                    : Colors.green),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Date :"),
                                    Text(DateFormat("dd-MM-yyyy").format(tdp
                                        .tradeHistoryModelList[pointIndex]
                                        .buyTime!)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Points Gain :"),
                                    Text((tdp.tradeHistoryModelList[pointIndex]
                                                .pointsGain ??
                                            0)
                                        .toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("P&L :"),
                                    Text((tdp.tradeHistoryModelList[pointIndex]
                                                .profitLoss ??
                                            0)
                                        .toStringAsFixed(2)),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        header: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                      ),
                      series: [
                        StackedColumnSeries(
                          dataSource: tdp.tradeHistoryModelList
                              .map((e) => e.profitLoss)
                              .toList(),
                          pointColorMapper: (datum, index) {
                            if (tdp.tradeHistoryModelList
                                .map((e) => e.profitLoss)
                                .toList()[index]
                                .toString()
                                .contains("-")) {
                              return ColorManager.red;
                            } else {
                              return ColorManager.green;
                            }
                          },
                          dataLabelMapper: (datum, index) {
                            return datum.toString();
                          },
                          xValueMapper: (datum, index) => index + 1,
                          yValueMapper: (datum, index) => datum,
                        )
                      ],
                    ),
                  ),
              if (tdp.reportType == 'report')
                Column(
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(12)
                          // border: const Border(
                          //   top: BorderSide(color: Colors.white, width: 2),
                          // ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Total P&L : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                "${tdp.getTotalPL().toStringAsFixed(2)} ₹",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: (tdp.getTotalPL().isNegative)
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Total Points : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    tdp.getTotalPointsGain().toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: (tdp
                                                .getTotalPointsGain()
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Avg point per day : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    (tdp.getTotalPointsGain() / noOfDays)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: ((tdp.getTotalPointsGain() /
                                                    noOfDays)
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SummryContainer(
                      tradeHistoryModel: tdp.tradeHistoryModelList,
                      balenceAmount: tdp.getTotalPL().toDouble(),
                    )
                  ],
                ),
            ],
          ),
        );
      case 'EQUITY':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      nameController: fromDateController,
                      name: "From Date",
                      readOnly: true,
                      onTap: () async {
                        final result = await tdp.showCustomDatePicker(context,
                            isFirstDate: true); //isFirstDate: true
                        if (result != null) {
                          toDateController.text =
                              DateFormat('dd-MM-yyyy').format(tdp.toDate!);
                          fromDateController.text = result;
                        }
                      },
                    )),
                    Expanded(
                      child: CustomTextField(
                        nameController: toDateController,
                        name: "To Date",
                        readOnly: true,
                        onTap: () async {
                          final result =
                              await tdp.showCustomDatePicker(context);
                          if (result != null) {
                            toDateController.text = result;
                          }
                        },
                      ),
                    ),
                    Container(
                        width: 50,
                        height: 70,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: IconButton(
                            onPressed: () async {
                              if (fromDateController.text.isNotEmpty &&
                                  toDateController.text.isNotEmpty) {
                                noOfDays = countSelectedDates();
                                tdp.updateBalnce(100000);
                                tdp.getEquityTradeHistoryList(context);
                              } else {
                                Utils.showSnackBar(
                                    context: context,
                                    content: "Please select Date");
                              }
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              if (tdp.tradeHistoryModelList.isEmpty) const EmptyWidget(),
              if (tdp.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
              if (!tdp.isLoading)
                Expanded(
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(
                          Colors.deepOrange), // Set the color you desire
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _firstController,
                      thickness: 10,
                      trackVisibility: true,
                      interactive: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _firstController,
                        itemCount: tdp.tradeHistoryModelList.length,
                        itemBuilder: (context, index) {
                          return PLReportContainer(
                            tradeHistoryModel: tdp.tradeHistoryModelList[index],
                            balenceAmount: tdp
                                .getRemainingAmount(
                                    tdp.tradeHistoryModelList, index)
                                .toDouble(),
                          ); //PLReportContainer(tradeHistoryModel:tdp.tradeHistoryModelList[index],);
                        },
                      ),
                    ),
                  ),
                ),
              if (!tdp.isLoading)
                Column(
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: ColorManager.balck255,
                          borderRadius: BorderRadius.circular(12)
                          // border: const Border(
                          //   top: BorderSide(color: Colors.white, width: 2),
                          // ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Total P&L : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                "${tdp.getTotalPL().toStringAsFixed(2)} ₹",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: (tdp.getTotalPL().isNegative)
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Total Points : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    tdp.getTotalPointsGain().toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: (tdp
                                                .getTotalPointsGain()
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Avg point per day : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    (tdp.getTotalPointsGain() / noOfDays)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: ((tdp.getTotalPointsGain() /
                                                    noOfDays)
                                                .isNegative)
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SummryContainer(
                    //   tradeHistoryModel: tdp.tradeHistoryModelList,
                    //   balenceAmount: tdp.getTotalPL().toDouble(),
                    // )
                  ],
                ),
            ],
          ),
        );

      default:
        return Center(
          child: Text(
            'No Data Available',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }

  /* Widget getPostionTiles(List<KotakPositionModel> ps, String? userType) {
    final dp = Provider.of<DashboardProvider>(context);
    return userType == 'KOTAK'
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ps.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: ColorManager.balck255,
                      child: ListTile(
                        title: Text(
                          ps[index].trdSym.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(ps[index].prod ?? ''),
                        trailing: Text(
                          "${getprofitloss(ps, index)} ₹",
                          style: TextStyle(
                              fontSize: 12,
                              color: getprofitloss(ps, index).isNegative
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    );
                  },
                ),
                Card(
                  color: ColorManager.balck255,
                  child: ListTile(
                    title: const Text(
                      'P&L',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Text(
                      "${dp.getTotalProfitLoss(kotakPositionList: ps)} ₹",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: (dp.getTotalProfitLoss(kotakPositionList: ps))
                                  .isNegative
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Card(
              elevation: 5,
              color: ColorManager.balck255,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.30,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Page Under Contruction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'This page is under development phase it will be available to you soon',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  double getprofitloss(List<KotakPositionModel> positionList, int index) {
    try {
      double buyAmt = double.parse(positionList[index].buyAmt!);
      double sellAmt = double.parse(positionList[index].sellAmt!);

      double pnl = (sellAmt - buyAmt);

      return pnl;
    } catch (e) {
      return 0.0;
    }
  }
*/
}
