import 'networking.dart';

const apiKey = 'DF824D99-AEF0-4897-BE77-EDE90C12AAC3';
const url = 'https://rest.coinapi.io/v1/exchangerate';

class Currencier {
  Future<String> getFormatedCurrency(String from, String to) async {
    Networker networker = Networker(url: '$url/$from/$to?apikey=$apiKey');
    var data = await networker.getData();
    double form = data['rate'];
    String editText = form.toInt().toString();
    String rate = '';
    int r = editText.length % 3;
    for (int i = 0; i < editText.length; i++) {
      if ((i - r) % 3 == 0 && i != 0) rate += '\'';
      rate += editText[i];
    }
    return rate;
  }
}
