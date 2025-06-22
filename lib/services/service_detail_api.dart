// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/service_detail.dart';

class ServiceDetailApi {
  static Future<ServiceDetail?> getPersonalPorServicio(int serviceId) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/servicios/$serviceId/personal',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ServiceDetail.fromJson(data);
      }
    } catch (e) {
      print('Error ServiceDetailApi: $e');
    }
    return null;
  }
}
