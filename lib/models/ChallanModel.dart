class ChallanModel {
  ChallanModel({
      this.status, 
      this.message, 
      this.data,});

  ChallanModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<Data>? data;

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

class Data {
  Data({
      this.vehicleToeEntryId, 
      this.vrNo, 
      this.vrDate, 
      this.vehicleCategoryId, 
      this.vehicleCategory, 
      this.challanNo, 
      this.vehicleNo, 
      this.challanReason, 
      this.challanReasonId, 
      this.amount, 
      this.image1, 
      this.image2, 
      this.imagePath, 
      this.paymentReceiveTag, 
      this.createdUserId, 
      this.createdDate, 
      this.errorCode, 
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    vehicleToeEntryId = json['vehicleToeEntryId'];
    vrNo = json['vrNo'];
    vrDate = json['vrDate'];
    vehicleCategoryId = json['vehicleCategoryId'];
    vehicleCategory = json['vehicleCategory'];
    challanNo = json['challanNo'];
    vehicleNo = json['vehicleNo'];
    challanReason = json['challanReason'];
    challanReasonId = json['challanReasonId'];
    amount = double.tryParse(json['amount'].toString());
    image1 = json['image1'];
    image2 = json['image2'];
    imagePath = json['imagePath'];
    paymentReceiveTag = json['paymentReceiveTag'];
    createdUserId = json['createdUserId'];
    createdDate = json['createdDate'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? vehicleToeEntryId;
  int? vrNo;
  String? vrDate;
  int? vehicleCategoryId;
  String? vehicleCategory;
  String? challanNo;
  String? vehicleNo;
  String? challanReason;
  int? challanReasonId;
  double? amount;
  String? image1;
  String? image2;
  String? imagePath;
  bool? paymentReceiveTag;
  int? createdUserId;
  String? createdDate;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicleToeEntryId'] = vehicleToeEntryId;
    map['vrNo'] = vrNo;
    map['vrDate'] = vrDate;
    map['vehicleCategoryId'] = vehicleCategoryId;
    map['vehicleCategory'] = vehicleCategory;
    map['challanNo'] = challanNo;
    map['vehicleNo'] = vehicleNo;
    map['challanReason'] = challanReason;
    map['challanReasonId'] = challanReasonId;
    map['amount'] = amount;
    map['image1'] = image1;
    map['image2'] = image2;
    map['imagePath'] = imagePath;
    map['paymentReceiveTag'] = paymentReceiveTag;
    map['createdUserId'] = createdUserId;
    map['createdDate'] = createdDate;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}