import 'dart:convert';

import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/HomeModel/get_profile_model.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class ManageUserStatus {
  static getProfileAndCheckUserStatus() async {
    String userId = await SharedPre.getStringValue('userId');

    if (userId == '') {
      return;
    }
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=68b65db8a6659ad0354398bd4cd6449fc10b9b7f'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl1/Apicontroller/apiGetProfile'));
    request.body = json.encode({"user_id": userId.toString()});
    print("anjali profile balance____${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      print(json.decode(result));
      var finalResult = GetProfileModel.fromJson(json.decode(result));

      if (finalResult.profile != null && finalResult.profile!.status == '0') {
        await SharedPre.clear('userId');
        await Future.delayed(const Duration(milliseconds: 500));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             const LoginScreen()));
        Get.offAllNamed(loginScreen);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
