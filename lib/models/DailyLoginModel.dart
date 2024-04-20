class DailyLoginModel {
  int? id;
  String? userId;
  String? loginId;
  String? loginDate;
  String? margin;
  String? name;
  String? broker;
  String? mobileNo;
  String? email;

  DailyLoginModel(
      {this.id,
      this.userId,
      this.loginId,
      this.loginDate,
      this.margin,
      this.name,
      this.broker,
      this.mobileNo,
      this.email});

  DailyLoginModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    loginId = json['LoginId'];
    loginDate = json['LoginDate'];
    margin = json['Margin'];
    name = json['Name'];
    broker = json['Broker'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['LoginId'] = this.loginId;
    data['LoginDate'] = this.loginDate;
    data['Margin'] = this.margin;
    data['Name'] = this.name;
    data['Broker'] = this.broker;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    return data;
  }
}
