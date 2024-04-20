// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Providers/TradeBookProvider.dart';
import 'package:motatool/models/trade_history_model.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class SummryContainer extends StatefulWidget {
  final List<TradeHistoryModel> tradeHistoryModel;
  final double? balenceAmount;

  const SummryContainer(
      {required this.tradeHistoryModel, this.balenceAmount, super.key});

  @override
  State<SummryContainer> createState() => _SummryContainerState();
}

class _SummryContainerState extends State<SummryContainer> {
  @override
  Widget build(BuildContext context) {
    final tdp = Provider.of<TradeBookProvider>(context);
    // final dp = Provider.of<DashboardProvider>(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: ColorManager.balck255,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1)
              },
              children: [
                TableRow(children: [
                  const Text(
                    "No of Trades",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${widget.tradeHistoryModel.length}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    "Win Rate",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${tdp.getWinRate(widget.tradeHistoryModel.length, tdp.getpositiveTradeCount(widget.tradeHistoryModel).toInt()).toStringAsFixed(2)} %",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
                TableRow(children: [
                  const Text(
                    "+ Trades",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${tdp.getpositiveTradeCount(widget.tradeHistoryModel)}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    "% Points Gain",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${(tdp.getpercentpointgain(widget.tradeHistoryModel) ?? 0.0).toStringAsFixed(2)} %",
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
                TableRow(children: [
                  const Text(
                    "- Trades",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${tdp.getnegetiveTreadcount(widget.tradeHistoryModel)}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    "ROI",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${tdp.getroipercentage((widget.balenceAmount ?? 0.0), 100000).toStringAsFixed(2)} %",
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
