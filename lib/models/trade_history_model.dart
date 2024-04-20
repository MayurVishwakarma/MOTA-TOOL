import 'package:json_annotation/json_annotation.dart';

part 'trade_history_model.g.dart';

@JsonSerializable()
class TradeHistoryModel {
  TradeHistoryModel({
    this.instrument,
    this.probability,
    this.buyTime,
    this.sellTime,
    this.qty,
    this.reason,
    this.stoploss,
    this.target,
    this.buyPrice,
    this.sellPrice,
    this.buyValue,
    this.sellValue,
    this.profitLoss,
    this.pointsGain,
    this.turnover,
    this.brokerage,
    this.stt,
    this.exchange,
    this.gst,
    this.sebiCharges,
    this.stampCharges,
    this.totalCharges,
    this.netPL,
  });

  @JsonKey(name: 'Instrument')
  final String? instrument;
  final num? probability;

  @JsonKey(name: 'BUY TIME')
  final DateTime? buyTime;

  @JsonKey(name: 'SELL TIME')
  final DateTime? sellTime;

  @JsonKey(name: 'QTY')
  final num? qty;

  @JsonKey(name: 'REASON')
  final String? reason;

  @JsonKey(name: 'STOPLOSS')
  final num? stoploss;

  @JsonKey(name: 'TARGET')
  final num? target;

  @JsonKey(name: 'BUY PRICE')
  final num? buyPrice;

  @JsonKey(name: 'SELL PRICE')
  final num? sellPrice;

  @JsonKey(name: 'BUY VALUE')
  final num? buyValue;

  @JsonKey(name: 'SELL VALUE')
  final num? sellValue;

  @JsonKey(name: 'PROFIT/LOSS')
  final num? profitLoss;

  @JsonKey(name: "POINTS GAIN")
  final num? pointsGain;

  @JsonKey(name: 'TURNOVER')
  final num? turnover;

  @JsonKey(name: 'BROKERAGE')
  final num? brokerage;

  @JsonKey(name: 'STT')
  final num? stt;

  @JsonKey(name: 'EXCHANGE')
  final num? exchange;

  @JsonKey(name: 'GST')
  final num? gst;

  @JsonKey(name: 'SEBI CHARGES')
  final num? sebiCharges;

  @JsonKey(name: 'STAMP CHARGES')
  final num? stampCharges;

  @JsonKey(name: 'TOTAL CHARGES')
  final num? totalCharges;

  @JsonKey(name: 'NET P&L')
  final num? netPL;

  TradeHistoryModel copyWith({
    String? instrument,
    num? probability,
    DateTime? buyTime,
    DateTime? sellTime,
    num? qty,
    String? reason,
    num? stoploss,
    num? target,
    num? buyPrice,
    num? sellPrice,
    num? buyValue,
    num? sellValue,
    num? profitLoss,
    num? pointsGain,
    num? turnover,
    num? brokerage,
    num? stt,
    num? exchange,
    num? gst,
    num? sebiCharges,
    num? stampCharges,
    num? totalCharges,
    num? netPL,
  }) {
    return TradeHistoryModel(
      instrument: instrument ?? this.instrument,
      probability: probability ?? this.probability,
      buyTime: buyTime ?? this.buyTime,
      sellTime: sellTime ?? this.sellTime,
      qty: qty ?? this.qty,
      reason: reason ?? this.reason,
      stoploss: stoploss ?? this.stoploss,
      target: target ?? this.target,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      buyValue: buyValue ?? this.buyValue,
      sellValue: sellValue ?? this.sellValue,
      profitLoss: profitLoss ?? this.profitLoss,
      pointsGain: pointsGain ?? this.pointsGain,
      turnover: turnover ?? this.turnover,
      brokerage: brokerage ?? this.brokerage,
      stt: stt ?? this.stt,
      exchange: exchange ?? this.exchange,
      gst: gst ?? this.gst,
      sebiCharges: sebiCharges ?? this.sebiCharges,
      stampCharges: stampCharges ?? this.stampCharges,
      totalCharges: totalCharges ?? this.totalCharges,
      netPL: netPL ?? this.netPL,
    );
  }

  factory TradeHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$TradeHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TradeHistoryModelToJson(this);
}
