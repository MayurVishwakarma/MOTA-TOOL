// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeHistoryModel _$TradeHistoryModelFromJson(Map<String, dynamic> json) =>
    TradeHistoryModel(
      instrument: json['Instrument'] as String?,
      probability: json['probability'] as num?,
      buyTime: json['BUY TIME'] == null
          ? null
          : DateTime.parse(json['BUY TIME'] as String),
      sellTime: json['SELL TIME'] == null
          ? null
          : DateTime.parse(json['SELL TIME'] as String),
      qty: json['QTY'] as num?,
      reason: json['REASON'] as String?,
      stoploss: json['STOPLOSS'] as num?,
      target: json['TARGET'] as num?,
      buyPrice: json['BUY PRICE'] as num?,
      sellPrice: json['SELL PRICE'] as num?,
      buyValue: json['BUY VALUE'] as num?,
      sellValue: json['SELL VALUE'] as num?,
      profitLoss: json['PROFIT/LOSS'] as num?,
      pointsGain: json['POINTS GAIN'] as num?,
      turnover: json['TURNOVER'] as num?,
      brokerage: json['BROKERAGE'] as num?,
      stt: json['STT'] as num?,
      exchange: json['EXCHANGE'] as num?,
      gst: json['GST'] as num?,
      sebiCharges: json['SEBI CHARGES'] as num?,
      stampCharges: json['STAMP CHARGES'] as num?,
      totalCharges: json['TOTAL CHARGES'] as num?,
      netPL: json['NET P&L'] as num?,
    );

Map<String, dynamic> _$TradeHistoryModelToJson(TradeHistoryModel instance) =>
    <String, dynamic>{
      'Instrument': instance.instrument,
      'probability': instance.probability,
      'BUY TIME': instance.buyTime?.toIso8601String(),
      'SELL TIME': instance.sellTime?.toIso8601String(),
      'QTY': instance.qty,
      'REASON': instance.reason,
      'STOPLOSS': instance.stoploss,
      'TARGET': instance.target,
      'BUY PRICE': instance.buyPrice,
      'SELL PRICE': instance.sellPrice,
      'BUY VALUE': instance.buyValue,
      'SELL VALUE': instance.sellValue,
      'PROFIT/LOSS': instance.profitLoss,
      'POINTS GAIN': instance.pointsGain,
      'TURNOVER': instance.turnover,
      'BROKERAGE': instance.brokerage,
      'STT': instance.stt,
      'EXCHANGE': instance.exchange,
      'GST': instance.gst,
      'SEBI CHARGES': instance.sebiCharges,
      'STAMP CHARGES': instance.stampCharges,
      'TOTAL CHARGES': instance.totalCharges,
      'NET P&L': instance.netPL,
    };
