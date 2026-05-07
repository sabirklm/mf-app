import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mf_ip/models/mutual_fund.dart';
import 'package:mf_ip/models/nav_history.dart';

import '../models/custom_error.dart';
import 'endpoints.dart';

class MutualFundService {
  MutualFundService();

  Future<List<MutualFund>> getMutualFunds() async {
    try {
      final response = await http.get(Uri.parse(getMf));

      if (response.statusCode != 200) {
        throw CustomException(
          "Failed to fetch mutual funds",
          code: response.statusCode,
          logs: response.body,
        );
      }

      final List data = jsonDecode(response.body);
      var temp = data.map((e) => MutualFund.fromJson(e)).toList();
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  Future<MutualFundNavHistory> getNavHistory(String id) async {
    try {
      final response = await http.get(Uri.parse("$navHistory/$id"));

      if (response.statusCode != 200) {
        throw CustomException(
          "Failed to fetch NAV history",
          code: response.statusCode,
          logs: response.body,
        );
      }
      var json = jsonDecode(response.body);
      var data = MutualFundNavHistory.fromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
