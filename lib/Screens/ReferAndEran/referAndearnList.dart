import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/ReferEarnModel.dart';

class ReferAndEarnList extends StatefulWidget {
  final String referCode;
  const ReferAndEarnList({Key? key, required this.referCode}) : super(key: key);

  @override
  State<ReferAndEarnList> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarnList> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getMobile();
  }

  String? mobile, userReferCode;
  getMobile() async {
    mobile = await SharedPre.getStringValue('userMobile');
    userReferCode = await SharedPre.getStringValue('userReferCode');
    setState(() {});
    getReferEarn();
  }

  ReferEarnModel? referEarnModel;
  String? userId;
  bool isLoading = true;
  getReferEarn() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://punjablottery.online/Apicontroller/refererral_lists'));
    request.fields.addAll({'referral_code': widget.referCode});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = ReferEarnModel.fromJson(json.decode(result));
      Fluttertoast.showToast(msg: "${finalResult.msg}");
      setState(() {
        referEarnModel = finalResult;
        print("asdadadasad ${referEarnModel?.data?.length}");
      });
    } else {
      print(response.reasonPhrase);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Referral List",
          style: TextStyle(fontSize: 17, color: AppColors.whit),
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : referEarnModel?.data?.length == 0 ||
                              referEarnModel?.data?.length == null
                          ? const Center(
                              child: Text(
                              "No referral Found",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              //  height: 500,
                              child: ListView.builder(
                                itemCount: referEarnModel?.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  referEarnModel?.data?[index]
                                                          .insertDate ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  referEarnModel?.data?[index]
                                                          .userName ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(referEarnModel
                                                        ?.data?[index].mobile ??
                                                    ""),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                  // SimBtn(
                  //   size: 0.8,
                  //   title: "Share",
                  //   onBtnSelected: () {
                  //     var str =
                  //         "$appName\nRefer Code:$"REFER_CODE"\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
                  //     Share.share(str);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GlobalKey keyList = GlobalKey();
  bool iconVisible = true;
  Future<void> share({String? referCode}) async {
    await FlutterShare.share(
        title: 'Refer and Eran',
        text:
            'Download Punjab lottery from the invite code below and sign up with the referral code $referCode',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.punjab&pcampaignid=web_share&pli=1',
        chooserTitle: 'Example Chooser Title');
  }
}
