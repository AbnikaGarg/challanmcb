class PaymentRecModel {
  PaymentRecModel({
      this.status, 
      this.message, 
      this.data,});

  PaymentRecModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentRecModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<PaymentRecModelData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PaymentRecModelData {
  PaymentRecModelData({
      this.paymentRecEntryId, 
      this.vrNo, 
      this.vrDate, 
      this.challanDate, 
      this.challanNo, 
      this.vehicleNo, 
      this.challanReason, 
      this.mobileNo, 
      this.paymode, 
      this.paymodeId, 
      this.amount, 
      this.ssTransactionId, 
      this.bankTransactionId, 
      this.paymentTag, 
      this.paymentDate, 
      this.createdUserId, 
      this.createdDate, 
      this.errorCode, 
      this.errorDesc,});

  PaymentRecModelData.fromJson(dynamic json) {
    paymentRecEntryId = json['paymentRecEntryId'];
    vrNo = json['vrNo'];
    vrDate = json['vrDate'];
    challanDate = json['challanDate'];
    challanNo = json['challanNo'];
    vehicleNo = json['vehicleNo'];
    challanReason = json['challanReason'];
    mobileNo = json['mobileNo'];
    paymode = json['paymode'];
    paymodeId = json['paymodeId'];
    amount = double.tryParse(json['amount'].toString());
    ssTransactionId = json['ssTransactionId'];
    bankTransactionId = json['bankTransactionId'];
    paymentTag = json['paymentTag'];
    paymentDate = json['paymentDate'];
    createdUserId = json['createdUserId'];
    createdDate = json['createdDate'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? paymentRecEntryId;
  int? vrNo;
  String? vrDate;
  String? challanDate;
  String? challanNo;
  String? vehicleNo;
  String? challanReason;
  String? mobileNo;
  String? paymode;
  int? paymodeId;
  double? amount;
  String? ssTransactionId;
  dynamic bankTransactionId;
  int? paymentTag;
  dynamic paymentDate;
  int? createdUserId;
  String? createdDate;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paymentRecEntryId'] = paymentRecEntryId;
    map['vrNo'] = vrNo;
    map['vrDate'] = vrDate;
    map['challanDate'] = challanDate;
    map['challanNo'] = challanNo;
    map['vehicleNo'] = vehicleNo;
    map['challanReason'] = challanReason;
    map['mobileNo'] = mobileNo;
    map['paymode'] = paymode;
    map['paymodeId'] = paymodeId;
    map['amount'] = amount;
    map['ssTransactionId'] = ssTransactionId;
    map['bankTransactionId'] = bankTransactionId;
    map['paymentTag'] = paymentTag;
    map['paymentDate'] = paymentDate;
    map['createdUserId'] = createdUserId;
    map['createdDate'] = createdDate;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}