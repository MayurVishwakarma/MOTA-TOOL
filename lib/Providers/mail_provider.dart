// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:motatool/Screens/Mail/constants.dart';
import 'package:motatool/Screens/Mail/utils.dart';
import 'package:motatool/models/UserDetailsModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum ContentType { Normal, HTML }

enum SharedPrefKeys { adminEmail, adminPassword, host }

class MyMailProvider extends ChangeNotifier {
  MyMailProvider() {
    getAllUser();
  }
  var toController = TextEditingController();
  var subjectController = TextEditingController();
  var contentController = TextEditingController();
  var attachmentController = TextEditingController();

  var toFocusNode = FocusNode();
  var fromFocusNode = FocusNode();
  var contentFocusNode = FocusNode();

  ContentType? _contentType = ContentType.Normal;
  ContentType? get contentType => _contentType;
  List<UserDetailsModel> _users = [];
  List<UserDetailsModel> get users => _users;

  List<UserDetailsModel> _selectedUsers = [];
  List<UserDetailsModel> get selectedUsers => _selectedUsers;

  List<PlatformFile> _attachmentFiles = [];
  List<PlatformFile> get attachmentFiles => _attachmentFiles;

  String _output = '';
  String? _deletedChip, _deletedChipIndex;

  String get output => _output;
  String get deletedChip => _deletedChip ?? "";
  String get deletedChipIndex => _deletedChipIndex ?? "";

  updateOutput(String newOutput) {
    _output = newOutput;
    notifyListeners();
  }

  updateDeletedChip(String newDeletedChip) {
    _output = newDeletedChip;
    notifyListeners();
  }

  updateDeletedChipIndex(String newDeletedChipIndex) {
    _output = newDeletedChipIndex;
    notifyListeners();
  }

  updateAttachmentFiles(List<PlatformFile> newAttachmentFiles) {
    _attachmentFiles = newAttachmentFiles;
    notifyListeners();
  }

  //UPDATE CONTENT TYPE
  updateContentType(ContentType? newContent) {
    _contentType = newContent;
    notifyListeners();
  }

  updateSelectedUsers(List<UserDetailsModel>? newUsers) {
    _selectedUsers = newUsers ?? [];
    notifyListeners();
  }

  Future<bool> storeSharePreference(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    var res = await storage.setString(key, value);
    return res;
  }

  Future<String?> getStringFromSharedPref(String key) async {
    var storage = await SharedPreferences.getInstance();
    var result = storage.getString(key);
    return result;
  }

  Future<String> getAdminEmail() async {
    var res = await getStringFromSharedPref(SharedPrefKeys.adminEmail.name);
    if (res != null) {
      return res;
    } else {
      return USEREMAIL;
    }
  }

  clearSharedPrefs(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = await sharedPreferences.clear();
    if (res && context.mounted) {
      notifyListeners();
      Utils.showCustomSnackBar(context, "SharedPreferences Reset Successfully");
    }
  }

  Future<String> getHost() async {
    var res = await getStringFromSharedPref(SharedPrefKeys.host.name);
    if (res != null) {
      return res;
    } else {
      return HOST;
    }
  }

  Future<String> getAdminPassword() async {
    var res = await getStringFromSharedPref(SharedPrefKeys.adminPassword.name);
    if (res != null) {
      return res;
    } else {
      return PASSWORD;
    }
  }

  //dialog
  showUpdateDialog(
      BuildContext context, String title, SharedPrefKeys sharedPrefKey) {
    showDialog(
      context: context,
      builder: (context) {
        var controller = TextEditingController();
        return AlertDialog(
          title: Text(
            "Update $title",
            style: const TextStyle(fontSize: 20),
          ),
          content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: title)),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  var res = await storeSharePreference(
                      sharedPrefKey.name, controller.text);
                  if (res == true) {
                    if (context.mounted) {
                      Navigator.pop(context);
                      Utils.showCustomSnackBar(
                          context, "$title Changed Successfully");
                    }
                    notifyListeners();
                  }
                },
                child: const Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }

  storeUserPass(String email, String password) {
    storeSharePreference(SharedPrefKeys.adminEmail.name, email);
    storeSharePreference(SharedPrefKeys.adminEmail.name, password);
  }

