// ignore_for_file: unused_field, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Widgets/utils.dart';
// import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/models/UserDetailsModel.dart';
import 'package:motatool/models/is_auto_mode.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class UserDetailTile extends StatefulWidget {
  final UserDetailsModel userdata;
  const UserDetailTile({super.key, required this.userdata});

  @override
  State<UserDetailTile> createState() => _UserDetailTileState();
}

class _UserDetailTileState extends State<UserDetailTile> {
  final TextEditingController _banknifty = TextEditingController();

  final TextEditingController _nifty = TextEditingController();

  final TextEditingController _finnifty = TextEditingController();

  final TextEditingController _midcap = TextEditingController();

  final TextEditingController _equity = TextEditingController();

  final TextEditingController _message = TextEditingController();

  int _isBankNiftyOn = 0;
  int _isNiftyOn = 0;
  int _isFinNiftyOn = 0;
  int _isMidCapOn = 0;
  int _isEquityOn = 0;
  int? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.balck255, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.name ?? '',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              Row(
                children: [
                  const Text(
                    'Status : ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: (DateTime.tryParse(
                                widget.userdata.subscriptionDate ?? '')!
                            .isAfter(DateTime.now()))
                        ? Colors.green
                        : Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      dp.getIsAutoModel(widget.userdata);
                      final isAuto = dp.isAutoModel;
                      updateAllocation();
                      await showDialog(
                        context:
                            context, // Ensure that you have access to the context
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Update User Details",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Name: ${widget.userdata.name}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Broker: ${widget.userdata.broker}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            content: SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Form(
                                      key: GlobalKey(),
                                      child: Consumer<DashboardProvider>(
                                          builder: (context, dp, child) {
                                        return Table(
                                          children: [
                                            const TableRow(children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Text(
                                                  "Segments",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Text(
                                                  "% Allocation",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Text(
                                                  "Auto Trade",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ]),
                                            const TableRow(children: [
                                              Divider(),
                                              Divider(),
                                              Divider()
                                            ]),
                                            //*BankNifty
                                            TableRow(children: [
                                              const Text(
                                                "Bank Nifty",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: TextField(
                                                  controller: _banknifty,
                                                  onChanged: (val) {
                                                    widget.userdata.bANKNIFTY =
                                                        val;
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      suffix: Text('%')),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch.adaptive(
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.red,
                                                  value: dp.getTrueFalse(
                                                      _isBankNiftyOn),
                                                  onChanged: (val) {
                                                    dp.updateIsAutoModel(dp
                                                        .isAutoModel!
                                                        .copyWith(
                                                            bnIsAuto:
                                                                val ? 1 : 0));
                                                    _isBankNiftyOn =
                                                        val == true ? 1 : 0;
                                                  },
                                                ),
                                              )
                                            ]),
                                            const TableRow(children: [
                                              Divider(),
                                              Divider(),
                                              Divider()
                                            ]),
                                            //*Nifty
                                            TableRow(children: [
                                              const Text(
                                                "Nifty",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: TextField(
                                                  controller: _nifty,
                                                  onChanged: (val) {
                                                    widget.userdata.nIFTY = val;
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      suffix: Text('%')),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch.adaptive(
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.red,
                                                  value: dp
                                                      .getTrueFalse(_isNiftyOn),
                                                  onChanged: (value) {
                                                    dp.updateIsAutoModel(dp
                                                        .isAutoModel!
                                                        .copyWith(
                                                            nIsAuto:
                                                                value ? 1 : 0));
                                                    _isNiftyOn =
                                                        value == true ? 1 : 0;
                                                    // dp.updateNiftyAuto(value);
                                                  },
                                                ),
                                              )
                                            ]),
                                            const TableRow(children: [
                                              Divider(),
                                              Divider(),
                                              Divider()
                                            ]),
                                            //*FinNifty
                                            TableRow(children: [
                                              const Text(
                                                "Nifty Fin",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: TextField(
                                                  controller: _finnifty,
                                                  onChanged: (val) {
                                                    widget.userdata.nIFTYFIN =
                                                        val;
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      suffix: Text('%')),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch.adaptive(
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.red,
                                                  value: dp.getTrueFalse(
                                                      _isFinNiftyOn),
                                                  onChanged: (value) {
                                                    dp.updateIsAutoModel(dp
                                                        .isAutoModel!
                                                        .copyWith(
                                                            nfIsAuto:
                                                                value ? 1 : 0));
                                                    _isFinNiftyOn =
                                                        value == true ? 1 : 0;
                                                  },
                                                ),
                                              )
                                            ]),
                                            const TableRow(children: [
                                              Divider(),
                                              Divider(),
                                              Divider()
                                            ]),
                                            //*MidCap
                                            TableRow(children: [
                                              const Text(
                                                "Midcap",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: TextField(
                                                  controller: _midcap,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (val) {
                                                    widget.userdata.mIDCAP =
                                                        val;
                                                  },
                                                  decoration: const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      suffix: Text('%')),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch.adaptive(
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.red,
                                                  value: dp.getTrueFalse(
                                                      _isMidCapOn),
                                                  onChanged: (value) {
                                                    dp.updateIsAutoModel(dp
                                                        .isAutoModel!
                                                        .copyWith(
                                                            mcIsAuto:
                                                                value ? 1 : 0));
                                                    _isMidCapOn =
                                                        value == true ? 1 : 0;
                                                  },
                                                ),
                                              )
                                            ]),
                                            const TableRow(children: [
                                              Divider(),
                                              Divider(),
                                              Divider()
                                            ]),
                                            //*Equity
                                            TableRow(children: [
                                              const Text(
                                                "Equity",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: TextField(
                                                  controller: _equity,
                                                  onChanged: (val) {
                                                    widget.userdata.eQUITY =
                                                        val;
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      suffix: Text('%')),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch.adaptive(
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.red,
                                                  value: dp.getTrueFalse(
                                                      _isEquityOn),
                                                  onChanged: (value) {
                                                    dp.updateIsAutoModel(dp
                                                        .isAutoModel!
                                                        .copyWith(
                                                            eqIsAuto:
                                                                value ? 1 : 0));
                                                    _isEquityOn =
                                                        value == true ? 1 : 0;
                                                  },
                                                ),
                                              )
                                            ])
                                          ],
                                        );
                                      })),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await dp.submitIsAuto(context,
                                              widget.userdata, dp.isAutoModel!);
                                          await dp.getUserDetailsListnew();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        _message.text = widget.userdata.message ?? '';
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return _userMessage(
                              context,
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Colors.grey,
                      ))
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.broker ?? '',
                style: const TextStyle(color: Colors.amber),
              ),
              Row(
                children: [
                  const Text(
                    "Margin / Limit : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.margin ?? 0.0).toStringAsFixed(0)} / ${widget.userdata.investLimit}",
                    style: const TextStyle(color: Colors.cyan),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.mobileNo ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  const Text(
                    "Login Id : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.loginId}",
                    style: const TextStyle(color: Colors.cyan),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "Trade Location : ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  _selectedLocation = widget.userdata.islocal ?? 0;
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Update Trade Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name: ${widget.userdata.name}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Broker: ${widget.userdata.broker}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Text(
                                      'Trade Location: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Radio<int>(
                                          value: 1,
                                          activeColor: Colors.deepOrange,
                                          groupValue: _selectedLocation,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _selectedLocation = value!;
                                            });
                                          },
                                        ),
                                        const Text('On Local'),
                                        Radio<int>(
                                          value: 0,
                                          activeColor: Colors.deepOrange,
                                          groupValue: _selectedLocation,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _selectedLocation = value!;
                                            });
                                          },
                                        ),
                                        const Text('On Server'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Update the trade location here
                              await dp.updateIsLocal(
                                context,
                                widget.userdata.userId ?? 0,
                                _selectedLocation!,
                              );
                              await dp.getUserDetailsListnew();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Update"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  _selectedLocation == 1 ? 'On Local' : 'On Server',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Trade Location : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context:
                            context, // Ensure that you have access to the context
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Update Trade Location",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Name: ${widget.userdata.name}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Broker: ${widget.userdata.broker}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            content: SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Trade Location",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await dp.updateIsLocal(
                                              context,
                                              widget.userdata.userId ?? 0,
                                              _isLocal);
                                          await dp.getUserDetailsListnew();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      widget.userdata.islocal == 1 ? 'On Local' : 'On Server',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Subscription Date : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('dd-MMM-yyyy').format(
                        DateTime.tryParse(widget.userdata.subscriptionDate!) ??
                            DateTime.now()),
                    style: TextStyle(
                      color: (DateTime.tryParse(
                                  widget.userdata.subscriptionDate ?? '')!
                              .isAfter(DateTime.now()))
                          ? Colors.green
                          : Colors.red,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Last Login : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateTime.tryParse(widget.userdata.lastLogin ?? "") != null
                        ? (DateFormat('dd-MMM-yyyy hh:mm:ss a').format(
                            DateTime.tryParse(widget.userdata.lastLogin ?? '')!
                                .add(const Duration(hours: 5, minutes: 30))))
                        : "",
                    style: TextStyle(
                      color: DateFormat('dd-MM-yyyy').format((DateTime.tryParse(
                                      widget.userdata.lastLogin ?? '') ??
                                  DateTime.now())) ==
                              DateFormat('dd-MM-yyyy').format(DateTime.now())
                          ? Colors.green
                          : Colors.red,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'BANKNIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.bANKNIFTY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.isAuto == 1 ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: widget.userdata.isAuto == 1
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: widget.userdata.isAuto == 1,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateBankNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'NIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.nIFTY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isNiftyOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isNiftyOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.niftyauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'FINNIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.nIFTYFIN ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isFinNiftyOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isFinNiftyOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.finniftyauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateFinNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'MIDCAP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.mIDCAP ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isMidCapOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isMidCapOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.midcapauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateMidcapAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Equity',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.eQUITY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isEquityOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isEquityOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.equityauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateEquityAuto(value);
                  //   },
                  // )
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Login Device : ",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      (widget.userdata.deviceId ?? '')
                          .replaceAll('{', '')
                          .replaceAll('}', ''),
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildTextField({
  //   required TextEditingController controller,
  // }) {
  //   return SizedBox(
  //     width: 30,
  //     child: TextFormField(
  //       controller: controller,
  //       textAlign: TextAlign.center,
  //       keyboardType: TextInputType.number,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return 'Please enter a value';
  //         }
  //         return null;
  //       },
  //       decoration: const InputDecoration(suffix: Text('%')),
  //     ),
  //   );
  // }
  Widget _userMessage(BuildContext context) {
    final cp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit User Message'),
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
                                .updateUserMessage(context,
                                    widget.userdata.userId, _message.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              cp.getUserDetailsListnew();
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

  TableRow getMarginRow(IsAutoModel? isAuto,
      {String? name,
      bool? value,
      required TextEditingController? controller,
      required String? percentValue,
      required void Function(bool)? onChanged,
      required void Function(String)? onChangedTextField}) {
    return TableRow(children: [
      Text(name ?? "",
          style: const TextStyle(fontSize: 18, color: Colors.black)),
      Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          onChanged: onChangedTextField,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20))),
          controller: controller,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Switch.adaptive(
          activeColor: Colors.green,
          inactiveThumbColor: Colors.red,
          value: value ?? false,
          onChanged: onChanged,
        ),
      )
    ]);
  }

  // Widget _buildSwitch(bool value) {

  updateAllocation() {
    _banknifty.text = widget.userdata.bANKNIFTY ?? '';
    _nifty.text = widget.userdata.nIFTY ?? '';
    _finnifty.text = widget.userdata.nIFTYFIN ?? '';
    _midcap.text = widget.userdata.mIDCAP ?? '';
    _equity.text = widget.userdata.eQUITY ?? '';
    _isBankNiftyOn = widget.userdata.isAuto ?? 0;
    _isNiftyOn = widget.userdata.isNiftyOn ?? 0;
    _isFinNiftyOn = widget.userdata.isFinNiftyOn ?? 0;
    _isMidCapOn = widget.userdata.isMidCapOn ?? 0;
    _isEquityOn = widget.userdata.isEquityOn ?? 0;
  }
}
