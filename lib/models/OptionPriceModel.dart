class OptionPriceModel {
  String? date;
  String? time;
  double? tradePrice;
  String? instrument;

  OptionPriceModel({this.date, this.time, this.tradePrice, this.instrument});

  OptionPriceModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    time = json['time'];
    tradePrice = double.tryParse(json['TradePrice'].toString());
    instrument = json['Instrument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['time'] = this.time;
    data['TradePrice'] = this.tradePrice;
    data['Instrument'] = this.instrument;
    return data;
  }
}