  //ADD USER
  addSelectedUser(int userId) {
    var userList = users.where((element) => element.userId == userId).toList();
    if (userList.isNotEmpty) {
      var res =
          _selectedUsers.where((element) => element.userId == userId).toList();
      if (res.isEmpty) {
        _selectedUsers.add(userList.first);
      }
    }
    notifyListeners();
  }

  //REMOVE AN EXISTING USER
  removeSelectedUser(int userId) {
    var userList = users.where((element) => element.userId == userId).toList();
    if (userList.isNotEmpty) {
      selectedUsers.remove(userList.first);
      notifyListeners();
    }
  }

  //CHECK IF THE USER IS PRESENT IN THE USERLIST OR NOT
  bool checkUserInSelectedList(int userId) {
    var userList =
        selectedUsers.where((element) => element.userId == userId).toList();
    if (userList.isNotEmpty) {
      return true;
    }
    return false;
  }

  //UPDATE USER LIST
  updateUserList(List<UserDetailsModel>? newUserList) {
    _users = newUserList ?? [];
    notifyListeners();
  }

  bool checkIfAllUsersArePresent() {
    bool areEqual = false;

    if (users.length == selectedUsers.length) {
      areEqual = true;
    }
    return areEqual;
  }

  selectAllUsers() {
    _selectedUsers.clear();
    _selectedUsers.addAll(users);
    notifyListeners();
  }

  unSelectedAllUsers() {
    _selectedUsers.clear();
    notifyListeners();
  }

