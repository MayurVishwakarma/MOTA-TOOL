import 'package:intl/intl.dart';

class TradeApiData {
  TradeApiData(
      {required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.reportType});

  final String? userId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? reportType;

  factory TradeApiData.fromJson(Map<String, dynamic> json) {
    return TradeApiData(
        userId: json["userId"],
        fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
        toDate: DateTime.tryParse(json["toDate"] ?? ""),
        reportType: json['reportType']);
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fromDate": (fromDate != null)
            ? DateFormat("yyyy-MM-dd").format(fromDate!)
            : null,
        "toDate":
            (toDate != null) ? DateFormat("yyyy-MM-dd").format(toDate!) : null,
        "reportType": reportType
      };
}
