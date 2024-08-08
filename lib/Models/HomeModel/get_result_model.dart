
// class GetResultModel {
//   String? msg;
//   Data? data;
//
//   GetResultModel({this.msg, this.data});
//
//   GetResultModel.fromJson(Map<String, dynamic> json) {
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? name;
//   List<Lotteries>? lotteries;
//
//   Data({this.name, this.lotteries});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if (json['lotteries'] != null) {
//       lotteries = <Lotteries>[];
//       json['lotteries'].forEach((v) {
//         lotteries!.add(new Lotteries.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     if (this.lotteries != null) {
//       data['lotteries'] = this.lotteries!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Lotteries {
//   String? gameId;
//   String? gameName;
//   String? gameNameHindi;
//   String? openTime;
//   String? openTimeSort;
//   String? closeTime;
//   String? status;
//   String? resultStatus;
//   String? marketStatus;
//   String? marketOffDay;
//   String? date;
//   String? endDate;
//   String? resultDate;
//   String? resultTime;
//   String? ticketPrice;
//   String? image;
//   String? lotteryNumber;
//   List<Winners>? winners;
//   String? userCount;
//   String? active;
//
//   Lotteries(
//       {this.gameId,
//         this.gameName,
//         this.gameNameHindi,
//         this.openTime,
//         this.openTimeSort,
//         this.closeTime,
//         this.status,
//         this.resultStatus,
//         this.marketStatus,
//         this.marketOffDay,
//         this.date,
//         this.endDate,
//         this.resultDate,
//         this.resultTime,
//         this.ticketPrice,
//         this.image,
//         this.lotteryNumber,
//         this.winners,
//         this.userCount,
//         this.active});
//
//   Lotteries.fromJson(Map<String, dynamic> json) {
//     gameId = json['game_id'];
//     gameName = json['game_name'];
//     gameNameHindi = json['game_name_hindi'];
//     openTime = json['open_time'];
//     openTimeSort = json['open_time_sort'];
//     closeTime = json['close_time'];
//     status = json['status'];
//     resultStatus = json['result_status'];
//     marketStatus = json['market_status'];
//     marketOffDay = json['market_off_day'];
//     date = json['date'];
//     endDate = json['end_date'];
//     resultDate = json['result_date'];
//     resultTime = json['result_time'];
//     ticketPrice = json['ticket_price'];
//     image = json['image'];
//     lotteryNumber = json['lottery_number'];
//     if (json['winners'] != null) {
//       winners = <Winners>[];
//       json['winners'].forEach((v) {
//         winners!.add(new Winners.fromJson(v));
//       });
//     }
//     userCount = json['user_count'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['game_id'] = this.gameId;
//     data['game_name'] = this.gameName;
//     data['game_name_hindi'] = this.gameNameHindi;
//     data['open_time'] = this.openTime;
//     data['open_time_sort'] = this.openTimeSort;
//     data['close_time'] = this.closeTime;
//     data['status'] = this.status;
//     data['result_status'] = this.resultStatus;
//     data['market_status'] = this.marketStatus;
//     data['market_off_day'] = this.marketOffDay;
//     data['date'] = this.date;
//     data['end_date'] = this.endDate;
//     data['result_date'] = this.resultDate;
//     data['result_time'] = this.resultTime;
//     data['ticket_price'] = this.ticketPrice;
//     data['image'] = this.image;
//     data['lottery_number'] = this.lotteryNumber;
//     if (this.winners != null) {
//       data['winners'] = this.winners!.map((v) => v.toJson()).toList();
//     }
//     data['user_count'] = this.userCount;
//     data['active'] = this.active;
//     return data;
//   }
// }
//
// class Winners {
//   String? id;
//   String? gameId;
//   String? winnerPrice;
//   String? winningPosition;
//   String? lotteryNo;
//   String? lotteryNoId;
//   String? lotteryNumber;
//   String? userId;
//   String? bookStatus;
//   String? purchaseStatus;
//   String? userName;
//   String? email;
//   Null? dob;
//   String? mobile;
//   String? password;
//   String? apiKey;
//   String? referralCode;
//   String? referredBy;
//   String? securityPin;
//   String? image;
//   Null? address;
//   String? walletBalance;
//   String? holdAmount;
//   String? lastUpdate;
//   String? insertDate;
//   String? status;
//   String? verified;
//   String? bettingStatus;
//   String? notificationStatus;
//   String? transferPointStatus;
//
//   Winners(
//       {this.id,
//         this.gameId,
//         this.winnerPrice,
//         this.winningPosition,
//         this.lotteryNo,
//         this.lotteryNoId,
//         this.lotteryNumber,
//         this.userId,
//         this.bookStatus,
//         this.purchaseStatus,
//         this.userName,
//         this.email,
//         this.dob,
//         this.mobile,
//         this.password,
//         this.apiKey,
//         this.referralCode,
//         this.referredBy,
//         this.securityPin,
//         this.image,
//         this.address,
//         this.walletBalance,
//         this.holdAmount,
//         this.lastUpdate,
//         this.insertDate,
//         this.status,
//         this.verified,
//         this.bettingStatus,
//         this.notificationStatus,
//         this.transferPointStatus});
//
//   Winners.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     gameId = json['game_id'];
//     winnerPrice = json['winner_price'];
//     winningPosition = json['winning_position'];
//     lotteryNo = json['lottery_no'];
//     lotteryNoId = json['lottery_no_id'];
//     lotteryNumber = json['lottery_number'];
//     userId = json['user_id'];
//     bookStatus = json['book_status'];
//     purchaseStatus = json['purchase_status'];
//     userName = json['user_name'];
//     email = json['email'];
//     dob = json['dob'];
//     mobile = json['mobile'];
//     password = json['password'];
//     apiKey = json['api_key'];
//     referralCode = json['referral_code'];
//     referredBy = json['referred_by'];
//     securityPin = json['security_pin'];
//     image = json['image'];
//     address = json['address'];
//     walletBalance = json['wallet_balance'];
//     holdAmount = json['hold_amount'];
//     lastUpdate = json['last_update'];
//     insertDate = json['insert_date'];
//     status = json['status'];
//     verified = json['verified'];
//     bettingStatus = json['betting_status'];
//     notificationStatus = json['notification_status'];
//     transferPointStatus = json['transfer_point_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['game_id'] = this.gameId;
//     data['winner_price'] = this.winnerPrice;
//     data['winning_position'] = this.winningPosition;
//     data['lottery_no'] = this.lotteryNo;
//     data['lottery_no_id'] = this.lotteryNoId;
//     data['lottery_number'] = this.lotteryNumber;
//     data['user_id'] = this.userId;
//     data['book_status'] = this.bookStatus;
//     data['purchase_status'] = this.purchaseStatus;
//     data['user_name'] = this.userName;
//     data['email'] = this.email;
//     data['dob'] = this.dob;
//     data['mobile'] = this.mobile;
//     data['password'] = this.password;
//     data['api_key'] = this.apiKey;
//     data['referral_code'] = this.referralCode;
//     data['referred_by'] = this.referredBy;
//     data['security_pin'] = this.securityPin;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['wallet_balance'] = this.walletBalance;
//     data['hold_amount'] = this.holdAmount;
//     data['last_update'] = this.lastUpdate;
//     data['insert_date'] = this.insertDate;
//     data['status'] = this.status;
//     data['verified'] = this.verified;
//     data['betting_status'] = this.bettingStatus;
//     data['notification_status'] = this.notificationStatus;
//     data['transfer_point_status'] = this.transferPointStatus;
//     return data;
//   }
// }

