import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/";
  String symbol;
  String currency;
  CoinData({this.symbol, this.currency});
  Future<int> getData() async {
    http.Response response = await http.get("$url$symbol$currency",
        headers: {"x-ba-key": "MGRmZTNlNWM5YjZlNDY0MmE3ZjdhMGI1NmQ3MmRiNGM"});

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      int last = data["last"].floor();
      return last;
    } else {
      print(response.statusCode);
    }
  }
}
