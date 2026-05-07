import 'package:json_annotation/json_annotation.dart';

part 'mutual_fund.g.dart';

// {"schemeCode":100027,
// "schemeName":"Grindlays Super Saver Income Fund-GSSIF-Half Yearly Dividend",
// "isinGrowth":null,"isinDivReinvestment":null},
// {"schemeCode":100028,
// "schemeName":"Grindlays Super Saver Income Fund-GSSIF-Quaterly Dividend",
// "isinGrowth":null,"isinDivReinvestment":null}
// --- flutter pub run build_runner build

@JsonSerializable(explicitToJson: true)
class MutualFund {
  final int? schemeCode;
  final String? schemeName;
  @JsonKey(name: "isinGrowth")
  final String? isInGrowth;
  @JsonKey(name: "isinDivReinvestment")
  final String? isInDivReinvestment;

  MutualFund({
    required this.schemeCode,
    required this.schemeName,
    this.isInGrowth,
    this.isInDivReinvestment,
  });

  factory MutualFund.fromJson(Map<String, dynamic> json) =>
      _$MutualFundFromJson(json);

  Map<String, dynamic> toJson() => _$MutualFundToJson(this);
}
