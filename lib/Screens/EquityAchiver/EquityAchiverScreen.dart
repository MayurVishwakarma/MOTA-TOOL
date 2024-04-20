// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:motatool/Providers/DashbordProvider.dart';
import 'package:motatool/Widgets/utils.dart';
import 'package:motatool/resources/color_manager.dart';
import 'package:provider/provider.dart';

class EquityAchiverScreen extends StatefulWidget {
  const EquityAchiverScreen({super.key});

  @override
  State<EquityAchiverScreen> createState() => _EquityAchiverScreenState();
}

class _EquityAchiverScreenState extends State<EquityAchiverScreen> {
  TextEditingController symbolTextEditor = TextEditingController();
  TextEditingController companyTextEditor = TextEditingController();
  final ScrollController _firstController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    // dp.updateselectedItem(null);
    dp.getCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _insertcard(context);
                });
          },
          child: const Icon(Icons.add),
        ),
        body: ScrollbarTheme(
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
            child: SingleChildScrollView(
              controller: _firstController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Search',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (searchController.text.isNotEmpty) {
                                      dp.searchCompany(searchController.text);
                                    } else {
                                      dp.getCompanyList();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              searchController.clear();
                              dp.getCompanyList();
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  /* Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 50,
                        //   child: TextFormField(
                        //     controller: symbolTextEditor,
                        //     style: const TextStyle(color: Colors.white),
                        //     cursorColor: Colors.deepOrange,
                        //     decoration: InputDecoration(
                        //       labelText: "Id",
                        //       labelStyle: const TextStyle(color: Colors.white),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide:
                        //               const BorderSide(color: Colors.white)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide:
                        //               const BorderSide(color: Colors.white)),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: TextFormField(
                            controller: symbolTextEditor,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              labelText: "Symbol",
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                            child: _buildDropdownButton()),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: companyTextEditor,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              labelText: 'Company',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                dp.insertCompanyData(
                                    context,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepOrange),
                              child: const Text("Insert")),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                dp.updateSelectedCompanyData(
                                    context,
                                    dp.selectedCompany,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepOrange),
                              child: const Text("Edit")),
                        )
                      ],
                    ),
                  ),
                 */
                  ListView.builder(
                    itemCount: dp.allcomapny.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        color: ColorManager.balck255,
                        child: SizedBox(
                          // height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "${dp.allcomapny[index].symbol}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                  "${dp.allcomapny[index].exchange ?? '-'}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                "${dp.allcomapny[index].companyName ?? '-'}",
                                style: const TextStyle(color: Colors.white),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      symbolTextEditor.text =
                                          dp.allcomapny[index].symbol ?? '';
                                      companyTextEditor.text =
                                          dp.allcomapny[index].companyName ??
                                              '';
                                      dp.updateselectedItem(
                                          dp.allcomapny[index].exchange);
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _editcard(context, index);
                                          });
                                      // dp.deleteSelectedCompanyData(
                                      //     context,
                                      //     dp.allcomapny[index].symbol,
                                      //     dp.allcomapny[index].exchange);
                                    },
                                    icon: const Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  /*ListView.builder(
                    itemCount: dp.allcomapny.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          dp.updateSelectedCompany(
                              dp.allcomapny[index].id ?? 0);
                          symbolTextEditor.text =
                              dp.allcomapny[index].symbol ?? '';
                          dp.updateselectedItem(dp.allcomapny[index].exchange);
                          companyTextEditor.text =
                              dp.allcomapny[index].companyName ?? '';
                        },
                        child: Card(
                          color: dp.selectedCompany == dp.allcomapny[index].id
                              ? Colors.orange
                              : ColorManager.balck255,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.16,
                                    child: Center(
                                      child: Text(
                                        "${dp.allcomapny[index].symbol}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.115,
                                    child: Center(
                                      child: Text(
                                        "${dp.allcomapny[index].exchange}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Center(
                                  child: Text(
                                    "${dp.allcomapny[index].companyName}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (dp.selectedCompany ==
                                    dp.allcomapny[index].id)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          dp.deleteSelectedCompanyData(
                                              context,
                                              dp.allcomapny[index].symbol,
                                              dp.allcomapny[index].exchange);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                */
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildDropdownButton() {
    final dp = Provider.of<DashboardProvider>(context);
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
            'Exchange',
            style: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black),
          value: dp.selectedExchange,
          onChanged: (newValue) {
            dp.updateselectedItem(newValue.toString());
          },
          items: dp.dropdownItems.map((key) {
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

  Widget _editcard(BuildContext context, int index) {
    final dp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit Compnay Data'),
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
                      child: TextFormField(
                        controller: symbolTextEditor,
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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: companyTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (symbolTextEditor.text.isNotEmpty &&
                companyTextEditor.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Update'),
                    content: Text("Are you sure"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .updateSelectedCompanyData(
                                    context,
                                    dp.allcomapny[index].id,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getCompanyList();
                              symbolTextEditor.clear();
                              companyTextEditor.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Sure')),
                      TextButton(
                          onPressed: () {
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'))
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
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete'),
                  content: Text("Are you sure you want to delete this record."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          dp
                              .deleteSelectedCompanyData(
                            context,
                            symbolTextEditor.text,
                            dp.selectedExchange,
                          )
                              ?.then((value) async {
                            await Utils.showSnackBar(
                                content: "Record Deleted successfully!",
                                context: context,
                                color: Colors.green);
                            await dp.getCompanyList();
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Sure')),
                    TextButton(
                        onPressed: () {
                          symbolTextEditor.clear();
                          companyTextEditor.clear();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'))
                  ],
                );
              },
            );
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            symbolTextEditor.clear();
            companyTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _insertcard(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Insert Compnay Data'),
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
                      child: TextFormField(
                        controller: symbolTextEditor,
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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: companyTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (symbolTextEditor.text.isNotEmpty &&
                companyTextEditor.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Insert'),
                    content: Text(
                        'Are you sure you want to insert this record in the list.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .insertCompanyData(
                                    context,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "Inserted successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getCompanyList();
                              symbolTextEditor.clear();
                              companyTextEditor.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Sure')),
                      TextButton(
                          onPressed: () {
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'))
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
            symbolTextEditor.clear();
            companyTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
