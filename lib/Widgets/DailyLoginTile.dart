import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motatool/models/DailyLoginModel.dart';
import 'package:motatool/resources/color_manager.dart';

class DailyLoginTile extends StatelessWidget {
  final DailyLoginModel userdata;
  DailyLoginTile({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      // height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.balck255, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat("dd-MMM-yyyy")
                .format(DateTime.parse(userdata.loginDate ?? '')),
            style: const TextStyle(color: Colors.cyan),
          ),
          Text(
            DateFormat("hh:mm:ss a")
                .format(DateTime.parse(userdata.loginDate ?? '')),
            style: const TextStyle(color: Colors.cyan),
          ),
          Text(
            "${(userdata.margin ?? 0.0)}",
            style: const TextStyle(color: Colors.cyan),
          )
        ],
      ) /*Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userdata.name ?? '',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${userdata.broker}",
                style: const TextStyle(color: Colors.amber),
              ),
              Row(
                children: [
                  const Text(
                    "Margin  ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(userdata.margin ?? 0.0)}",
                    style: const TextStyle(color: Colors.cyan),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Login Id : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${userdata.loginId}",
                    style: const TextStyle(color: Colors.cyan),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Mobile No : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userdata.mobileNo ?? '',
                    style: const TextStyle(color: Colors.cyan),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Login Date : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat("dd-MMM-yyyy")
                        .format(DateTime.parse(userdata.loginDate ?? '')),
                    style: const TextStyle(color: Colors.cyan),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Login Time : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat("hh:mm:ss a")
                        .format(DateTime.parse(userdata.loginDate ?? '')),
                    style: const TextStyle(color: Colors.cyan),
                  ),
                ],
              ),
            ],
          ),
        ],
      )*/
      ,
    );
  }
}
