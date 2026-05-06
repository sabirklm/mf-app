import 'package:json_annotation/json_annotation.dart';

part 'nav_history.g.dart';

@JsonSerializable(explicitToJson: true)
class NavHistory {
  final Meta? meta;
  final List<NavData>? data;

  NavHistory({
    this.meta,
    this.data,
  });

  factory NavHistory.fromJson(Map<String, dynamic> json) =>
      _$NavHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$NavHistoryToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'fund_house')
  final String? fundHouse;

  @JsonKey(name: 'scheme_type')
  final String? schemeType;

  @JsonKey(name: 'scheme_category')
  final String? schemeCategory;

  @JsonKey(name: 'scheme_code')
  final int? schemeCode;

  @JsonKey(name: 'scheme_name')
  final String? schemeName;

  @JsonKey(name: 'isin_growth')
  final String? isInGrowth;

  @JsonKey(name: 'isin_div_reinvestment')
  final String? isInDivReinvestment;

  Meta({
    this.fundHouse,
    this.schemeType,
    this.schemeCategory,
    this.schemeCode,
    this.schemeName,
    this.isInGrowth,
    this.isInDivReinvestment,
  });

  factory Meta.fromJson(Map<String, dynamic> json) =>
      _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class NavData {
  final String? date;
  final String? nav;

  NavData({
    this.date,
    this.nav,
  });

  factory NavData.fromJson(Map<String, dynamic> json) =>
      _$NavDataFromJson(json);

  Map<String, dynamic> toJson() => _$NavDataToJson(this);
}