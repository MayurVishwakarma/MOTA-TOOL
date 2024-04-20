import 'package:flutter/material.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Screens/Configuration/Configuration.dart';
import 'package:motatool/Screens/DailyLoginReport.dart';
import 'package:motatool/Screens/EquityAchiver/EquityAchiverScreen.dart';
import 'package:motatool/Screens/Mail/dashboard.dart';
import 'package:motatool/Screens/MyDrawer.dart';
import 'package:motatool/Screens/PriceTrackerScreen.dart';
import 'package:motatool/Screens/TradeReport.dart';
import 'package:motatool/Screens/UserLogFileScreen.dart';
import 'package:motatool/Screens/UserReportScreen.dart';
import 'package:provider/provider.dart';

class DashboardManager extends StatefulWidget {
  const DashboardManager({super.key});

  @override
  State<DashboardManager> createState() => _DashboardManagerState();
}

class _DashboardManagerState extends State<DashboardManager> {
  final _widgets = [
    const UserReportScren(),
    const DailyLoginReportScreen(),
    const TradeReportScreen(),
    const PriceTrackerScreen(),
    const UserLogFile(),
    const MailSection(),
    const EquityAchiverScreen(),
    const ConfigurationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
      body: Row(
        children: [const Mydrawer(), Expanded(child: _widgets[dp.pageIndex])],
      ),
    );
  }
}
