class IsAutoModel {
  IsAutoModel({
    this.bnIsAuto = 0,
    this.nIsAuto = 0,
    this.nfIsAuto = 0,
    this.mcIsAuto = 0,
    this.eqIsAuto = 0,
    this.bnPercent = "",
    this.nPercent = "",
    this.nfPercent = "",
    this.mcPercent = "",
    this.eqPercent = "",
    required this.loginId,
  });

  final int? bnIsAuto;
  final int? nIsAuto;
  final int? nfIsAuto;
  final int? mcIsAuto;
  final int? eqIsAuto;
  final String? bnPercent;
  final String? nPercent;
  final String? nfPercent;
  final String? mcPercent;
  final String? eqPercent;
  final String? loginId;

  factory IsAutoModel.fromJson(Map<String, dynamic> json) {
    return IsAutoModel(
      bnIsAuto: json["BNIsAuto"] ?? 0,
      nIsAuto: json["NIsAuto"] ?? 0,
      nfIsAuto: json["NFIsAuto"] ?? 0,
      mcIsAuto: json["MCIsAuto"] ?? 0,
      eqIsAuto: json["EQIsAuto"] ?? 0,
      bnPercent: json["BNPercent"] ?? "0",
      nPercent: json["NPercent"] ?? "0",
      nfPercent: json["NFPercent"] ?? "0",
      mcPercent: json["MCPercent"] ?? "0",
      eqPercent: json["EQPercent"] ?? "0",
      loginId: json["loginId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "BNIsAuto": bnIsAuto ?? 0,
        "NIsAuto": nIsAuto ?? 0,
        "NFIsAuto": nfIsAuto ?? 0,
        "MCIsAuto": mcIsAuto ?? 0,
        "EQIsAuto": eqIsAuto ?? 0,
        "BNPercent": bnPercent ?? "0",
        "NPercent": nPercent ?? "0",
        "NFPercent": nfPercent ?? "0",
        "MCPercent": mcPercent ?? "0",
        "EQPercent": eqPercent ?? "0",
        "loginId": loginId,
      };

  IsAutoModel copyWith({
    int? bnIsAuto,
    int? nIsAuto,
    int? nfIsAuto,
    int? mcIsAuto,
    int? eqIsAuto,
    String? bnPercent,
    String? nPercent,
    String? nfPercent,
    String? mcPercent,
    String? eqPercent,
    String? loginId,
  }) {
    return IsAutoModel(
      bnIsAuto: bnIsAuto ?? this.bnIsAuto,
      nIsAuto: nIsAuto ?? this.nIsAuto,
      nfIsAuto: nfIsAuto ?? this.nfIsAuto,
      mcIsAuto: mcIsAuto ?? this.mcIsAuto,
      eqIsAuto: eqIsAuto ?? this.eqIsAuto,
      bnPercent: bnPercent ?? this.bnPercent,
      nPercent: nPercent ?? this.nPercent,
      nfPercent: nfPercent ?? this.nfPercent,
      mcPercent: mcPercent ?? this.mcPercent,
      eqPercent: eqPercent ?? this.eqPercent,
      loginId: loginId ?? this.loginId,
    );
  }
}