  checkAttachmentIsEmptyOrNot(BuildContext context) {
    if (attachmentController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Do You Want to Change Attachment ?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    selectFiles();
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"))
            ],
          );
        },
      );
    }
  }

  selectFiles() async {
    var res = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: true);
    var selectedFileString = "";
    if (res != null) {
      updateAttachmentFiles(res.files);
      for (int i = 0; i < (res.files.length); i++) {
        if (i == 0) {
          selectedFileString = res.files[0].name;
        } else if (i == res.files.length) {
          selectedFileString =
              selectedFileString + res.files[res.files.length].name;
        } else {
          selectedFileString = "$selectedFileString,${res.files[i].name}";
        }
      }
    }
    attachmentController.text = selectedFileString;
    notifyListeners();
  }

  Message getMessage(String content, String email, String userEmail) {
    if (contentType == ContentType.HTML) {
      final message = Message()
        ..from = Address(userEmail)
        ..recipients.add(email)
        ..subject = subjectController.text
        ..html = content
        ..attachments = attachmentFiles
            .map((e) => FileAttachment(File(e.path ?? "")))
            .toList();
      return message;
    } else if (contentType == ContentType.Normal) {
      final message = Message()
        ..from = Address(userEmail)
        ..recipients.add(email)
        ..subject = subjectController.text
        ..text = content
        ..attachments = attachmentFiles
            .map((e) => FileAttachment(File(e.path ?? "")))
            .toList();
      return message;
    }
    return Message();
  }

  Message getMessageForMulitpleEmail(
      String content, List<String> emails, String userEmail) {
    if (contentType == ContentType.HTML) {
      final message = Message()
        ..from = Address(userEmail)
        ..recipients.addAll(emails)
        ..subject = subjectController.text
        ..html = content
        ..attachments = attachmentFiles.map((e) {
          return FileAttachment(File(e.path ?? ""));
        }).toList();
      return message;
    } else if (contentType == ContentType.Normal) {
      final message = Message()
        ..from = Address(userEmail)
        ..recipients.addAll(emails)
        ..subject = subjectController.text
        ..text = content
        ..attachments = attachmentFiles
            .map((e) => FileAttachment(File(e.path ?? "")))
            .toList();
      return message;
    }
    return Message();
  }

  /*sendMail() async {
    var adminEmail = await getAdminEmail();
    var adminPassword = await getAdminPassword();
    var host = await getHost();
    final smtpServer =
        SmtpServer(host, username: adminEmail, password: adminPassword);
    var connection = PersistentConnection(smtpServer);
    //loop for send mail
    for (var i = 0; i < selectedUsers.length; i++) {
      var content = contentController.text;
      selectedUsers[i].toJson().forEach((key, value) {
        var mykey = 'user.$key';
        if (content.contains("user.$key")) {
          content = content.replaceAll(mykey, value.toString());
        }
      });

      final message =
          getMessage(content, selectedUsers[i].email ?? "", adminEmail);
      try {
        final sendReport = await connection.send(message);
        print('Message sent: $sendReport');
      } on MailerException catch (e) {
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
    await connection.close();
  }
*/
  sendMailUsingCustomEmails(BuildContext context) async {
    var adminEmail = await getAdminEmail();
    var adminPassword = await getAdminPassword();
    var host = await getHost();
    final smtpServer = SmtpServer(host,
        username: adminEmail,
        password: adminPassword,
        allowInsecure: true,
        ssl: false,
        ignoreBadCertificate: true);
    var connection = PersistentConnection(smtpServer);
    var content = contentController.text;
    var allEmails =
        output.split(",").toList().where((element) => element != "").toList();
    final message = getMessageForMulitpleEmail(content, allEmails, adminEmail);
    try {
      final sendReport = await connection.send(message);
      if (context.mounted) {
        Utils.showCustomSnackBar(context, "Email sent successfully");
      }
      print('Message sent: $sendReport');
    } on Exception catch (e) {
      if (context.mounted) {
        Utils.showCustomSnackBar(context, "Error ouccured $e");
      }
    }

    await connection.close();
  }

  sendMail(BuildContext context) async {
    var adminEmail = await getAdminEmail();
    var adminPassword = await getAdminPassword();
    var host = await getHost();
    final smtpServer = SmtpServer(host,
        username: adminEmail,
        password: adminPassword,
        allowInsecure: true,
        ssl: false,
        ignoreBadCertificate: true);
    var connection = PersistentConnection(smtpServer);
    //loop for send mail
    for (var i = 0; i < selectedUsers.length; i++) {
      var content = contentController.text;
      selectedUsers[i].toJson().forEach((key, value) {
        var mykey = 'user.$key';
        if (content.contains("user.$key")) {
          content = content.replaceAll(mykey, value.toString());
        }
      });

      final message =
          getMessage(content, selectedUsers[i].email ?? "", adminEmail);
      try {
        final sendReport = await connection.send(message);
        print('Message sent: $sendReport');
        if (context.mounted) {
          Utils.showCustomSnackBar(
              context, "Email send to ${selectedUsers[i].email}");
        }
      } on Exception catch (e) {
        if (context.mounted) {
          Utils.showCustomSnackBar(context, "Error ouccured $e");
        }
      }
    }
    await connection.close();
  }

  /*sendMailUsingCustomEmails() async {
    var adminEmail = await getAdminEmail();
    var adminPassword = await getAdminPassword();
    var host = await getHost();
    final smtpServer =
        SmtpServer(host, username: adminEmail, password: adminPassword);
    var connection = PersistentConnection(smtpServer);
    //loop for send mail
    var content = contentController.text;
    var allEmails = output.split(",").toList().where((element) => element != "").toList();
    final message = getMessageForMulitpleEmail(content, allEmails,adminEmail);
    try {
      final sendReport = await connection.send(message);
      print('Message sent: $sendReport');
    } on Exception catch (e) {
      print(e);
      // for (var p in e.problems) {
      //   print('Problem: ${p.code}: ${p.msg}');
      // }
    }

    await connection.close();
  }
*/
  getAllUser() async {
    updateUserList(null);
    updateSelectedUsers(null);
    try {
      var url =
          "http://bn.usplbot.com/allusers/03ti9vnhmrwq0qhinzsw5jkj0cad97jtl1n0fpywzxloj4m0yi7kj9b0pk0m623r0elmq";
      var res = await http.get(Uri.parse(url));
      var list = (jsonDecode(res.body)['data'] as List)
          .map((e) => UserDetailsModel.fromJson(e))
          .toList();
      updateUserList(list);
    } catch (e) {
      print(e);
    }
  }

  // http://bn.usplbot.com/allusers/03ti9vnhmrwq0qhinzsw5jkj0cad97jtl1n0fpywzxloj4m0yi7kj9b0pk0m623r0elmq
}
