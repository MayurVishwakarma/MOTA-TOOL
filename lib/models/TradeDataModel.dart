class TradeDataModel {
  int? id;
  String? entryTime;
  String? exitTime;
  String? instrument;
  double? entryPrice;
  double? exitPrice;
  double? pointsGain;

  TradeDataModel(
      {this.id,
      this.entryTime,
      this.exitTime,
      this.instrument,
      this.entryPrice,
      this.exitPrice,
      this.pointsGain});

  TradeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    entryTime = json['entry_time'];
    exitTime = json['exit_time'];
    instrument = json['instrument'];
    entryPrice = double.tryParse(json['EntryPrice'].toString());
    exitPrice = double.tryParse(json['ExitPrice'].toString());
    pointsGain = double.tryParse(json['PointsGain'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['entry_time'] = this.entryTime;
    data['exit_time'] = this.exitTime;
    data['instrument'] = this.instrument;
    data['EntryPrice'] = this.entryPrice;
    data['ExitPrice'] = this.exitPrice;
    data['PointsGain'] = this.pointsGain;
    return data;
  }
}
