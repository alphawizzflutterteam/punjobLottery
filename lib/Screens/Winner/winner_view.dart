import 'dart:async';
import 'dart:convert';

import 'package:booknplay/Utils/Colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/lottery_list_model.dart';
import '../../Services/api_services/apiConstants.dart';
import 'package:http/http.dart' as http;

class WinnerScreen extends StatefulWidget {
  WinnerScreen({Key? key, this.isFrom, this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  var result = '';

  @override
  void initState() {
    super.initState();

    getLottery();
  }

  int _counter = 60;
  late Timer _timer;

  int _counter1 = 4;
  late Timer _timer1;

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  String selectedBalanceType = 'balance';
  bool isFirst = true;
  var amount = 0;
  String? purchase;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomSheet: Container(
            height: 112,
            color: AppColors.whit,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // const Divider(
                    //   color: AppColors.fntClr,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'balance',
                                  groupValue: selectedBalanceType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBalanceType = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  "Balance:",
                                  style: TextStyle(
                                      color: AppColors.fntClr,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  lotteryDetailsModel
                                              ?.data?.lottery?.walletBalance !=
                                          null
                                      ? (selectedBalanceType == 'balance')
                                          ? (int.parse(lotteryDetailsModel
                                                          ?.data
                                                          ?.lottery
                                                          ?.walletBalance ??
                                                      '0') >
                                                  amount)
                                              ? "${int.parse(lotteryDetailsModel?.data?.lottery?.walletBalance ?? '0') - amount}"
                                              : '0'
                                          : "${lotteryDetailsModel?.data?.lottery?.walletBalance ?? '0'}"
                                      : "₹ ${lotteryDetailsModel?.data?.lottery?.walletBalance ?? ''}",
                                  style: const TextStyle(
                                      color: AppColors.profileColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            // int.parse(lotteryDetailsModel
                            //                 ?.data?.lottery?.walletBalance ??
                            //             '0') >
                            //         0
                            //     ? const SizedBox():
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'referEarnBalance',
                                  groupValue: selectedBalanceType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBalanceType = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  "Refer earn balance:",
                                  style: TextStyle(
                                      color: AppColors.fntClr,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  lotteryDetailsModel
                                              ?.data?.lottery?.referBalance !=
                                          null
                                      ? (selectedBalanceType ==
                                              "referEarnBalance")
                                          ? int.parse(lotteryDetailsModel
                                                          ?.data
                                                          ?.lottery
                                                          ?.referBalance!
                                                          .split('.')[0] ??
                                                      '0') >
                                                  amount
                                              ? "${int.parse(lotteryDetailsModel?.data?.lottery?.referBalance!.split('.')[0] ?? '0') - amount}"
                                              : '0'
                                          : "${lotteryDetailsModel?.data?.lottery?.referBalance!.split('.')[0] ?? '0'}"
                                      : "₹ ${lotteryDetailsModel?.data?.lottery?.referBalance ?? ''}",
                                  style: const TextStyle(
                                      color: AppColors.profileColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        lotteryDetailsModel?.data?.lottery!.active == "1"
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print(amount);
                                      if (purchase == '1') {
                                        Fluttertoast.showToast(
                                            msg: "All ready buy!!");
                                      } else if (amount == 0) {
                                        Fluttertoast.showToast(
                                            msg: "Please select Ticket");
                                      } else {
                                        buyLotteryApi();
                                      }
                                      //addTikitList();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.secondary
                                          // gradient: RadialGradient(
                                          //     radius: 1.2,
                                          //     colors: [
                                          //       AppColors.primary,
                                          //       AppColors.secondary
                                          //     ]),
                                          ),
                                      child: Center(
                                          child: Text(
                                        amount == 0 ? "BUY" : "Buy ₹ $amount ",
                                        style: const TextStyle(
                                            color: AppColors.whit),
                                      )),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                )),
          ),
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
              "Winner",
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
          body: lotteryDetailsModel?.data?.lottery == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Entry Fees",
                              style: TextStyle(
                                  color: AppColors.fntClr,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: 5,),
                            Text(
                              "₹${lotteryDetailsModel!.data!.lottery!.ticketPrice}",
                              style: const TextStyle(
                                  color: AppColors.fntClr,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 20,),
                      Container(
                        height: 120,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: lotteryDetailsModel!
                                .data!.lottery!.winningPositionHistory!.length,
                            // itemCount:2,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //Get.toNamed(winnerScreen,arguments:lotteryModel?.data?.lotteries?[index].gameId );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                      // height: 50,
                                      width: 160,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/winningOrice.png"),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "${lotteryDetailsModel!.data!.lottery!.winningPositionHistory![index].winningPosition}",
                                              style: const TextStyle(
                                                  color: AppColors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 11,
                                          ),
                                          const Text(
                                            "Winner Price ",
                                            style: TextStyle(
                                                color: AppColors.whit,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "₹${lotteryDetailsModel!.data!.lottery!.winningPositionHistory![index].winnerPrice}",
                                            style: const TextStyle(
                                                color: AppColors.whit,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ),
                      Container(
                        color: AppColors.lotteryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     const Text(
                                  //       "Lottery Price",
                                  //       style: TextStyle(
                                  //           color: AppColors.fntClr,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Text(
                                  //       "(₹${lotteryDetailsModel!.data!.lottery!.ticketPrice})",
                                  //       style: const TextStyle(
                                  //           color: AppColors.fntClr,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //         "Open: ${lotteryDetailsModel!.data!.lottery!.openTime}"),
                                  //     const SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Text(
                                  //         "Close ${lotteryDetailsModel!.data!.lottery!.closeTime}"),
                                  //   ],
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Open: ${lotteryDetailsModel!.data!.lottery!.openTime}",
                                    style: TextStyle(color: AppColors.fntClr),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "Close: ${lotteryDetailsModel!.data!.lottery!.closeTime}"),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Start: ${DateFormat('dd MMM yyyy').format(DateTime.parse(lotteryDetailsModel!.data!.lottery!.date ?? ""))}",
                                    style: const TextStyle(
                                        color: AppColors.fntClr),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "End: ${DateFormat('dd MMM yyyy').format(DateTime.parse(lotteryDetailsModel!.data!.lottery!.endDate ?? ""))}"),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.44,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 8 / 4),
                                  itemCount: lotteryDetailsModel!
                                      .data!.lottery!.lotteryNumbers!.length,
                                  itemBuilder: (context, index) {
                                    purchase = lotteryDetailsModel!
                                        .data!
                                        .lottery
                                        ?.lotteryNumbers?[index]
                                        .purchaseStatus;
                                    String? bookingStatus = lotteryDetailsModel!
                                        .data!
                                        .lottery
                                        ?.lotteryNumbers?[index]
                                        .bookStatus;
                                    String? bookedUser = lotteryDetailsModel!
                                        .data!
                                        .lottery
                                        ?.lotteryNumbers?[index]
                                        .userId;
                                    String? lotteryNum = lotteryDetailsModel!
                                        .data!
                                        .lottery!
                                        .lotteryNumbers![index]
                                        .lotteryNumber;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isFirst) {
                                            _timer = Timer.periodic(
                                                const Duration(seconds: 1),
                                                (timer) {
                                              setState(() {
                                                _counter--;
                                              });
                                              if (_counter == 0) {
                                                if (!_timer1.isActive) {
                                                  _timer.cancel();
                                                } else {
                                                  _counter = 60;
                                                }
                                              }
                                            });
                                            _timer1 = Timer.periodic(
                                                const Duration(minutes: 1),
                                                (timer) {
                                              setState(() {
                                                _counter1--;
                                              });
                                              if (_counter1 == 0) {
                                                _timer1.cancel();
                                              }
                                            });
                                          }
                                          if (bookingStatus == "0") {
                                            if (selectedCardIndexes
                                                .contains(index)) {
                                              setState(() {});
                                              cardData.remove(lotteryNum);
                                              amount -= int.parse(
                                                  lotteryDetailsModel!.data!
                                                      .lottery!.ticketPrice!);
                                              bookLotteryNumberApi(
                                                  lotteryNum!, false);
                                              selectedCardIndexes.remove(index);
                                            } else {
                                              setState(() {});
                                              bookLotteryNumberApi(
                                                  lotteryNum!, true);
                                              cardData.add(lotteryNum);

                                              amount += int.parse(
                                                  lotteryDetailsModel!
                                                          .data!
                                                          .lottery!
                                                          .ticketPrice ??
                                                      "0");
                                              selectedCardIndexes.add(index);
                                            }
                                          } else if (bookingStatus == "1" &&
                                              userId != bookedUser) {
                                            Fluttertoast.showToast(
                                                msg: "Already Booked");
                                          } else {
                                            setState(() {
                                              cardData.remove(lotteryNum);
                                              // amount -= int.parse(
                                              //     lotteryDetailsModel!.data!
                                              //         .lottery!.ticketPrice!);
                                              bookLotteryNumberApi(
                                                  lotteryNum!, false);
                                              selectedCardIndexes.remove(index);
                                            });
                                          }
                                        });
                                        isFirst = false;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: AppColors.fntClr),
                                            color: bookingStatus == "1" &&
                                                    userId != bookedUser
                                                ? AppColors.greyColor
                                                : selectedCardIndexes
                                                        .contains(index)
                                                    ? AppColors.secondary
                                                    : bookingStatus == '1'
                                                        ? AppColors.secondary
                                                        : AppColors.whit,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${lotteryDetailsModel!.data!.lottery?.lotteryNumbers?[index].lotteryNumber}",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: selectedCardIndexes
                                                            .contains(index) ||
                                                        lotteryDetailsModel!
                                                                .data!
                                                                .lottery
                                                                ?.lotteryNumbers?[
                                                                    index]
                                                                .bookStatus ==
                                                            "1"
                                                    ? AppColors.whit
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(height: 100,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  List<int> selectedCardIndexes = [];
  List<String> cardData = [];
  void addTikitList() {
    // for(int i =0; i<cardData.length;i++){
    //   if(i==0){
    //     result = result + cardData[i];
    //   }else{
    //     result = "$result, ${cardData[i]}";
    //  }
    // }
    print(cardData.toString());
  }

  LotteryListModel? lotteryDetailsModel;
  String? userId;

  getLottery() async {
    userId = await SharedPre.getStringValue('userId');
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl1/Apicontroller/getLottery'));
    request.body = json.encode({"game_id": widget.gId, "user_id": userId});
    print('_____request.bodyhhh_____${request.body}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      var finalResult = LotteryListModel.fromJson(json.decode(result));
      Fluttertoast.showToast(msg: "${finalResult.msg}");
      setState(() {
        lotteryDetailsModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  buyLotteryApi() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=b573cdbddfc5117759d47585dfc702de3f6f0cc9'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl1/Apicontroller/buyLottery'));

    request.body = json.encode({
      "user_id": userId,
      "game_id": widget.gId,
      "amount": amount,
      "lottery_numbers": cardData,
      "order_number": "2675db01c965",
      "txn_id": "2675db01c965ijbdhgd",
      "payment_method":
          selectedBalanceType == "referEarnBalance" ? "refer_n_earn" : "wallet"
    });
    print("here is a params___________${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      Fluttertoast.showToast(msg: "${jsonResponse['msg']}");
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  bookLotteryNumberApi(String lottery, status) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=c409297463ece9a50b186ed0d83573aa184203a2'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl1/Apicontroller/bookLotteryNumber'));
    print("request______________${request}");
    request.body = json.encode({
      "game_id": widget.gId,
      "user_id": userId,
      "lottery_number": lottery,
      "select": status
    });
    print('______request.body____${request.body}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      Fluttertoast.showToast(msg: "${finalResult['msg']}");
    } else {
      print(response.reasonPhrase);
    }
  }
}
