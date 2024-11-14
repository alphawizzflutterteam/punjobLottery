import 'dart:convert';

import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/manageUserStatus.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_result_model.dart';
import '../../Models/HomeModel/get_slider_model.dart';
import '../../Models/HomeModel/lottery_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../Notification/notification_view.dart';
import '../Winner/winner_details_view.dart';
import '../Winner/winner_view.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlider();
    getLottery();
    getResult();
    getUser();
    ManageUserStatus.getProfileAndCheckUserStatus();
  }

  String? userId;
  getUser() async {
    userId = await SharedPre.getStringValue('userId');
    getResult();
  }

  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.greyColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50),
            ),
          ),
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 17, color: AppColors.whit),
          ),
          leading: Image.asset(
            'assets/images/tytle_icon.png',
            scale: 25,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: Image.asset(
                    "assets/images/notification.png",
                    height: 15,
                    width: 20,
                    color: AppColors.whit,
                  )),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10),
                ),
                color: AppColors.secondary
                // gradient: RadialGradient(
                //     center: Alignment.center,
                //     radius: 1.9,
                //     colors: <Color>[AppColors.primary, AppColors.secondary]),
                ),
          ),
        ),
        body: lotteryModel == null
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 2), () {
                    getSlider();
                    getLottery();
                    getResult();
                  });
                },
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text('Welcome To Punjab Lottery',style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black
                          //   ),),
                          // ),
                          // Stack(
                          //   children: [
                          //     CircleAvatar(),
                          //     Positioned(
                          //       top: 10,
                          //         left: 0,
                          //         right: 0,
                          //         bottom: 0,
                          //         child: Icon(Icons.add,color: AppColors.red,)),
                          //
                          //   ],
                          // ),
                          userId == '71'
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getSliderModel == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : CarouselSlider(
                                            items: getSliderModel!.sliderdata!
                                                .map(
                                                  (item) => Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Container(
                                                                height: 200,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          "${item.sliderImage}",
                                                                        ),
                                                                        fit: BoxFit.fill)),
                                                              )),
                                                        ),
                                                      ]),
                                                )
                                                .toList(),
                                            carouselController:
                                                carouselController,
                                            options: CarouselOptions(
                                                height: 150,
                                                scrollPhysics:
                                                    const BouncingScrollPhysics(),
                                                autoPlay: true,
                                                aspectRatio: 1.8,
                                                viewportFraction: 1,
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    _currentPost = index;
                                                  });
                                                })),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: _buildDots(),
                                    ),
                                    // sliderPointers (items , currentIndex),
                                  ],
                                ),

                          // getCatListView(controller),
                          //sliderPointers (controller.catList , controller.catCurrentIndex.value ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: AppColors.greyColor,
                                height: 160,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      userId == '71'
                                          ? SizedBox()
                                          : const Text(
                                              "Winner List",
                                              style: TextStyle(
                                                  color: AppColors.fntClr,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      userId == '71'
                                          ? SizedBox()
                                          : const Text(
                                              "Today's Draw List.",
                                              style: TextStyle(
                                                  color: AppColors.fntClr,
                                                  fontSize: 12),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      userId == '71'
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                // Get.toNamed(winnerScreen);
                                              },
                                              child: getResultModel?.data
                                                          ?.lotteries?.length ==
                                                      0
                                                  ? Center(
                                                      child: Text(
                                                          "No winner list!!"))
                                                  : Container(
                                                      height: 80,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              getResultModel
                                                                      ?.data
                                                                      ?.lotteries
                                                                      ?.length ??
                                                                  0,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            WinnerDetailsScreen(
                                                                              gId: getResultModel!.data!.lotteries![index].gameId,
                                                                            )));
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 170,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/images/homewinnerback.png"),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          6.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                  width: 90,
                                                                                  child: Text(
                                                                                    "${getResultModel!.data!.lotteries![index].gameName}",
                                                                                    style: TextStyle(color: AppColors.whit, fontSize: 14),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  )),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              Text(
                                                                                getResultModel!.data!.lotteries![index].winners!.length == 0 ? "" : "₹${getResultModel!.data!.lotteries![index].winners![0].winnerPrice}",
                                                                                style: TextStyle(color: AppColors.whit),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              Container(
                                                                                  width: 90,
                                                                                  child: Text(
                                                                                    getResultModel!.data!.lotteries![index].winners!.length == 0 ? "" : getResultModel!.data!.lotteries![index].winners![0].userName ?? "",
                                                                                    style: TextStyle(color: AppColors.whit),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: 40,
                                                                                child: Image.network(
                                                                                  "${getResultModel!.data!.lotteries![index].image}",
                                                                                  fit: BoxFit.fill,
                                                                                )),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              lotteryModel!.data!.lotteries!.length == 0
                                  ? Center(child: Text("No Data Found!!"))
                                  : userId == '71'
                                      ? Center(
                                          child: Text("No data Found"),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "${lotteryModel!.data!.name.toString()}",
                                                  style: const TextStyle(
                                                      color: AppColors.fntClr,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  // height: MediaQuery.of(context).size.height/1.1,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: lotteryModel!
                                                          .data!
                                                          .lotteries!
                                                          .length,
                                                      // itemCount:2,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            if (lotteryModel!
                                                                    .data!
                                                                    .lotteries![
                                                                        index]
                                                                    .active ==
                                                                '0') {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => WinnerScreen(
                                                                          gId: lotteryModel
                                                                              ?.data
                                                                              ?.lotteries?[index]
                                                                              .gameId)));
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Booking not yet to be start");
                                                            }

                                                            //Get.toNamed(winnerScreen,arguments:lotteryModel?.data?.lotteries?[index].gameId );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: AppColors
                                                                    .whit,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "${lotteryModel!.data!.lotteries![index].gameName}",
                                                                            style:
                                                                                TextStyle(color: AppColors.whit, fontSize: 12),
                                                                          ),
                                                                          // Text("Result: ${lotteryModel!.data!.lotteries![index].resultDate}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                          Text(
                                                                            "Result: ${DateFormat('dd MMM yyyy').format(DateTime.parse(lotteryModel!.data!.lotteries![index].resultDate ?? ""))}",
                                                                            style:
                                                                                TextStyle(color: AppColors.whit, fontSize: 12),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    height: 30,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft: Radius.circular(
                                                                                5),
                                                                            topRight: Radius.circular(
                                                                                5)),
                                                                        color: AppColors
                                                                            .secondary),
                                                                  ),

                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        top: 8),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Open: ${lotteryModel!.data!.lotteries![index].openTime}",
                                                                          style: TextStyle(
                                                                              color: AppColors.black,
                                                                              fontSize: 12),
                                                                        ),
                                                                        Text(
                                                                          "Close: ${lotteryModel!.data!.lotteries![index].closeTime}",
                                                                          style: TextStyle(
                                                                              color: AppColors.black,
                                                                              fontSize: 12),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  Text(
                                                                    "Entry Fees: ${lotteryModel!.data!.lotteries![index].ticketPrice}",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),

                                                                  // Padding(
                                                                  //   padding: const EdgeInsets.only(left: 5,right: 5),
                                                                  //   child: Row(
                                                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //     children: [
                                                                  //       Row(
                                                                  //         children: [
                                                                  //
                                                                  //           Text("Price:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //           SizedBox(width: 2,),
                                                                  //           Text("${lotteryModel!.data!.lotteries![index].ticketPrice}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //         ],
                                                                  //       ),
                                                                  //
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           SizedBox(height: 25,),
                                                                  //           Text("Open:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //           SizedBox(width: 2,),
                                                                  //           Text("${lotteryModel!.data!.lotteries![index].openTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //         ],
                                                                  //       ),
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           SizedBox(height: 25,),
                                                                  //           Text("Close:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //           SizedBox(width: 2,),
                                                                  //           Text("${lotteryModel!.data!.lotteries![index].closeTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //         ],
                                                                  //       )
                                                                  //     ],
                                                                  //   ),
                                                                  // ),
                                                                  // Padding(
                                                                  //   padding: const EdgeInsets.all(8.0),
                                                                  //   child: Row(
                                                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //     children: [
                                                                  //       Text("${lotteryModel!.data!.lotteries![index].gameName}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //       lotteryModel!.data!.lotteries![index].active == '0' ?  Text("Betting is Running Now",style: TextStyle(color: AppColors.whit,fontSize: 12),):SizedBox.shrink(),
                                                                  //       Container(
                                                                  //         height: 45,width: 50,
                                                                  //         child: ClipRRect(
                                                                  //             borderRadius: BorderRadius.circular(10),
                                                                  //             child: Image.network("${lotteryModel!.data!.lotteries![index].image}",fit: BoxFit.fill,)),
                                                                  //       ),
                                                                  //     ],
                                                                  //   ),
                                                                  // ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        // Text("Start: ${lotteryModel!.data!.lotteries![index].date}",style: TextStyle(color: AppColors.black,fontSize: 12),),
                                                                        Text(
                                                                          "Start: ${DateFormat('dd MMM yyyy').format(DateTime.parse(lotteryModel!.data!.lotteries![index].date ?? ""))}",
                                                                          style: TextStyle(
                                                                              color: AppColors.black,
                                                                              fontSize: 12),
                                                                        ),
                                                                        // Text("End: ${lotteryModel!.data!.lotteries![index].endDate}",style: TextStyle(color: AppColors.black,fontSize: 12),)
                                                                        Text(
                                                                          "End: ${DateFormat('dd MMM yyyy').format(DateTime.parse(lotteryModel!.data!.lotteries![index].endDate ?? ""))}",
                                                                          style: TextStyle(
                                                                              color: AppColors.black,
                                                                              fontSize: 12),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  // Padding(
                                                                  //   padding: const EdgeInsets.only(left: 5,right: 5),
                                                                  //   child: Row(
                                                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //     children: [
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           SizedBox(height: 25,),
                                                                  //           Text("Start:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //           SizedBox(width: 2,),
                                                                  //           Text("${lotteryModel!.data!.lotteries![index].date}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //         ],
                                                                  //       ),
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           SizedBox(height: 25,),
                                                                  //           Text("End:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //           SizedBox(width: 2,),
                                                                  //           Text("${lotteryModel!.data!.lotteries![index].endDate}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //         ],
                                                                  //       ),
                                                                  //       // Row(
                                                                  //       //   children: [
                                                                  //       //
                                                                  //       //     Text("Result:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                  //       //     SizedBox(width: 2,),
                                                                  //       //     Text("${lotteryModel!.data!.lotteries![index].resultDate}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                                  //       //   ],
                                                                  //       // ),
                                                                  //     ],
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        ],
                      );
                    }),
              ),
      ),
    );
  }

  Widget sliderPointers(List doteList, int currentIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: doteList.asMap().entries.map((entry) {
          return GestureDetector(
            // onTap:()=> controller.carouselController.animateToPage(entry.key),
            child: Container(
              width: currentIndex == entry.key ? 8 : 8,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentIndex == entry.key
                      ? AppColors.primary
                      : Colors.black),
            ),
          );
        }).toList());
  }

  int _currentPost = 0;
  _buildDots() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i
                  ? AppColors.profileColor
                  : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }

  GetSliderModel? getSliderModel;
  Future<void> getSlider() async {
    // isLoading.value = true;
    var param = {'app_key': ""};
    print("anjali parameter___________${param}${getSliderAPI}");
    apiBaseHelper.postAPICall(getSliderAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status == true) {
        getSliderModel = GetSliderModel.fromJson(getData);
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      //isLoading.value = false;
    });
  }

  LotteryModel? lotteryModel;
  Future<void> getLottery() async {
    apiBaseHelper.postAPICall2(getLotteryAPI).then((getData) {
      // print('--data---------${getData}');
      // print("----data222----");
      setState(() {
        lotteryModel = LotteryModel.fromJson(getData);
      });

      //isLoading.value = false;
    });
  }

  // GetResultModel? getResultModel;
  // Future<void> getResult() async {
  //   apiBaseHelper.postAPICall2(getResultAPI).then((getData) {
  //     setState(() {
  //       getResultModel = GetResultModel.fromJson(getData);
  //     });
  //     //isLoading.value = false;
  //   });
  // }

  GetResultModel? getResultModel;
  getResult() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://punjablottery.online/Apicontroller/getResults'));
    request.body = json.encode({
      "user_id": userId,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetResultModel.fromJson(jsonDecode(result));
      setState(() {
        getResultModel = finalResult;
      });
      print(
          "aaaaaaaaaaaaaxxsfrfxa_____________${getResultModel?.data?.lotteries?.length}");
      Fluttertoast.showToast(msg: "${finalResult.msg}");
    } else {
      print(response.reasonPhrase);
    }
  }
}
