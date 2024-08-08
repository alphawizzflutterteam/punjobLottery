import 'dart:convert';
import 'package:booknplay/Models/HomeModel/lottery_number_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/my_lottery_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';
import 'package:http/http.dart' as http;

class ContestDetails extends StatefulWidget {
  ContestDetails({Key? key, this.isFrom, this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<ContestDetails> createState() => _ContestDetailsState();
}

class _ContestDetailsState extends State<ContestDetails> {
  var result = '';
  @override
  void initState() {
    super.initState();
    getLotteries();
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
              "Contest Details",
              style: TextStyle(fontSize: 17),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10),
                  ),
                  color: AppColors.secondary
                  // gradient: RadialGradient(
                  //     center: Alignment.center,
                  //     radius: 1.1,
                  //     colors: <Color>[AppColors.primary, AppColors.secondary]),
                  ),
            ),
          ),
          body: myLotteryModel == null
              ? Center(child: CircularProgressIndicator())
              : myLotteryModel!.length == 0
                  ? Center(child: Text('No Data Found'))
                  : SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.1,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: myLotteryModel!.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,
                              //   childAspectRatio: 4/1
                              // ),
                              itemBuilder: (context, i) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    // "${myLotteryModel![i].bookStatus} Ticket",
                                                    "Ticket Number",
                                                    style: TextStyle(
                                                        color: AppColors.fntClr,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                // Text(" Price : ₹${myLotteryModel!.data!.lotteries![0].winners![i].winnerPrice}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500)),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                // Text(" Name : ${myLotteryModel!.data!.lotteries![0].winners![i].userName}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              height: 50,
                                              child: Card(
                                                elevation: 2,
                                                child: Center(
                                                    child: Text(
                                                        "${myLotteryModel![i].lotteryNumber!}")),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                    )),
    );
  }

  List<LotteryNumberModel>? myLotteryModel;

  String? userId;

  getLotteries() async {
    print("here lottery${getLotteries}");
    userId = await SharedPre.getStringValue('userId');
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=d589652f668ca2e40929c666f6a1601bc5f4e80d'
    };
    var request = http.Request('POST',
        Uri.parse('https://punjablottery.online/Apicontroller/getLotteries'));

    request.body =
        json.encode({"user_id": "$userId", "game_id": "${widget.gId}"});
    // request.body = '{"user_id":"$userId""game_id": "${widget.gId}"}';
    print("here is para ${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var data = json.decode(result);
      myLotteryModel = data['data']['new']
          .map<LotteryNumberModel>((i) => LotteryNumberModel.fromJson(i))
          .toList();
      print("here model${myLotteryModel}");
      setState(() {});
      // Fluttertoast.showToast(msg: "${finalResult.msg}");
    } else {
      print(response.reasonPhrase);
    }
  }
}
