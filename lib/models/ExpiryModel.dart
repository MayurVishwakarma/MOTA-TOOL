class ExpirydateMasterModel {
  int? id;
  String? date;
  String? instrument;

  ExpirydateMasterModel({this.id, this.date, this.instrument});

  ExpirydateMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    instrument = json['Instrument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Date'] = this.date;
    data['Instrument'] = this.instrument;
    return data;
  }
}