class GetResultModel {
  String? msg;
  Data? data;

  GetResultModel({this.msg, this.data});

  GetResultModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  List<Lotteries>? lotteries;

  Data({this.name, this.lotteries});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['lotteries'] != null) {
      lotteries = <Lotteries>[];
      json['lotteries'].forEach((v) {
        lotteries!.add(new Lotteries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.lotteries != null) {
      data['lotteries'] = this.lotteries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lotteries {
  String? gameId;
  String? gameName;
  String? gameNameHindi;
  String? openTime;
  String? openTimeSort;
  String? closeTime;
  String? status;
  String? resultStatus;
  String? marketStatus;
  String? marketOffDay;
  String? date;
  String? endDate;
  String? resultDate;
  String? resultTime;
  String? ticketPrice;
  String? image;
  String? lotteryNumber;
  List<Winners>? winners;
  String? userCount;
  String? active;

  Lotteries(
      {this.gameId,
        this.gameName,
        this.gameNameHindi,
        this.openTime,
        this.openTimeSort,
        this.closeTime,
        this.status,
        this.resultStatus,
        this.marketStatus,
        this.marketOffDay,
        this.date,
        this.endDate,
        this.resultDate,
        this.resultTime,
        this.ticketPrice,
        this.image,
        this.lotteryNumber,
        this.winners,
        this.userCount,
        this.active});

  Lotteries.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameName = json['game_name'];
    gameNameHindi = json['game_name_hindi'];
    openTime = json['open_time'];
    openTimeSort = json['open_time_sort'];
    closeTime = json['close_time'];
    status = json['status'];
    resultStatus = json['result_status'];
    marketStatus = json['market_status'];
    marketOffDay = json['market_off_day'];
    date = json['date'];
    endDate = json['end_date'];
    resultDate = json['result_date'];
    resultTime = json['result_time'];
    ticketPrice = json['ticket_price'];
    image = json['image'];
    lotteryNumber = json['lottery_number'];
    if (json['winners'] != null) {
      winners = <Winners>[];
      json['winners'].forEach((v) {
        winners!.add(new Winners.fromJson(v));
      });
    }
    userCount = json['user_count'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['game_name_hindi'] = this.gameNameHindi;
    data['open_time'] = this.openTime;
    data['open_time_sort'] = this.openTimeSort;
    data['close_time'] = this.closeTime;
    data['status'] = this.status;
    data['result_status'] = this.resultStatus;
    data['market_status'] = this.marketStatus;
    data['market_off_day'] = this.marketOffDay;
    data['date'] = this.date;
    data['end_date'] = this.endDate;
    data['result_date'] = this.resultDate;
    data['result_time'] = this.resultTime;
    data['ticket_price'] = this.ticketPrice;
    data['image'] = this.image;
    data['lottery_number'] = this.lotteryNumber;
    if (this.winners != null) {
      data['winners'] = this.winners!.map((v) => v.toJson()).toList();
    }
    data['user_count'] = this.userCount;
    data['active'] = this.active;
    return data;
  }
}

class Winners {
  String? id;
  String? gameId;
  String? winnerPrice;
  String? winningPosition;
  String? lotteryNo;
  String? lotteryNoId;
  String? lotteryNumber;
  String? userId;
  String? bookStatus;
  String? purchaseStatus;
  String? userName;
  String? email;
  Null? dob;
  String? mobile;
  String? password;
  String? apiKey;
  String? referralCode;
  String? referredBy;
  String? securityPin;
  String? image;
  Null? address;
  String? walletBalance;
  String? holdAmount;
  String? lastUpdate;
  String? insertDate;
  String? status;
  String? verified;
  String? bettingStatus;
  String? notificationStatus;
  String? transferPointStatus;

  Winners(
      {this.id,
        this.gameId,
        this.winnerPrice,
        this.winningPosition,
        this.lotteryNo,
        this.lotteryNoId,
        this.lotteryNumber,
        this.userId,
        this.bookStatus,
        this.purchaseStatus,
        this.userName,
        this.email,
        this.dob,
        this.mobile,
        this.password,
        this.apiKey,
        this.referralCode,
        this.referredBy,
        this.securityPin,
        this.image,
        this.address,
        this.walletBalance,
        this.holdAmount,
        this.lastUpdate,
        this.insertDate,
        this.status,
        this.verified,
        this.bettingStatus,
        this.notificationStatus,
        this.transferPointStatus});

  Winners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    winnerPrice = json['winner_price'];
    winningPosition = json['winning_position'];
    lotteryNo = json['lottery_no'];
    lotteryNoId = json['lottery_no_id'];
    lotteryNumber = json['lottery_number'];
    userId = json['user_id'];
    bookStatus = json['book_status'];
    purchaseStatus = json['purchase_status'];
    userName = json['user_name'];
    email = json['email'];
    dob = json['dob'];
    mobile = json['mobile'];
    password = json['password'];
    apiKey = json['api_key'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    securityPin = json['security_pin'];
    image = json['image'];
    address = json['address'];
    walletBalance = json['wallet_balance'];
    holdAmount = json['hold_amount'];
    lastUpdate = json['last_update'];
    insertDate = json['insert_date'];
    status = json['status'];
    verified = json['verified'];
    bettingStatus = json['betting_status'];
    notificationStatus = json['notification_status'];
    transferPointStatus = json['transfer_point_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_id'] = this.gameId;
    data['winner_price'] = this.winnerPrice;
    data['winning_position'] = this.winningPosition;
    data['lottery_no'] = this.lotteryNo;
    data['lottery_no_id'] = this.lotteryNoId;
    data['lottery_number'] = this.lotteryNumber;
    data['user_id'] = this.userId;
    data['book_status'] = this.bookStatus;
    data['purchase_status'] = this.purchaseStatus;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['api_key'] = this.apiKey;
    data['referral_code'] = this.referralCode;
    data['referred_by'] = this.referredBy;
    data['security_pin'] = this.securityPin;
    data['image'] = this.image;
    data['address'] = this.address;
    data['wallet_balance'] = this.walletBalance;
    data['hold_amount'] = this.holdAmount;
    data['last_update'] = this.lastUpdate;
    data['insert_date'] = this.insertDate;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['betting_status'] = this.bettingStatus;
    data['notification_status'] = this.notificationStatus;
    data['transfer_point_status'] = this.transferPointStatus;
    return data;
  }
}

