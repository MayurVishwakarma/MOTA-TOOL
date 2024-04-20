// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "assets/images/USPLLOGO.png",
                            height: 70,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              "USPL TOOL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                  letterSpacing: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  CustomButton(
                    title: "USER REPORT",
                    colors: dp.pageIndex == 0
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(0);
                    },
                  ),
                  CustomButton(
                    title: "Daily Login report".toUpperCase(),
                    colors: dp.pageIndex == 1
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(1);
                    },
                  ),
                  // if (dp.userDetails?.userType != 'DEMO')
                  CustomButton(
                    title: "Trade report".toUpperCase(),
                    colors: dp.pageIndex == 2
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(2);
                    },
                  ),
                  // if (dp.userDetails?.userType == 'DEMO')
                  CustomButton(
                    title: "LTP Tracker".toUpperCase(),
                    // colors: ColorManager.balck255,
                    colors: dp.pageIndex == 3
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(3);
                    },
                  ),
                  CustomButton(
                    title: "User Log File".toUpperCase(),
                    // colors: ColorManager.balck255,
                    colors: dp.pageIndex == 4
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(4);
                    },
                  ),
                  CustomButton(
                    title: "Mail Section".toUpperCase(),
                    // colors: ColorManager.balck255,
                    colors: dp.pageIndex == 5
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(5);
                    },
                  ),
                  CustomButton(
                    title: "Equity Achiver".toUpperCase(),
                    // colors: ColorManager.balck255,
                    colors: dp.pageIndex == 6
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(6);
                    },
                  ),
                  CustomButton(
                    title: "Configuration".toUpperCase(),
                    // colors: ColorManager.balck255,
                    colors: dp.pageIndex == 7
                        ? Colors.orange
                        : ColorManager.balck255,
                    onPressed: () {
                      dp.updatePageIndex(7);
                    },
                  ),
                ],
              ),
              const Column(
                children: [
                  /*Container(
                      padding: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor: _connectionStatus == 'connected'
                                ? Colors.green
                                : Colors.red),
                        child: Text(
                          _connectionStatus == 'connected'
                              ? "Connected"
                              : "Disconnected",
                        ),
                      )),
                 */
                  Text(
                    "version 1.5.0",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? colors;
  final void Function()? onPressed;
  const CustomButton({super.key, this.title, this.colors, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: colors,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        onPressed: onPressed,
        child: FittedBox(child: Text(title ?? "")),
      ),
    );
  }
}
