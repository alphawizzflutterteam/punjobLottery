import 'dart:convert';

class NotificationModel {
    final String? id;
    final String? userId;
    final String? bidTxId;
    final String? msg;
    final DateTime? insertDate;
    final String? openResultToken;
    final String? closeResultToken;

    NotificationModel({
        this.id,
        this.userId,
        this.bidTxId,
        this.msg,
        this.insertDate,
        this.openResultToken,
        this.closeResultToken,
    });

    factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userId: json["user_id"],
        bidTxId: json["bid_tx_id"],
        msg: json["msg"],
        insertDate: json["insert_date"] == null ? null : DateTime.parse(json["insert_date"]),
        openResultToken: json["open_result_token"],
        closeResultToken: json["close_result_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bid_tx_id": bidTxId,
        "msg": msg,
        "insert_date": insertDate?.toIso8601String(),
        "open_result_token": openResultToken,
        "close_result_token": closeResultToken,
    };
}
