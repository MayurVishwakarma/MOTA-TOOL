class LotSizeMasterModel {
  int? id;
  String? instrument;
  String? qty;
  String? maxQty;

  LotSizeMasterModel({this.id, this.instrument, this.qty, this.maxQty});

  LotSizeMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instrument = json['Instrument'];
    qty = json['Qty'];
    maxQty = json['MaxQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Instrument'] = this.instrument;
    data['Qty'] = this.qty;
    data['MaxQty'] = this.maxQty;
    return data;
  }
}
