import 'dart:convert';

import 'package:http/http.dart' as http;

// Free exchange rates from ExchangeRate-API. No sign-up or key needed;
// the rates update once a day. Their terms ask us to credit them in the app.
class RatesService {
  static final _url = Uri.parse('https://open.er-api.com/v6/latest/NGN');

  // How many dollars one naira is worth, e.g. 0.00065.
  Future<double> nairaToDollar() async {
    // On a weak network a request can hang for minutes. After 10 seconds
    // we give up, and the app shows the "check your internet" message.
    final response = await http.get(_url).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('The rates server replied ${response.statusCode}');
    }

    // The reply looks like: {"result":"success", "rates":{"USD":0.00065, ...}}
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final rates = data['rates'] as Map<String, dynamic>;
    return (rates['USD'] as num).toDouble();
  }
}
