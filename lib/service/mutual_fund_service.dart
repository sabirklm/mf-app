import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mf_ip/models/mutual_fund.dart';

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

  Future<List<dynamic>> getNavHistory(String id) async {
    try {
      final response = await http.get(Uri.parse("$getNavHistory$id"));

      if (response.statusCode != 200) {
        throw CustomException(
          "Failed to fetch NAV history",
          code: response.statusCode,
          logs: response.body,
        );
      }

      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
