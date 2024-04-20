// ignore_for_file: file_names, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:motatool/Providers/ConfigurationProvider.dart';
import 'package:motatool/Widgets/custom_textfield.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/models/LotSizemasterModel.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  TextEditingController expirydateTextEditor = TextEditingController();
  TextEditingController lotSizeTextEditor = TextEditingController();
  TextEditingController maxQtyTextEditor = TextEditingController();
  TextEditingController holidayTextEditor = TextEditingController();
  TextEditingController dateTextEditor = TextEditingController();
  @override
  void initState() {
    final cpr = Provider.of<ConfigurationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cpr.getExpiryList("BANKNIFTY");
      cpr.getLotSizeData('BANKNIFTY');
      cpr.getHiolidayList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ConfigurationProvider>(context);
    return Scaffold(
        floatingActionButton: cp.selectedConfig == 'EXPIRY'
            ? FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _insertcard(context);
                      });
                },
                child: const Icon(Icons.add),
              )
            : null,
        body: Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //holiday expiry lot size
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
                                          cp.updateSelectedConfig('HOLIDAY');
                                          cp.getHiolidayList();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: cp.selectedConfig ==
                                                      'HOLIDAY'
                                                  ? Colors.deepOrange
                                                  : null,
                                              border:
                                                  cp.selectedConfig != 'HOLIDAY'
                                                      ? Border.all(
                                                          color: Colors.white)
                                                      : null,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'HOLIDAY',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cp.updateSelectedConfig('EXPIRY');
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color:
                                                  cp.selectedConfig == 'EXPIRY'
                                                      ? Colors.deepOrange
                                                      : null,
                                              border:
                                                  cp.selectedConfig != 'EXPIRY'
                                                      ? Border.all(
                                                          color: Colors.white)
                                                      : null,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'EXPIRY',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cp.updateSelectedConfig('LOT-SIZE');
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: cp.selectedConfig ==
                                                      'LOT-SIZE'
                                                  ? Colors.deepOrange
                                                  : null,
                                              border: cp.selectedConfig !=
                                                      'LOT-SIZE'
                                                  ? Border.all(
                                                      color: Colors.white)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'LOT-SIZE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (cp.selectedConfig == 'EXPIRY')
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
                                            cp.updateSelectedSecrionType(
                                                'BANKNIFTY');
                                            cp.getExpiryList(
                                                cp.selectedSection ??
                                                    'BANKNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'BANKNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'BANKNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'BANKNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'NIFTY');
                                            cp.getExpiryList(
                                                cp.selectedSection ?? 'NIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'NIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'NIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'NIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'FINNIFTY');
                                            cp.getExpiryList(
                                                cp.selectedSection ??
                                                    'FINNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'FINNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'FINNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'FINNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'MIDCPNIFTY');
                                            cp.getExpiryList(
                                                cp.selectedSection ??
                                                    'MIDCPNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'MIDCPNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'MIDCPNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'MIDCPNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'STOCK');
                                            cp.getExpiryList(
                                                cp.selectedSection ?? 'STOCK');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'STOCK'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'STOCK'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'STOCK OPTIONS',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'EQUITY');
                                            cp.getExpiryList(
                                                cp.selectedSection ?? 'EQUITY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'EQUITY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'EQUITY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'EQUITY',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                      if (cp.selectedConfig == 'LOT-SIZE')
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
                                            cp.updateSelectedSecrionType(
                                                'BANKNIFTY');
                                            cp.getLotSizeData(
                                                cp.selectedSection ??
                                                    'BANKNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'BANKNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'BANKNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'BANKNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'NIFTY');
                                            cp.getLotSizeData(
                                                cp.selectedSection ?? 'NIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'NIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'NIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'NIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'FINNIFTY');
                                            cp.getLotSizeData(
                                                cp.selectedSection ??
                                                    'FINNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'FINNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'FINNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'FINNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'MIDCPNIFTY');
                                            cp.getLotSizeData(
                                                cp.selectedSection ??
                                                    'MIDCPNIFTY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'MIDCPNIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'MIDCPNIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'MIDCPNIFTY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'STOCK');
                                            cp.getLotSizeData(
                                                cp.selectedSection ?? 'STOCK');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'STOCK'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'STOCK'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'STOCK OPTIONS',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cp.updateSelectedSecrionType(
                                                'EQUITY');
                                            cp.getLotSizeData(
                                                cp.selectedSection ?? 'EQUITY');
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: cp.selectedSection ==
                                                        'EQUITY'
                                                    ? Colors.deepOrange
                                                    : null,
                                                border: cp.selectedSection !=
                                                        'EQUITY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'EQUITY',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                      if (cp.selectedConfig == 'HOLIDAY')
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 40,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepOrange)),
                              child: const Text("ADD HOLIDAY"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _insertholidaycard(context);
                                    });
                              },
                            ),
                          ),
                        ),
                      if (cp.selectedConfig == 'HOLIDAY') getHolidayWidget(),

                      /*Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cp.holidays!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                tileColor: ColorManager.balck255,
                                title: const Text(
                                  "Name Of Holiday",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text(
                                  'Date: 13-4-2024',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert)),
                              );
                            },
                          ),
                        ),
                      */
                      if (cp.selectedConfig == 'EXPIRY')
                        getExpiryWidget(cp.selectedSection!),
                      if (cp.selectedConfig == 'LOT-SIZE')
                        getLotSizeWidget(cp.selectedSection!)
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget getHolidayWidget() {
    final cp = Provider.of<ConfigurationProvider>(context, listen: false);
    return Expanded(
        child: Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cp.holidays?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: ColorManager.balck255,
              title: Text(
                DateFormat('EEE , dd-MMM-yyyy')
                    .format(cp.holidays?[index].date ?? DateTime.now()),
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(cp.holidays?[index].description ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete'),
                              content: const Text(
                                  "Are you sure you want to delete this record."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      cp
                                          .deleteSelectedHoliday(
                                              context, cp.holidays?[index].id!)
                                          ?.then((value) async {
                                        await Utils.showSnackBar(
                                            content:
                                                "Record Deleted successfully!",
                                            context: context,
                                            color: Colors.green);
                                        await cp.getHiolidayList();
                                        holidayTextEditor.clear();
                                        dateTextEditor.clear();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text('Sure')),
                                TextButton(
                                    onPressed: () {
                                      expirydateTextEditor.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _holidayeditcard(context, index);
                            });
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  Widget getLotSizeWidget(String instrument) {
    final cp = Provider.of<ConfigurationProvider>(context, listen: false);
    switch (instrument) {
      case 'BANKNIFTY':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "Lot-Size: ${cp.lotSizeData?.qty} | MAX Qty : ${cp.lotSizeData?.maxQty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(cp.lotSizeData?.instrument ?? ''),
            trailing: IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _loteditcard(context, cp.lotSizeData);
                    });
              },
            ),
          ),
        );
      case 'NIFTY':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "Lot-Size: ${cp.lotSizeData?.qty} | MAX Qty : ${cp.lotSizeData?.maxQty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(cp.lotSizeData?.instrument ?? ''),
            trailing: IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _loteditcard(context, cp.lotSizeData);
                    });
              },
            ),
          ),
        );
      /*      case 'FINNIFTY':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "${cp.lotSizeData?.instrument} Lot Size:${cp.lotSizeData?.qty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text("Max Qty: ${cp.lotSizeData?.maxQty}"),
          ),
        );
      case 'MIDCPNIFTY':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "${cp.lotSizeData?.instrument} Lot Size:${cp.lotSizeData?.qty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text("Max Qty: ${cp.lotSizeData?.maxQty}"),
          ),
        );
      case 'STOCK':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "${cp.lotSizeData?.instrument} Lot Size:${cp.lotSizeData?.qty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text("Max Qty: ${cp.lotSizeData?.maxQty}"),
          ),
        );
      case 'EQUITY':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: ColorManager.balck255,
            title: Text(
              "${cp.lotSizeData?.instrument} Lot Size:${cp.lotSizeData?.qty}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text("Max Qty: ${cp.lotSizeData?.maxQty}"),
          ),
        );
*/
      default:
        return Expanded(
          child: Container(
            child: const Center(
              child: Text(
                "No Data Available",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }

  Widget getExpiryWidget(String instrument) {
    final cp = Provider.of<ConfigurationProvider>(context, listen: false);
    switch (instrument) {
      case 'BANKNIFTY':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case 'NIFTY':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case 'FINNIFTY':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case 'MIDCPNIFTY':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      /*     case 'STOCK':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case 'EQUITY':
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cp.expirydates?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: ColorManager.balck255,
                    title: Text(
                      DateFormat("EEE dd-MMM-yyyy").format(
                          DateTime.tryParse(cp.expirydates?[index].date ?? '')!
                              .add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(cp.expirydates?[index].instrument ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        "Are you sure you want to delete this record."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cp
                                                .deleteSelectedExpiryData(
                                                    context,
                                                    cp.expirydates?[index].id)
                                                ?.then((value) async {
                                              await Utils.showSnackBar(
                                                  content:
                                                      "Record Deleted successfully!",
                                                  context: context,
                                                  color: Colors.green);
                                              await cp.getExpiryList(
                                                  cp.selectedSection ??
                                                      'BANKNIFTY');
                                              expirydateTextEditor.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Sure')),
                                      TextButton(
                                          onPressed: () {
                                            expirydateTextEditor.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _editcard(context, index);
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
*/
      default:
        return Expanded(
          child: Container(
            child: const Center(
              child: Text(
                "No Data Available",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }

  Widget _editcard(BuildContext context, int index) {
    final cp = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit Expiry Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameController: expirydateTextEditor,
                        name: "Expiry Date",
                        textColor: Colors.black,
                        readOnly: true,
                        onTap: () async {
                          final result = await dp.showCustomDatePicker(context);
                          if (result != null) {
                            expirydateTextEditor.text = result;
                          }
                        },
                      ),
                    )
                    /*Expanded(
                      child: TextFormField(
                        controller: expirydateTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Expiry Date",
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
                    )
                  */
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
            if (expirydateTextEditor.text.isNotEmpty) {
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
                                .updateSelectedExpiryData(
                                    context,
                                    cp.expirydates?[index].id,
                                    expirydateTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              await cp.getExpiryList(cp.selectedSection!);
                              expirydateTextEditor.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            expirydateTextEditor.clear();

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            } else {
              print('NO CompanyName');
            }
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            expirydateTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _holidayeditcard(BuildContext context, int index) {
    final cp = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit Holiday Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: holidayTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Holiday",
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
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameController: dateTextEditor,
                        name: "Date",
                        textColor: Colors.black,
                        readOnly: true,
                        onTap: () async {
                          final result = await dp.showCustomDatePicker(context);
                          if (result != null) {
                            dateTextEditor.text = result;
                          }
                        },
                      ),
                    )
                    /*Expanded(
                      child: TextFormField(
                        controller: expirydateTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Expiry Date",
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
                    )
                  */
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
            if (holidayTextEditor.text.isNotEmpty) {
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
                                .updateSelectedHolidayData(
                                    context,
                                    cp.holidays?[index].id,
                                    dateTextEditor.text,
                                    holidayTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              await cp.getHiolidayList();
                              dateTextEditor.clear();
                              holidayTextEditor.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            dateTextEditor.clear();
                            holidayTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            } else {
              // print('NO CompanyName');
            }
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            dateTextEditor.clear();
            holidayTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _loteditcard(BuildContext context, LotSizeMasterModel? lot) {
    final cp = Provider.of<ConfigurationProvider>(context);
    lotSizeTextEditor.text = cp.lotSizeData!.qty.toString();
    maxQtyTextEditor.text = cp.lotSizeData!.maxQty.toString();
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit Lot-Size'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lot?.instrument ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: lotSizeTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Lot-Size",
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: maxQtyTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Max-Qty",
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
            if (lotSizeTextEditor.text.isNotEmpty &&
                maxQtyTextEditor.text.isNotEmpty) {
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
                                .updateSelectedLotSizeData(
                                    context,
                                    cp.lotSizeData?.id,
                                    int.tryParse(lotSizeTextEditor.text),
                                    int.tryParse(maxQtyTextEditor.text))
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              await cp.getLotSizeData(cp.selectedSection!);
                              lotSizeTextEditor.clear();
                              maxQtyTextEditor.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            expirydateTextEditor.clear();

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            } else {
              // print('NO CompanyName');
            }
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            lotSizeTextEditor.clear();
            maxQtyTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _buildDropdownButton() {
    final dp = Provider.of<ConfigurationProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(3.5),
        child: DropdownButton(
          dropdownColor: ColorManager.whiteA700,
          isExpanded: true,
          underline: const Divider(color: Colors.transparent),
          hint: const Text(
            'Instrument',
            style: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black),
          value: dp.selectedInstrument,
          onChanged: (newValue) {
            dp.updateSelectedInstrument(newValue.toString());
          },
          items: [
            'BANKNIFTY',
            'NIFTY',
            'FINNIFTY',
            'MIDCPNIFTY',
            'STOCK',
            'EQUITY'
          ].map((key) {
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
    );
  }

  Widget _insertcard(BuildContext context) {
    final dp = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Insert Compnay Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameController: expirydateTextEditor,
                        name: "Expiry Date",
                        textColor: Colors.black,
                        readOnly: true,
                        onTap: () async {
                          final result = await dp.showCustomDatePicker(context);
                          if (result != null) {
                            expirydateTextEditor.text = result;
                          }
                        },
                      ), /*TextFormField(
                        controller: expirydateTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Symbol",
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
                      ),*/
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
            if (expirydateTextEditor.text.isNotEmpty &&
                dp.selectedInstrument != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Insert'),
                    content: const Text(
                        'Are you sure you want to insert this record in the list.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .insertExpityData(
                                    context,
                                    dp.selectedInstrument,
                                    expirydateTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "Inserted successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getExpiryList(
                                  dp.selectedSection ?? 'BANKNIFTY');
                              expirydateTextEditor.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            expirydateTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Insert"),
        ),
        TextButton(
          onPressed: () {
            expirydateTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _insertholidaycard(BuildContext context) {
    final dp = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Insert Holiday Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: holidayTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Holiday",
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
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameController: dateTextEditor,
                        name: "Date",
                        textColor: Colors.black,
                        readOnly: true,
                        onTap: () async {
                          final result = await dp.showCustomDatePicker(context);
                          if (result != null) {
                            dateTextEditor.text = result;
                          }
                        },
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
            if (dateTextEditor.text.isNotEmpty &&
                holidayTextEditor.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Insert'),
                    content: const Text(
                        'Are you sure you want to insert this record in the list.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .insertHolidayData(context, dateTextEditor.text,
                                    holidayTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "Inserted successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getHiolidayList();
                              dateTextEditor.clear();
                              holidayTextEditor.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            dateTextEditor.clear();
                            holidayTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Insert"),
        ),
        TextButton(
          onPressed: () {
            dateTextEditor.clear();
            holidayTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _insertlotcard(BuildContext context) {
    final dp = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Insert Compnay Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<ConfigurationProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameController: expirydateTextEditor,
                        name: "Expiry Date",
                        textColor: Colors.black,
                        readOnly: true,
                        onTap: () async {
                          final result = await dp.showCustomDatePicker(context);
                          if (result != null) {
                            expirydateTextEditor.text = result;
                          }
                        },
                      ), /*TextFormField(
                        controller: expirydateTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Symbol",
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
                      ),*/
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
            if (expirydateTextEditor.text.isNotEmpty &&
                dp.selectedInstrument != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Insert'),
                    content: const Text(
                        'Are you sure you want to insert this record in the list.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .insertExpityData(
                                    context,
                                    dp.selectedInstrument,
                                    expirydateTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "Inserted successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getExpiryList(
                                  dp.selectedSection ?? 'BANKNIFTY');
                              expirydateTextEditor.clear();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Sure')),
                      TextButton(
                          onPressed: () {
                            expirydateTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Insert"),
        ),
        TextButton(
          onPressed: () {
            expirydateTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
