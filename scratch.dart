import 'dart:convert';

import 'package:http/http.dart';

void main() async {
  String s1 = '1234567';
  String s = '123456';
  String s2 = '12345';
  String s3 = '1234';
  String s4 = '123';

  rate(s1);
  rate(s);
  rate(s2);
  rate(s3);
  rate(s4);
}

void rate(String s) {
  String rate = '';
  int r = s.length % 3;
  for (int i = 0; i < s.length; i++) {
    if ((i - r) % 3 == 0 && i != 0) rate += '\'';
    rate += s[i];
  }
  print(rate);
}
