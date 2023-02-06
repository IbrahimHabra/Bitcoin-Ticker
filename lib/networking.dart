import 'dart:convert';

import 'package:http/http.dart';

class Networker {
  final String url;

  Networker({required this.url});

  Future<dynamic> getData() async {
    Response response = await get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
