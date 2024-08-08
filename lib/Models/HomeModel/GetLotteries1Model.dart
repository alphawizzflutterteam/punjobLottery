// import 'dart:core';
//
// class GetLotteries1Model {
//   Data? data;
//
//   GetLotteries1Model({this.data});
//
//   GetLotteries1Model.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
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
//   List<New>? new;
//
//   Data({this.name, this.lotteries, this.new});
//
// Data.fromJson(Map<String, dynamic> json) {
// name = json['name'];
// if (json['lotteries'] != null) {
// lotteries = <Lotteries>[];
// json['lotteries'].forEach((v) { lotteries!.add(new Lotteries.fromJson(v)); });
// }
// if (json['new'] != null) {
// new = <New>[];
// json['new'].forEach((v) { new!.add(new New.fromJson(v)); });
// }
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['name'] = this.name;
//   if (this.lotteries != null) {
//     data['lotteries'] = this.lotteries!.map((v) => v.toJson()).toList();
//   }
//   if (this.new != null) {
//     data['new'] = this.new!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
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
//   String? userCount;
//   String? lotteryCount;
//   String? lotteryNo;
//   String? active;
//
//   Lotteries({this.gameId, this.gameName, this.gameNameHindi, this.openTime, this.openTimeSort, this.closeTime, this.status, this.resultStatus, this.marketStatus, this.marketOffDay, this.date, this.endDate, this.resultDate, this.resultTime, this.ticketPrice, this.image, this.lotteryNumber, this.userCount, this.lotteryCount, this.lotteryNo, this.active});
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
//     userCount = json['user_count'];
//     lotteryCount = json['lottery_count'];
//     lotteryNo = json['lottery_no'];
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
//     data['user_count'] = this.userCount;
//     data['lottery_count'] = this.lotteryCount;
//     data['lottery_no'] = this.lotteryNo;
//     data['active'] = this.active;
//     return data;
//   }
// }
//
// class New {
//   String? id;
//   String? gameId;
//   String? lotteryNumber;
//   String? userId;
//   String? bookStatus;
//   String? purchaseStatus;
//
//   New({this.id, this.gameId, this.lotteryNumber, this.userId, this.bookStatus, this.purchaseStatus});
//
//   New.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     gameId = json['game_id'];
//     lotteryNumber = json['lottery_number'];
//     userId = json['user_id'];
//     bookStatus = json['book_status'];
//     purchaseStatus = json['purchase_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['game_id'] = this.gameId;
//     data['lottery_number'] = this.lotteryNumber;
//     data['user_id'] = this.userId;
//     data['book_status'] = this.bookStatus;
//     data['purchase_status'] = this.purchaseStatus;
//     return data;
//   }
// }