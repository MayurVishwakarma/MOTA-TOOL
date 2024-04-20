import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Widgets/custom_row.dart';
import 'package:motatool/models/trade_history_model.dart';
import 'package:motatool/resources/color_manager.dart';
// import 'package:provider/provider.dart';

class PLReportContainer extends StatefulWidget {
  final TradeHistoryModel tradeHistoryModel;
  final double? balenceAmount;
  const PLReportContainer(
      {required this.tradeHistoryModel, this.balenceAmount, super.key});

  @override
  State<PLReportContainer> createState() => _PLReportContainerState();
}

class _PLReportContainerState extends State<PLReportContainer> {
  bool isExapned = false;
  @override
  Widget build(BuildContext context) {
    final plModel = widget.tradeHistoryModel;
    // final dp = Provider.of<DashboardProvider>(context);

    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: ColorManager.balck255,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleRow(
            children: [
              Text(
                plModel.instrument ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              Expanded(child: Container()),
              const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                plModel.qty.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SimpleRow(
            children: [
              Text(
                (plModel.buyTime != null)
                    ? DateFormat("dd MMM,yyy HH:mm").format(plModel.buyTime!
                        .add(const Duration(hours: 5, minutes: 30)))
                    : "",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "₹ ${(plModel.buyPrice ?? 0).toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                (plModel.buyValue ?? 0).toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "BUY",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SimpleRow(
            children: [
              Text(
                (plModel.sellTime != null)
                    ? DateFormat("dd MMM,yyy HH:mm").format(plModel.sellTime!
                        .add(const Duration(hours: 5, minutes: 30)))
                    : "",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "₹ ${(plModel.sellPrice ?? 0).toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                (plModel.sellValue ?? 0).toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "SELL",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SimpleRow(
            children: [
              const Text(
                "Points Gain",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text((plModel.pointsGain ?? 0).toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((plModel.pointsGain ?? 0).isNegative)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
          SimpleRow(
            children: [
              const Text(
                "Gross P&L",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text("₹ ${(plModel.profitLoss ?? 0).toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((plModel.profitLoss ?? 0).isNegative)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
          // if (widget.balenceAmount != null)
          SimpleRow(
            children: [
              const Text(
                "Balance Amount",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text("₹ ${widget.balenceAmount?.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((widget.balenceAmount ?? 0) < 100000)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
        ],
      ),
    );
  }
}
