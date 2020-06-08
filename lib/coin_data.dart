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
  final String apiKey = 'apikey=A02DDBB1-2794-4719-ADAA-D256B4F9746B';
  final String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
  Future getData(String selectedCurrency) async {
    Map<String, String> cryptoCurrency = {};
    for (String cryto in cryptoList) {
      final String url = '$baseUrl/$cryto/$selectedCurrency?$apiKey';
      http.Response _response = await http.get(url);
      if (_response.statusCode == 200) {
        var data = jsonDecode(_response.body);
        print(data);
        double bitcoinPrise = data['rate'];
        cryptoCurrency[cryto] = bitcoinPrise.toStringAsFixed(0);
      } else {
        print(_response.statusCode);
      }
    }
    return cryptoCurrency;
  }
}
