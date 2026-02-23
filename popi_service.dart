import 'dart:convert';
import 'package:flutter/services.dart';

class PopiService {
  static Future<List<dynamic>> loadRules() async {
    final data = await rootBundle.loadString("assets/popi_rules.json");
    return json.decode(data);
  }
}
