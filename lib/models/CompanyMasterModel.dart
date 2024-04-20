class CompanyMasterModel {
  int? id;
  String? symbol;
  String? exchange;
  String? companyName;
  String? lastUpdateTime;

  CompanyMasterModel(
      {this.id,
      this.symbol,
      this.exchange,
      this.companyName,
      this.lastUpdateTime});

  CompanyMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    exchange = json['exchange'];
    companyName = json['CompanyName'];
    lastUpdateTime = json['LastUpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['exchange'] = this.exchange;
    data['CompanyName'] = this.companyName;
    data['LastUpdateTime'] = this.lastUpdateTime;
    return data;
  }
}
