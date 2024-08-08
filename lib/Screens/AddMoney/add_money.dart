import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/Get_transaction_model.dart';
import '../../Models/HomeModel/get_fund_model.dart';
import '../../Services/api_services/apiConstants.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    referCode();
  }

  Future<bool> showExitPopup1() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context, 1);
                },
                child: Text('Camera'),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery, context, 1);
                },
                child: Text('Gallery'),
              ),
            ],
          )),
    );
  }

  File? imageFile;

  void requestPermission(BuildContext context, int i) async {
    print("okay");
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.mediaLibrary,
      Permission.storage,
    ].request();
    if (statuses[Permission.photos] == PermissionStatus.granted &&
        statuses[Permission.mediaLibrary] == PermissionStatus.granted) {
      getImage(ImageSource.gallery, context, 1);
    } else {
      getImageCmera(ImageSource.camera, context, 1);
    }
  }

  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      imageFile = File(image!.path);
    });

    Navigator.pop(context);
  }

  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      imageFile = File(image!.path);
    });
    Navigator.pop(context);
  }

  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    setState(() {
      if (i == 1) {
        imageFile = File(croppedFile!.path.toString());
      }
    });
  }

  String? userId;
  referCode() async {
    userId = await SharedPre.getStringValue('userId');
  }

  bool isEditProfile = false;
  addRequest() async {
    setState(() {
      isEditProfile = true;
    });
    var headers = {
      'Cookie': 'ci_session=df5385d665217dba30014022ebc9598ab69bb28d'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://punjablottery.online/apicontroller/add_fund'));
    request.fields.addAll({
      'amount': transactionController.text,
      'user_id': userId.toString(),
      'name': nameCtr.text
    });
    print('____request.fields______${request.fields}_________');
    if (imageFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('image', imageFile?.path ?? ''));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['msg']}");
      setState(() {
        isEditProfile = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        isEditProfile = false;
      });
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
          "Add Cash",
          style: TextStyle(fontSize: 17, color: AppColors.whit),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10),
            ),
            color: AppColors.secondary,
            // gradient: RadialGradient(
            //     center: Alignment.center,
            //     radius: 1.1,
            //     colors: <Color>[AppColors.primary, AppColors.secondary]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            tabTop(),
            _currentIndex == 1 ? addcash() : addcashRequest()
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Container(
      //           height: 400,
      //           width: MediaQuery.of(context).size.width / 1.1,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.white,
      //           ),
      //           child: Image.asset(
      //             "assets/images/scanner.png",
      //             height: 100,
      //             width: 100,
      //           ),
      //         ),
      //         Center(
      //           child: InkWell(
      //             onTap: () {
      //               downloadInGallery();
      //             },
      //             child: Container(
      //               decoration: BoxDecoration(color: Colors.amber),
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //               child: Text('Download'),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 0,
      //         ),
      //         Card(
      //           elevation: 5,
      //           child: Container(
      //             width: 320,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(7),
      //               color: Colors.white,
      //             ),
      //             child: TextFormField(
      //               keyboardType: TextInputType.number,
      //               controller: transactionController,
      //               maxLength: 30,
      //               decoration: const InputDecoration(
      //                   counterText: "",
      //                   contentPadding: EdgeInsets.all(8),
      //                   border: InputBorder.none,
      //                   hintStyle: TextStyle(fontWeight: FontWeight.normal),
      //                   hintText: 'Enter Amount'),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'Please Enter Amount';
      //                 }
      //                 return null;
      //               },
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Card(
      //           elevation: 5,
      //           child: Container(
      //             width: 320,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(7),
      //               color: Colors.white,
      //             ),
      //             child: TextFormField(
      //               keyboardType: TextInputType.text,
      //               controller: nameCtr,
      //               // maxLength: 30,
      //               decoration: const InputDecoration(
      //                   counterText: "",
      //                   contentPadding: EdgeInsets.all(8),
      //                   border: InputBorder.none,
      //                   hintStyle: TextStyle(fontWeight: FontWeight.normal),
      //                   hintText: 'Enter Name'),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'Please Enter Name';
      //                 }
      //                 return null;
      //               },
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Card(
      //           elevation: 5,
      //           child: Container(
      //             height: 150,
      //             width: MediaQuery.of(context).size.width / 1.1,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.white,
      //             ),
      //             child: InkWell(
      //               onTap: () {
      //                 showExitPopup1();
      //                 // showExitPopup(isFromProfile ?? false);
      //               },
      //               child: imageFile == null
      //                   ? Container(
      //                       height: 30,
      //                       width: 30,
      //                       decoration: BoxDecoration(
      //                           color: AppColors.whit,
      //                           borderRadius: BorderRadius.circular(50)),
      //                       child: const Padding(
      //                         padding: EdgeInsets.only(top: 40),
      //                         child: Column(
      //                           children: [
      //                             Icon(
      //                               Icons.camera_alt,
      //                               color: Colors.black,
      //                             ),
      //                             Text("Upload Screen Short"),
      //                           ],
      //                         ),
      //                       ),
      //                     )
      //                   : Image.file(imageFile ?? File(''), fit: BoxFit.fill),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             if (transactionController.text == null || transactionController.text.isEmpty) {
      //               Fluttertoast.showToast(msg: "Please Enter Amount");
      //               return;
      //             }
      //             double amount;
      //             try {
      //               amount = double.parse(transactionController.text);
      //             } catch (e) {
      //               Fluttertoast.showToast(msg: "Please Enter a Valid Number");
      //               return;
      //             }
      //
      //             if (amount <= 0 || amount < 50) {
      //               Fluttertoast.showToast(msg: "Please Enter an Amount of at Least 50");
      //               return;
      //             }
      //
      //             if (imageFile == null) {
      //               Fluttertoast.showToast(msg: "Please Select Image");
      //               return;
      //             }
      //
      //             addRequest();
      //           },
      //
      //           // onTap: () {
      //           //   if (transactionController.text == null ||
      //           //       transactionController.text == "") {
      //           //     Fluttertoast.showToast(msg: "Please Enter Amount");
      //           //     return;
      //           //   } else if (transactionController.text == "0" ||
      //           //       transactionController.text.contains('-')) {
      //           //     Fluttertoast.showToast(
      //           //         msg: "Please Enter Correct Amount");
      //           //     return;
      //           //   } else if (imageFile == null) {
      //           //     Fluttertoast.showToast(msg: "Please Select Image");
      //           //     return;
      //           //   }
      //           //   addRequest();
      //           // },
      //           child: Center(
      //             child: Container(
      //               height: 40,
      //               width: 150,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: AppColors.secondary),
      //               child: Center(
      //                 child: Text(
      //                   isEditProfile == true ? "please wait..." : "Submit",
      //                   style: const TextStyle(
      //                       fontSize: 15, color: Colors.white),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }

  int _currentIndex = 1;
  tabTop() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                  // getNewListApi(1);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? AppColors.secondary
                        : AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                height: 45,
                child: Center(
                  child: Text("Add Cash",
                      style: TextStyle(
                          color: _currentIndex == 1
                              ? AppColors.whit
                              : AppColors.fntClr,
                          fontSize: 18)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                  getFundHistoryApi();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? AppColors.secondary
                        : AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                // width: 120,
                height: 45,
                child: Center(
                  child: Text(
                    "Add Cash List",
                    style: TextStyle(
                        color: _currentIndex == 2
                            ? AppColors.whit
                            : AppColors.fntClr,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addcash() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/scanner.png",
                height: 100,
                width: 100,
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  downloadInGallery();
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.amber),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text('Download'),
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Card(
              elevation: 5,
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: transactionController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      hintText: 'Enter Amount'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Amount';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nameCtr,
                  // maxLength: 30,
                  decoration: const InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      hintText: 'Enter Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    showExitPopup1();
                    // showExitPopup(isFromProfile ?? false);
                  },
                  child: imageFile == null
                      ? Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: AppColors.whit,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                                Text("Upload Screen Short"),
                              ],
                            ),
                          ),
                        )
                      : Image.file(imageFile ?? File(''), fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (transactionController.text == null ||
                    transactionController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Amount");
                  return;
                }
                double amount;
                try {
                  amount = double.parse(transactionController.text);
                } catch (e) {
                  Fluttertoast.showToast(msg: "Please Enter a Valid Number");
                  return;
                }

                if (amount <= 0 || amount < 50) {
                  Fluttertoast.showToast(
                      msg: "Please Enter an Amount of at Least 50");
                  return;
                }

                if (imageFile == null) {
                  Fluttertoast.showToast(msg: "Please Select Image");
                  return;
                }
                addRequest();
              },
              child: Center(
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondary),
                  child: Center(
                    child: Text(
                      isEditProfile == true ? "please wait..." : "Submit",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addcashRequest() {
    return getFundModel == null
        ? Center(child: CircularProgressIndicator())
        : getFundModel!.addFund!.isEmpty
            ? Center(child: Text("No add cash List Found!!"))
            : Container(
                height: MediaQuery.of(context).size.height / 1.2,
                child: ListView.builder(
                    itemCount: getFundModel!.addFund!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getFundModel!.addFund![i].name == ""
                                        ? Text("Name")
                                        : Text(
                                            "${getFundModel!.addFund![i].name}"),
                                    getFundModel!.addFund![i].requestStatus ==
                                            '0'
                                        ? Text(
                                            'Pending',
                                            style:
                                                TextStyle(color: Colors.yellow),
                                          )
                                        : getFundModel!.addFund![i]
                                                    .requestStatus ==
                                                '1'
                                            ? Text(
                                                'Rejected',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : Text(
                                                'Accepted',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    "${getFundModel!.addFund![i].requestAmount}"),
                                SizedBox(
                                  height: 3,
                                ),
                                // Text(
                                //     "₹ ${getFundModel!.addFund![i].requestAmount}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
  }

  GetFundModel? getFundModel;

  getFundHistoryApi() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=329e84d8baf5bbe6fc18f412bda3e26574156d56'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl1/Apicontroller/apiUserAddFundHistory'));
    request.body = json.encode({"user_id": userId});
    print("FundHistory____________${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetFundModel.fromJson(json.decode(result));
      Fluttertoast.showToast(msg: "${finalResult.msg}");
      setState(() {
        getFundModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future downloadInGallery() async {
    try {
      if (await _requestPermission(Permission.storage)) {
        final ByteData data =
            await rootBundle.load('assets/images/scanner.png');

        final result =
            await ImageGallerySaver.saveImage(data.buffer.asUint8List());

        print(result);
        if (result['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image downloaded')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download image')),
          );
          return false;
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image')),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    print("++++++++++++");
    var status = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (await permission.isGranted) {
      return true;
    } else {
      return status == PermissionStatus.granted;
    }
  }
}

StateSetter? dialogState;
final _formKey = GlobalKey<FormState>();
TextEditingController amtC = TextEditingController();
TextEditingController msgC = TextEditingController();
ScrollController controller = ScrollController();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

final _formKey1 = GlobalKey<FormState>();
TextEditingController transactionController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController nameCtr = TextEditingController();
TextEditingController upiIDController = TextEditingController();
TextEditingController usernmaeCtr = TextEditingController();
TextEditingController usermobileCtr = TextEditingController();

dialogAnimate(BuildContext context, Widget dialge) {
  return showGeneralDialog(
      barrierColor: AppColors.fntClr,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // pageBuilder: null
      pageBuilder: (context, animation1, animation2) {
        return Container();
      } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
      );
}
