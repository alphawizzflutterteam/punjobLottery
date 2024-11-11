class ReferEarnModel {
  String? msg;
  bool? status;
  List<Data>? data;

  ReferEarnModel({this.msg, this.status, this.data});

  ReferEarnModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? mobile;
  String? insertDate;
  String? referredBy;
  String? referralCode;

  Data(
      {this.userId,
      this.userName,
      this.mobile,
      this.insertDate,
      this.referredBy,
      this.referralCode});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    insertDate = json['insert_date'];
    referredBy = json['referred_by'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['insert_date'] = this.insertDate;
    data['referred_by'] = this.referredBy;
    data['referral_code'] = this.referralCode;
    return data;
  }
}
