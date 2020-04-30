import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    super.initState();
    getCoinData('USD');
  }

  void getCoinData(String currencyCode) async {
    var responseBTC = await CoinData(currencyCode: currencyCode, inputCurrencyCode: cryptoList[0]).getCoinData();
    var responseETH = await CoinData(currencyCode: currencyCode, inputCurrencyCode: cryptoList[1]).getCoinData();
    var responseLTC = await CoinData(currencyCode: currencyCode, inputCurrencyCode: cryptoList[2]).getCoinData();
    setState(() {
      rateBTC = responseBTC['rate'].round();
      rateETH = responseETH['rate'].round();
      rateLTC = responseLTC['rate'].round();
      selectedCurrency = currencyCode;
    });
  }

  int rateBTC, rateETH, rateLTC;
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDowns = [];
    for (String currency in currenciesList) {
      var newItem = new DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDowns.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDowns,
      onChanged: (value) async {
        getCoinData(value);
      },
    );
  }

  CupertinoPicker iosDropDownPicker() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerItems.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        getCoinData(currenciesList[value]);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HomeScreenCard(
            rate: rateBTC,
            selectedCurrency: selectedCurrency,
            text : cryptoList[0],
          ),
          HomeScreenCard(
            rate: rateETH,
            selectedCurrency: selectedCurrency,
            text : cryptoList[1],
          ),
          HomeScreenCard(
            rate: rateLTC,
            selectedCurrency: selectedCurrency,
            text : cryptoList[2],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
//            child: Platform.isIOS ? iosDropDownPicker() : androidDropDown(),
          child: iosDropDownPicker(),
          ),

        ],
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  final int rate;
  final String selectedCurrency;
  final String text;
  @override
  HomeScreenCard({this.rate, this.selectedCurrency, this.text});
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $text = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
