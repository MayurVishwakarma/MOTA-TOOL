import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/trade_provider.dart';
import 'package:motatool/Widgets/custom_row.dart';
import 'package:motatool/models/TradeDataModel.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class TreadDetailTile extends StatefulWidget {
  final TradeDataModel tradeData;
  final int id;
  TreadDetailTile({super.key, required this.tradeData, required this.id});

  @override
  State<TreadDetailTile> createState() => _TreadDetailTileState();
}

class _TreadDetailTileState extends State<TreadDetailTile> {
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<TradeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.balck255, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SimpleRow(
            children: [
              Text(
                "Tread No: ${widget.id + 1}",
                style: TextStyle(color: Colors.white),
              ),
              CircleAvatar(
                backgroundColor: tp.selectedTreadid == (widget.id)
                    ? Colors.amber
                    : Colors.transparent,
                radius: 10,
              )
            ],
          ),
          SimpleRow(
            children: [
              Text(
                DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(widget.tradeData.entryTime ?? '')),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                widget.tradeData.instrument ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              // Expanded(child: Container()),
              // const CircleAvatar(
              //   radius: 5,
              //   backgroundColor: Colors.green,
              // ),
              // const SizedBox(
              //   width: 5,
              // ),
            ],
          ),
          SimpleRow(
            children: [
              const Text(
                "BUY",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat("HH:mm:ss").format(
                    DateTime.parse(widget.tradeData.entryTime ?? '')
                        .add(const Duration(hours: 5, minutes: 30))),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "₹ ${(widget.tradeData.entryPrice ?? 0).toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          if (widget.tradeData.exitTime != null)
            SimpleRow(
              children: [
                const Text(
                  "SELL",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
                Text(
                  DateFormat("HH:mm:ss").format(
                      DateTime.parse(widget.tradeData.exitTime ?? '')
                          .add(const Duration(hours: 5, minutes: 30))),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "₹ ${(widget.tradeData.exitPrice ?? 0).toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          if (widget.tradeData.exitTime == null)
            SimpleRow(
              children: [
                const Text(
                  "SELL",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Ongoing",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "₹ ${(widget.tradeData.exitPrice ?? 0).toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          SimpleRow(
            children: [
              const Text(
                "Points Gain",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text((widget.tradeData.pointsGain ?? 0).toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((widget.tradeData.pointsGain ?? 0).isNegative)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
          // SimpleRow(
          //   children: [
          //     const Text(
          //       "Gross P&L",
          //       style:
          //           TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          //     ),
          //     Text("₹ ${(plModel.profitLoss ?? 0).toStringAsFixed(2)}",
          //         style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             color: ((plModel.profitLoss ?? 0).isNegative)
          //                 ? Colors.red
          //                 : Colors.green))
          //   ],
          // ),
        ],
      ),
    );
  }
}
