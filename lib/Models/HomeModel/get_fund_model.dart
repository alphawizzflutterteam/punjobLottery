class GetFundModel {
  List<AddFund>? addFund;
  String? msg;
  bool? status;

  GetFundModel({this.addFund, this.msg, this.status});

  GetFundModel.fromJson(Map<String, dynamic> json) {
    if (json['add_fund'] != null) {
      addFund = <AddFund>[];
      json['add_fund'].forEach((v) {
        addFund!.add(new AddFund.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addFund != null) {
      data['add_fund'] = this.addFund!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class AddFund {
  String? fundRequestId;
  String? userId;
  String? requestAmount;
  String? requestNumber;
  String? requestStatus;
  String? fundPaymentReceipt;
  String? insertDate;
  String? status;
  String? userName;
  String? name;

  AddFund(
      {this.fundRequestId,
        this.userId,
        this.requestAmount,
        this.requestNumber,
        this.requestStatus,
        this.fundPaymentReceipt,
        this.insertDate,
        this.status,
        this.userName,
        this.name
      });

  AddFund.fromJson(Map<String, dynamic> json) {
    fundRequestId = json['fund_request_id'];
    userId = json['user_id'];
    requestAmount = json['request_amount'];
    requestNumber = json['request_number'];
    requestStatus = json['request_status'];
    fundPaymentReceipt = json['fund_payment_receipt'];
    insertDate = json['insert_date'];
    status = json['status'];
    userName = json['user_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fund_request_id'] = this.fundRequestId;
    data['user_id'] = this.userId;
    data['request_amount'] = this.requestAmount;
    data['request_number'] = this.requestNumber;
    data['request_status'] = this.requestStatus;
    data['fund_payment_receipt'] = this.fundPaymentReceipt;
    data['insert_date'] = this.insertDate;
    data['status'] = this.status;
    data['user_name'] = this.userName;
    data['name'] = this.name;
    return data;
  }
}