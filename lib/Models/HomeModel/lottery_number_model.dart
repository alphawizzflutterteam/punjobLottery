import 'dart:convert';

class LotteryNumberModel {
    final String? id;
    final String? gameId;
    final String? lotteryNumber;
    final String? userId;
    final String? bookStatus;
    final String? purchaseStatus;

    LotteryNumberModel({
        this.id,
        this.gameId,
        this.lotteryNumber,
        this.userId,
        this.bookStatus,
        this.purchaseStatus,
    });

    factory LotteryNumberModel.fromRawJson(String str) => LotteryNumberModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LotteryNumberModel.fromJson(Map<String, dynamic> json) => LotteryNumberModel(
        id: json["id"],
        gameId: json["game_id"],
        lotteryNumber: json["lottery_number"],
        userId: json["user_id"],
        bookStatus: json["book_status"],
        purchaseStatus: json["purchase_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "game_id": gameId,
        "lottery_number": lotteryNumber,
        "user_id": userId,
        "book_status": bookStatus,
        "purchase_status": purchaseStatus,
    };
}
