class HolidayMasterModel {
  int? id;
  DateTime? date;
  String? description;

  HolidayMasterModel({this.id, this.date, this.description});

  HolidayMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.tryParse(json['Date'])!
        .add(const Duration(hours: 5, minutes: 30));
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Date'] = this.date;
    data['Description'] = this.description;
    return data;
  }
}
