import 'package:flutter/material.dart';
import 'package:motatool/Providers/mail_provider.dart';
import 'package:provider/provider.dart';

class MySettingPage extends StatelessWidget {
  const MySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mp = Provider.of<MyMailProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        actions: [
          ElevatedButton.icon(onPressed: (){
            mp.clearSharedPrefs(context);
          }, icon: const Icon(Icons.restore), label: const Text("Reset")),],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("Host",style: TextStyle(color: Colors.white),)),
                  Expanded(
                    flex: 3,
                    child: FutureBuilder(
                        future: mp.getHost(),
                        builder: (context, snapshot) {
                          print("test");
                          return Text(snapshot.data.toString(),style: TextStyle(color: Colors.white),);
                        }),
                  ),
                  IconButton(
                      onPressed: () {
                        mp.showUpdateDialog(
                            context, "Host", SharedPrefKeys.host);
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("Email",style: TextStyle(color: Colors.white),)),
                  Expanded(
                    flex: 3,
                    child: FutureBuilder(
                        future: mp.getAdminEmail(),
                        builder: (context, snapshot) {
                          print("test");
                          return Text(snapshot.data.toString(),style: TextStyle(color: Colors.white),);
                        }),
                  ),
                  IconButton(
                      onPressed: () {
                        mp.showUpdateDialog(
                            context, "Email", SharedPrefKeys.adminEmail);
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("Password",style: TextStyle(color: Colors.white),)),
                  const Expanded(
                    flex: 3,
                    child: Text("**********",style: TextStyle(color: Colors.white),),
                  ),
                  IconButton(
                      onPressed: () {
                        mp.showUpdateDialog(
                            context, "Password", SharedPrefKeys.adminPassword);
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ),
            // const SizedBox(height: 16,),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width/3,
            //   child: ElevatedButton(onPressed: ()async{
            //     // mp.storeUserPass("vaibhavsjaigade@gmail.com","test");
            //     var t=await mp.getAdminEmail();
            //     print(t);
            //   },style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white,
            //     backgroundColor: Colors.blue,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
            //   ), child: const Text("Save")))
          ],
        ),
      ),
    );
  }
}
