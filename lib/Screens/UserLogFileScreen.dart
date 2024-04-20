// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class UserLogFile extends StatefulWidget {
  const UserLogFile({super.key});

  @override
  State<UserLogFile> createState() => _UserLogFileState();
}

class _UserLogFileState extends State<UserLogFile> {
  @override
  void initState() {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dp.updateLogText(null);
    });
    super.initState();
  }

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? pdfString;

  // var selectedUser;
  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
        body: Column(
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
                            dp.updateSelectedSecrionType('BANKNIFTY');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'BANKNIFTY'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'BANKNIFTY'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'BANKNIFTY',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dp.updateSelectedSecrionType('NIFTY');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'NIFTY'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'NIFTY'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'NIFTY',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dp.updateSelectedSecrionType('NIFTY-FIN');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'NIFTY-FIN'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'NIFTY-FIN'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'NIFTY-FIN',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dp.updateSelectedSecrionType('MID-CAP');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'MID-CAP'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'MID-CAP'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'MID-CAP',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dp.updateSelectedSecrionType('STOCK');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'STOCK'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'STOCK'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'STOCK OPTIONS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dp.updateSelectedSecrionType('EQUITY');
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: dp.selectedSection == 'EQUITY'
                                    ? Colors.deepOrange
                                    : null,
                                border: dp.selectedSection != 'EQUITY'
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'EQUITY',
                                style: TextStyle(color: Colors.white),
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  dropdownColor: ColorManager.balck255,
                  value: dp.selectLoguser, // Maintain selected user value
                  style: const TextStyle(color: Colors.white),

                  onChanged: (newValue) {
                    dp.updateSelectedLoguser(newValue ?? '');
                  },
                  items: dp.backupList?.map((user) {
                    return DropdownMenuItem<String>(
                      value: user.loginId,
                      child: FittedBox(
                        child: Text(
                          "${user.name}\n (${user.loginId})",
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Select User', // Update label text
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
              _buildDateTimePicker(
                labelText: 'Select Date',
                controller: _dateController,
                onTap: () {
                  dp.selectDateNow(context).whenComplete(() {
                    if (dp.selectedDate != null) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(dp.selectedDate!);
                    }
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 55,
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      final selectdate =
                          DateFormat("yyyy-MM-dd").format(dp.selectedDate!);
                      dp.updateFileName("${dp.userName}_$selectdate");
                      dp.getUserLogFileString(context).whenComplete(
                          () => dp.updateLogText(dp.pdfString ?? ''));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Text("GET")),
              ),
              const SizedBox(
                width: 10,
              ),
              if (dp.logText!.isNotEmpty &&
                  !dp.logText!.contains('No Data Found'))
                SizedBox(
                  height: 55,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        dp
                            .writeJsonToFile(dp.logText ?? '')
                            .then((value) async {
                          if (value) {
                            await Utils.showSnackBar(
                                content: "Download successfully!",
                                context: context,
                                color: Colors.green);
                          } else {
                            await Utils.showSnackBar(
                                content: "Download failed!",
                                context: context,
                                color: Colors.red);
                          }
                        });
                        // final selectdate =
                        //     DateFormat("yyyy-MM-dd").format(dp.selectedDate!);
                        // dp.updateFileName("${dp.userName}_$selectdate");
                        // dp.getUserLogFileString(context).whenComplete(
                        //     () => dp.updateLogText(dp.pdfString ?? ''));
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: FittedBox(child: const Text("Download"))),
                )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (dp.pdfString != null)
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  dp.logText ?? "",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          )
      ],
    ));
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
}
