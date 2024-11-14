import 'dart:convert';

import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/GetTransaction1Model.dart';
import '../../Models/HomeModel/GetTransaction1Model.dart';
import '../../Models/HomeModel/GetTransaction1Model.dart';
import '../../Models/HomeModel/GetTransaction1Model.dart';
import '../../Models/HomeModel/Get_transaction_model.dart';
import '../../Models/HomeModel/lottery_list_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  TransactionScreen({Key? key, this.isFrom, this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
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
              "My Transaction",
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
          body: getTransaction1Model == null
              ? Center(child: CircularProgressIndicator())
              : getTransaction1Model!.walletTransaction!.length == 0
                  ? Center(
                      child: Text("Withdraw Trasaction Data Not Available"))
                  : SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.1,
                        child: ListView.builder(
                            itemCount:
                                getTransaction1Model!.walletTransaction!.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      // child: Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         Text(
                                      //           "₹${getTransaction1Model!.walletTransaction![i].amount}",
                                      //           style: TextStyle(
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.w600,
                                      //             color: getTransaction1Model!
                                      //                         .walletTransaction![
                                      //                             i]
                                      //                         .amountType ==
                                      //                     "1"
                                      //                 ? Colors.green
                                      //                 : Colors.red,
                                      //           ),
                                      //         ),
                                      //         // Text(
                                      //         //   " ₹ ${getTransaction1Model!.walletTransaction![i].amount}",
                                      //         //   style: TextStyle(fontSize: 16),
                                      //         // ),
                                      //         Text(
                                      //           getTransaction1Model!
                                      //                       .walletTransaction![
                                      //                           i]
                                      //                       .insertDate !=
                                      //                   null
                                      //               ? DateFormat(
                                      //                       'dd/MM/yy hh:mm a')
                                      //                   .format(
                                      //                   DateTime.parse(
                                      //                       getTransaction1Model!
                                      //                           .walletTransaction![
                                      //                               i]
                                      //                           .insertDate!),
                                      //                 )
                                      //               : 'N/A',
                                      //           style: TextStyle(
                                      //             fontSize: 14,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     SizedBox(height: 5),
                                      //     Text(
                                      //       "${getTransaction1Model!.walletTransaction![i].transactionNote}",
                                      //       maxLines: 2,
                                      //       overflow: TextOverflow.ellipsis,
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //       ),
                                      //     ),
                                      //     SizedBox(height: 5),
                                      //     Text(
                                      //       " ${getTransaction1Model!.walletTransaction![i].gameName}",
                                      //       maxLines: 2,
                                      //       overflow: TextOverflow.ellipsis,
                                      //       style: TextStyle(fontSize: 14),
                                      //     ),
                                      //   ],
                                      // ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " ₹${getTransaction1Model!.walletTransaction![i].amount}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: getTransaction1Model!
                                                          .walletTransaction![i]
                                                          .amountType ==
                                                      "1"
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              " ID : ${getTransaction1Model!.walletTransaction![i].transactionId}"),
                                          SizedBox(height: 5),
                                          Text(
                                            " Date : ${getTransaction1Model!.walletTransaction![i].insertDate != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(getTransaction1Model!.walletTransaction![i].insertDate!)) : 'N/A'}",
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              "Message:${getTransaction1Model!.walletTransaction![i].transactionNote}"),
                                          SizedBox(height: 5),
                                          Text(
                                              "Lottery Name: ${getTransaction1Model!.walletTransaction![i].gameName}"),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )),
    );
  }

  String? userId;
  GetTransaction1Model? getTransaction1Model;

  getTransactionApi() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
    };
    var request = http.Request('POST',
        Uri.parse('$baseUrl1/Apicontroller/apiUserAllTransactionHistory'));
    request.body = json.encode({"user_id": userId});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetTransaction1Model.fromJson(jsonDecode(result));
      Fluttertoast.showToast(msg: "${finalResult.msg}");
      setState(() {
        getTransaction1Model = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  // String? userId;
  getUser() async {
    userId = await SharedPre.getStringValue('userId');
    getTransactionApi();
    // get();
  }
}
