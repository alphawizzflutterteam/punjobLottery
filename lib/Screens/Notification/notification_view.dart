import 'dart:convert';

import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/notification_model.dart';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/HomeModel/lottery_list_model.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, this.isFrom, this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;

  List<NotificationModel> notificationList = [];
  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.whit,
          appBar: AppBar(
            foregroundColor: AppColors.whit,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50),
              ),
            ),
            toolbarHeight: 60,
            centerTitle: true,
            title: const Text(
              "Notification List",
              style: TextStyle(fontSize: 17),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10),
                ),
                gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.1,
                    colors: <Color>[AppColors.primary, AppColors.secondary]),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              child: isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : notificationList.length > 0
                      ? ListView.builder(
                          itemCount: notificationList.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${notificationList[i].msg}"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text('No Data Found'),
                        ),
            ),
          )),
    );
  }

  LotteryListModel? lotteryDetailsModel;
//   String ?userId;
  getNotification() async {
    setState(() {
      isLoading = true;
    });
    // String? userId = await SharedPre.getStringValue('userId');
    // var headers = {
    //   'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('$baseUrl1/Apicontroller/getNotification'));
    // request.body = json.encode({"user_id": userId ?? ''});
    // print('_____request.body_____${request.body}_________');
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //   var result = await response.stream.bytesToString();
    //   var finalResult = json.decode(result);
    //   Fluttertoast.showToast(msg: "${finalResult['msg']}");
    //   if (finalResult["status"]) {
    //     var data = finalResult["data"];
    //     notificationList = (data as List)
    //         .map((data) => new NotificationModel.fromJson(data))
    //         .toList();
    //   } else {}
    //   // var finalResult = LotteryListModel.fromJson();
    // } else {
    //   print(response.reasonPhrase);
    // }
    String? userId = await SharedPre.getStringValue('userId');
    var parameter = {"user_id": userId ?? ''};
    apiBaseHelper
        .postAPICall(
            Uri.parse('$baseUrl1/Apicontroller/getNotification'), parameter)
        .then(
      (getdata) async {
        bool status = getdata["status"];
        String? msg = getdata["msg"];
        Fluttertoast.showToast(msg: msg ?? '');
        print(parameter.toString());
        if (status) {
          var data = getdata["data"];
          notificationList = (data as List)
              .map((data) => new NotificationModel.fromJson(data))
              .toList();
        }
        setState(() {
          isLoading = false;
        });
      },
      onError: (error) {
        Fluttertoast.showToast(msg: "${error}");
        setState(() {
          isLoading = false;
        });
      },
    );
  }
}
