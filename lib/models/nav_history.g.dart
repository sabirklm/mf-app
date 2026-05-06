// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavHistory _$NavHistoryFromJson(Map<String, dynamic> json) => NavHistory(
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => NavData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NavHistoryToJson(NavHistory instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  fundHouse: json['fund_house'] as String?,
  schemeType: json['scheme_type'] as String?,
  schemeCategory: json['scheme_category'] as String?,
  schemeCode: (json['scheme_code'] as num?)?.toInt(),
  schemeName: json['scheme_name'] as String?,
  isInGrowth: json['isin_growth'] as String?,
  isInDivReinvestment: json['isin_div_reinvestment'] as String?,
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'fund_house': instance.fundHouse,
  'scheme_type': instance.schemeType,
  'scheme_category': instance.schemeCategory,
  'scheme_code': instance.schemeCode,
  'scheme_name': instance.schemeName,
  'isin_growth': instance.isInGrowth,
  'isin_div_reinvestment': instance.isInDivReinvestment,
};

NavData _$NavDataFromJson(Map<String, dynamic> json) =>
    NavData(date: json['date'] as String?, nav: json['nav'] as String?);

Map<String, dynamic> _$NavDataToJson(NavData instance) => <String, dynamic>{
  'date': instance.date,
  'nav': instance.nav,
};
