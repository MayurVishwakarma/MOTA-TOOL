// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:motatool/Providers/mail_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final formKey = GlobalKey<FormState>();

  final keySimpleChipsInput = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final TextFormFieldStyle style = const TextFormFieldStyle(
    keyboardType: TextInputType.phone,
    cursorColor: Colors.deepOrange,
    decoration: InputDecoration(
      labelText: "To",
      labelStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.all(0.0),
      border: InputBorder.none,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MyMailProvider>(
          builder: (context, hp, child) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SimpleChipsInput(
                                  controller: hp.toController,
                                  separatorCharacter: ",",
                                  focusNode: focusNode,
                                  // chipTextStyle :TextStyle(color: Colors.white),
                                  validateInput: true,
                                  formKey: keySimpleChipsInput,

                                  textFormFieldStyle: style,
                                  validateInputMethod: (String value) {
                                    final emailRegExp = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegExp.hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSubmitted: (p0) {
                                    hp.updateOutput(p0);
                                  },
                                  onChipDeleted: (p0, p1) {
                                    hp.updateDeletedChip(p0);
                                    hp.updateDeletedChipIndex(p1.toString());
                                  },
                                  onSaved: ((p0) {
                                    hp.updateOutput(p0);
                                  }),
                                  chipTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  deleteIcon: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Colors.black,
                                  ),
                                  widgetContainerDecoration: BoxDecoration(
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  chipContainerDecoration: BoxDecoration(
                                    color: Colors.white24,
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  placeChipsSectionAbove: true,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  controller: hp.subjectController,
                                  style: const TextStyle(color: Colors.white),
                                  focusNode: hp.fromFocusNode,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(hp.contentFocusNode);
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Subject",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                InputDecorator(
                                  decoration: InputDecoration(
                                      // isDense: true,
                                      isCollapsed: true,
                                      labelText: "Content Type",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: RadioListTile<ContentType>(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          title: Text(
                                            ContentType.Normal.name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          value: ContentType.Normal,
                                          groupValue: hp.contentType,
                                          activeColor: Colors.deepOrange,
                                          onChanged: (value) {
                                            hp.updateContentType(value);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          title: Text(ContentType.HTML.name,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          value: ContentType.HTML,
                                          activeColor: Colors.deepOrange,
                                          groupValue: hp.contentType,
                                          onChanged: (value) {
                                            hp.updateContentType(value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  maxLines: 8,
                                  focusNode: hp.contentFocusNode,
                                  controller: hp.contentController,
                                  style: const TextStyle(color: Colors.white),
                                  onFieldSubmitted: (value) {
                                    // FocusScope.of(context).requestFocus(FocusNode());
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Content",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  readOnly: true,
                                  controller: hp.attachmentController,
                                  style: const TextStyle(color: Colors.white),
                                  onTap: () {
                                    if (hp.attachmentController.text.isEmpty) {
                                      hp.selectFiles();
                                    } else {
                                      hp.checkAttachmentIsEmptyOrNot(context);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Attachment",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                )
                              ],
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepOrange),
                            onPressed: () {
                              if (hp.selectedUsers.isEmpty) {
                                hp.sendMailUsingCustomEmails(context);
                              } else {
                                hp.sendMail(context);
                              }
                              // hp.getAllUser();
                              // hp.sendMail("This is the subject");
                            },
                            child: const Text("Send Mail")),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
