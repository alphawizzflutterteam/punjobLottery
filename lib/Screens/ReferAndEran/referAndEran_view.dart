import 'dart:convert';
import 'package:booknplay/Screens/ReferAndEran/referAndearnList.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/ReferEarnModel.dart';

class ReferAndEran extends StatefulWidget {
  const ReferAndEran({
    Key? key,
  }) : super(key: key);

  @override
  State<ReferAndEran> createState() => _ReferAndEranState();
}

class _ReferAndEranState extends State<ReferAndEran> {
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

  getReferEarn() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://punjablottery.online/Apicontroller/refererral_lists'));
    request.fields.addAll({'referral_code': '72abbf4741aa'});
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
          "Refer & Earn",
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/refer.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Refer And Earn",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: AppColors.fntClr),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Invite your friends to join and get the reward as soon as your friend first order placed",
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Your Referral Code",
                    style: TextStyle(color: AppColors.fntClr),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: AppColors.secondary,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "$userReferCode",
                        style: TextStyle(color: AppColors.fntClr),
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.activeBorder,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(4.0))),
                    child: const Text(
                      "Tap to copy",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.whit),
                    ),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "$userReferCode"));
                    // setSnackbar('Refercode Copied to clipboard');
                    Fluttertoast.showToast(
                        msg: 'Refercode Copied to clipboard',
                        backgroundColor: AppColors.primary);
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          share(referCode: userReferCode);
                        },
                        title: "Share",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReferAndEarnList(
                                        referCode: '$userReferCode',
                                      )));
                        },
                        title: "Referral List",
                      ),
                    ),
                  ],
                ),

                // AppButton(
                //   onTap: () {
                //     share(referCode: userReferCode);
                //   },
                //   title: "Share",
                // ),
                // SizedBox(height: 10),
                // AppButton(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => ReferAndEarnList(
                //                   referCode: '$userReferCode',
                //                 )));
                //   },
                //   title: "Referral List",
                // ),
                SizedBox(
                  height: 10,
                ),
              ],
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
