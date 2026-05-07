// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutual_fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutualFund _$MutualFundFromJson(Map<String, dynamic> json) => MutualFund(
  schemeCode: (json['schemeCode'] as num?)?.toInt(),
  schemeName: json['schemeName'] as String?,
  isInGrowth: json['isinGrowth'] as String?,
  isInDivReinvestment: json['isinDivReinvestment'] as String?,
);

Map<String, dynamic> _$MutualFundToJson(MutualFund instance) =>
    <String, dynamic>{
      'schemeCode': instance.schemeCode,
      'schemeName': instance.schemeName,
      'isinGrowth': instance.isInGrowth,
      'isinDivReinvestment': instance.isInDivReinvestment,
    };
