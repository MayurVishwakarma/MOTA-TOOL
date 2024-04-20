import 'package:intl/intl.dart';

class EquityTradeApiData {
  EquityTradeApiData(
      {required this.userId, required this.fromDate, required this.toDate});

  final String? userId;
  final DateTime? fromDate;
  final DateTime? toDate;

  factory EquityTradeApiData.fromJson(Map<String, dynamic> json) {
    return EquityTradeApiData(
        userId: json["userId"],
        fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
        toDate: DateTime.tryParse(json["toDate"] ?? ""));
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fromDate": (fromDate != null)
            ? DateFormat("yyyy-MM-dd").format(fromDate!)
            : null,
        "toDate":
            (toDate != null) ? DateFormat("yyyy-MM-dd").format(toDate!) : null
      };
}
