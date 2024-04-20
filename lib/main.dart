import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motatool/Providers/ConfigurationProvider.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Providers/TradeBookProvider.dart';
import 'package:motatool/Providers/mail_provider.dart';
import 'package:motatool/Providers/trade_provider.dart';
import 'package:motatool/Screens/DashboardManager.dart';
import 'package:motatool/resources/theme_manager.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MyApp());
  // WindowManager.instance.minimize();
  // WindowManager.instance.setMinimumSize(const Size(950, 0));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => TradeProvider()),
        ChangeNotifierProvider(create: (context) => TradeBookProvider()),
        ChangeNotifierProvider(create: (context) => MyMailProvider()),
        ChangeNotifierProvider(create: (context) => ConfigurationProvider())
      ],
      child: MaterialApp(
        title: 'MOTA-TOOL',
        debugShowCheckedModeBanner: false,
        theme: ThemeManager().lightThemeData.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        home: const DashboardManager(),
      ),
    );
  }
}
