import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final Uri uri;

  NetworkHelper({ required this.uri});

  Future<Map<String, dynamic>> getData() async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch data');
    }
  }
}
