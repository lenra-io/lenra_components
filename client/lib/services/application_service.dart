import 'package:flutter/material.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationService {
  static Future<LenraApplicationInfo> getAppInfoByName(String name) {
    return getAppList().then((appList) => appList
        .firstWhere((LenraApplicationInfo appInfo) => appInfo.name == name));
  }

  static Future<List<LenraApplicationInfo>> getAppList() async {
    final response = await http.get('http://localhost:4000/api/apps');
    final icon = [
      Icons.access_alarm,
      Icons.ac_unit,
      Icons.account_balance,
      Icons.account_box,
      Icons.announcement,
      Icons.backup,
      Icons.eco,
      Icons.tablet_android,
      Icons.save
    ];

    if (response.statusCode == 200) {
      List<dynamic> responseDecoded = json.decode(response.body);
      int i = 0;
      return responseDecoded.map((dynamic data) {
        int index = (i * 2 + 1);
        i++;
        return LenraApplicationInfo(
            name: data["name"],
            icon: icon[index % icon.length],
            color: Colors.primaries[index % Colors.primaries.length]);
      }).toList();
    } else {
      //replace by logger
      throw Exception('Erreur de chargement');
    }
  }
}
