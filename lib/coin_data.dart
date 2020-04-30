import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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
  String currencyCode;
  String inputCurrencyCode;
  CoinData({@required this.currencyCode, this.inputCurrencyCode});
  Future getCoinData()async {
    var response = await http.get('https://rest.coinapi.io/v1/exchangerate/$inputCurrencyCode/$currencyCode?apikey=BDEABC4B-B93F-461A-B7B1-289E57C2E700');
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse['rate']);
      return jsonResponse;
    }
    else{
      print('error');
    }
  }
}
