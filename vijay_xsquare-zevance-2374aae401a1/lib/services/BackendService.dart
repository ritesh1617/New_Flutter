import 'dart:async';
import 'dart:convert';
import 'package:grievance/model/Company.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BackendService {

  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    if (query.isEmpty && query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    const url = BASE_URL + '/get_company';
    // var url = Uri.https('api.datamuse.com', '/sug', {'s': query});
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constants.access_token);
    var token = "Bearer " + accessToken!;

    var response = await http.post(Uri.parse(url),
        headers: {Constants.authorization: token}, body: {Constants.q: query});
    List<Company> companyList = [];
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData['company'] != null) {
        companyList = (responseData['company'] as List)
            .map((data) => Company.fromJson(data))
            .toList();
      }

      print('Number of suggestion: ${companyList.length}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return Future.value(companyList
        .map((e) => {
              'company_name': e.companyName!,
              'founder': e.founder.toString(),
              'id': e.id.toString(),
              'logo': e.logo.toString()
            })
        .toList());
  }
}
