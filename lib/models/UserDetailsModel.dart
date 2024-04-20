class UserDetailsModel {
  int? userId;
  String? broker;
  String? name;
  String? investLimit;
  String? mobileNo;
  String? email;
  String? loginId;
  String? lastLogin;
  String? deviceId;
  String? subscriptionDate;
  int? isAuto;
  int? islocal;
  int? isNiftyOn;
  int? isFinNiftyOn;
  int? isMidCapOn;
  int? isEquityOn;
  double? margin;
  String? bANKNIFTY;
  String? nIFTY;
  String? nIFTYFIN;
  String? mIDCAP;
  String? eQUITY;
  String? firstName;
  String? message;

  UserDetailsModel(
      {this.userId,
      this.broker,
      this.name,
      this.investLimit,
      this.mobileNo,
      this.email,
      this.loginId,
      this.lastLogin,
      this.deviceId,
      this.subscriptionDate,
      this.isAuto,
      this.islocal,
      this.isNiftyOn,
      this.isFinNiftyOn,
      this.isMidCapOn,
      this.isEquityOn,
      this.margin,
      this.bANKNIFTY,
      this.nIFTY,
      this.nIFTYFIN,
      this.mIDCAP,
      this.eQUITY,
      this.firstName,
      this.message});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    broker = json['Broker'];
    name = json['Name'];
    investLimit = json['InvestLimit'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    loginId = json['LoginId'];
    lastLogin = json['LastLogin'];
    deviceId = json['DeviceId'];
    subscriptionDate = json['SubscriptionDate'];
    isAuto = json['isAuto'];
    islocal = json['islocal'];
    isNiftyOn = json['isNiftyOn'];
    isFinNiftyOn = json['isFinNiftyOn'];
    isMidCapOn = json['isMidCapOn'];
    isEquityOn = json['isEquityOn'];
    margin = double.tryParse(json['margin'].toString());
    bANKNIFTY = json['BANKNIFTY'];
    nIFTY = json['NIFTY'];
    nIFTYFIN = json['NIFTYFIN'];
    mIDCAP = json['MIDCAP'];
    eQUITY = json['EQUITY'];
    firstName = json['FirstName'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['Broker'] = this.broker;
    data['Name'] = this.name;
    data['InvestLimit'] = this.investLimit;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    data['LoginId'] = this.loginId;
    data['LastLogin'] = this.lastLogin;
    data['DeviceId'] = this.deviceId;
    data['SubscriptionDate'] = this.subscriptionDate;
    data['isAuto'] = this.isAuto;
    data['islocal'] = this.islocal;
    data['isNiftyOn'] = this.isNiftyOn;
    data['isFinNiftyOn'] = this.isFinNiftyOn;
    data['isMidCapOn'] = this.isMidCapOn;
    data['isEquityOn'] = this.isEquityOn;
    data['margin'] = this.margin;
    data['BANKNIFTY'] = this.bANKNIFTY;
    data['NIFTY'] = this.nIFTY;
    data['NIFTYFIN'] = this.nIFTYFIN;
    data['MIDCAP'] = this.mIDCAP;
    data['EQUITY'] = this.eQUITY;
    data['FirstName'] = this.firstName;
    data['Message'] = this.message;
    return data;
  }
}
