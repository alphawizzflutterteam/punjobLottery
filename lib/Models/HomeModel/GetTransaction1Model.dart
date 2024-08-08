class GetTransaction1Model {
  List<WalletTransaction>? walletTransaction;
  String? msg;
  bool? status;

  GetTransaction1Model({this.walletTransaction, this.msg, this.status});

  GetTransaction1Model.fromJson(Map<String, dynamic> json) {
    if (json['wallet_transaction'] != null) {
      walletTransaction = <WalletTransaction>[];
      json['wallet_transaction'].forEach((v) {
        walletTransaction!.add(new WalletTransaction.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.walletTransaction != null) {
      data['wallet_transaction'] =
          this.walletTransaction!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class WalletTransaction {
  String? transactionId;
  String? userId;
  String? amount;
  String? transactionType;
  String? transactionNote;
  String? transferNote;
  String? amountStatus;
  String? insertDate;
  String? txRequestNumber;
  String? txnId;
  String? txnRef;
  String? openResultToken;
  String? closeResultToken;
  String? bidTxId;

  WalletTransaction(
      {this.transactionId,
        this.userId,
        this.amount,
        this.transactionType,
        this.transactionNote,
        this.transferNote,
        this.amountStatus,
        this.insertDate,
        this.txRequestNumber,
        this.txnId,
        this.txnRef,
        this.openResultToken,
        this.closeResultToken,
        this.bidTxId});

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    transactionNote = json['transaction_note'];
    transferNote = json['transfer_note'];
    amountStatus = json['amount_status'];
    insertDate = json['insert_date'];
    txRequestNumber = json['tx_request_number'];
    txnId = json['txn_id'];
    txnRef = json['txn_ref'];
    openResultToken = json['open_result_token'];
    closeResultToken = json['close_result_token'];
    bidTxId = json['bid_tx_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['transaction_type'] = this.transactionType;
    data['transaction_note'] = this.transactionNote;
    data['transfer_note'] = this.transferNote;
    data['amount_status'] = this.amountStatus;
    data['insert_date'] = this.insertDate;
    data['tx_request_number'] = this.txRequestNumber;
    data['txn_id'] = this.txnId;
    data['txn_ref'] = this.txnRef;
    data['open_result_token'] = this.openResultToken;
    data['close_result_token'] = this.closeResultToken;
    data['bid_tx_id'] = this.bidTxId;
    return data;
  }
}