import 'package:flutter/material.dart';
import 'package:motatool/Providers/mail_provider.dart';
import 'package:motatool/Screens/Mail/homepage.dart';
import 'package:motatool/Screens/Mail/settingpage.dart';


import 'package:provider/provider.dart';

class MailSection extends StatelessWidget {
  const MailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyMailProvider(),
      child: Scaffold(
        appBar: AppBar(
        title: const Text(
          "Mail Sender",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MySettingPage(),));
        }, icon: Icon(Icons.settings))],
      ),
      
        body: Row(
          children: [
            Expanded(
              child: Consumer<MyMailProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              // tileColor: Colors.blue,
                              value: value.checkIfAllUsersArePresent(),
                              title: const Text("Select All Users",style: TextStyle(color: Colors.white,fontSize: 12),),
                              onChanged: (val) {
                                if (val == true) {
                                  value.selectAllUsers();
                                } else {
                                  value.unSelectedAllUsers();
                                }
                              },
                              controlAffinity:
                                  ListTileControlAffinity.leading,
                            ),
                          ),
                          
                      
                        ],
                      ),
                      Divider(color: Colors.white,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.users.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${value.users[index].name.toString()}", style: TextStyle(color: Colors.white,fontSize: 12),),
                                      Text("${value.users[index].email.toString()}", style: TextStyle(color: Colors.white,fontSize: 12),),
                                      Text("${value.users[index].broker.toString()}", style: TextStyle(color: Colors.amber,fontSize: 12),),
                                    ],
                                  ),
                              value: value.checkUserInSelectedList(
                                  value.users[index].userId ?? 0),
                              controlAffinity:
                                  ListTileControlAffinity.leading,
                              onChanged: (val) {
                                if (val == true) {
                                  value.addSelectedUser(
                                      value.users[index].userId ?? 0);
                                  // value.addEmail(value.users[index].email);
                                } else {
                                  value.removeSelectedUser(
                                      value.users[index].userId ?? 0);
                                  // value.removeEmail(value.users[index].email);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              value.getAllUser();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5))),
                            child: const Text("Refresh List")),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(flex: 3, child: HomePage())
          ],
        ),
      ),
    );
  }
}
