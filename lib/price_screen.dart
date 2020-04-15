import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "Currency";
  int currencyResultBTC = 0;
  int currencyResultETH = 0;
  int currencyResultLTC = 0;

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> currency = [];
    for (String item in currenciesList) {
      var curr = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      currency.add(curr);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: currency,
        onChanged: (value) async {
          selectedCurrency = value;
          currencyResultBTC =
              await CoinData(symbol: "BTC", currency: selectedCurrency)
                  .getData();
          currencyResultETH =
              await CoinData(symbol: "ETH", currency: selectedCurrency)
                  .getData();
          currencyResultLTC =
              await CoinData(symbol: "LTC", currency: selectedCurrency)
                  .getData();
          setState(() {
            currencyResultBTC = currencyResultBTC;
            currencyResultETH = currencyResultETH;
            currencyResultLTC = currencyResultLTC;
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> currency = [];
    for (String item in currenciesList) {
      currency.add(Text(
        item,
        style: TextStyle(color: Colors.white),
      ));
    }
    return CupertinoPicker(
      looping: false,
      itemExtent: 32.0,
      onSelectedItemChanged: (item) async {
        selectedCurrency = currenciesList[item];
        currencyResultBTC =
            await CoinData(symbol: "BTC", currency: selectedCurrency).getData();
        currencyResultETH =
            await CoinData(symbol: "ETH", currency: selectedCurrency).getData();
        currencyResultLTC =
            await CoinData(symbol: "LTC", currency: selectedCurrency).getData();
        setState(() {
          currencyResultBTC = currencyResultBTC;
          currencyResultETH = currencyResultETH;
          currencyResultLTC = currencyResultLTC;
        });
        print(
            "currencyResultBTC = $currencyResultBTC, currencyResultETH = $currencyResultETH, currencyResultLTC = $currencyResultLTC");
      },
      offAxisFraction: 0.8,
      children: currency,
    );
  }

  Widget getFeature() {
    if (Platform.isAndroid)
      return iosPicker(); //use this androidDropDown(); for ugly picker
    if (Platform.isIOS) return iosPicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("🤑 Coin Ticker"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomCards(
              symbol: "BTC",
              currencyResult: currencyResultBTC,
              currency: selectedCurrency,
            ),
            CustomCards(
              symbol: "ETH",
              currencyResult: currencyResultETH,
              currency: selectedCurrency,
            ),
            CustomCards(
              symbol: "LTC",
              currencyResult: currencyResultLTC,
              currency: selectedCurrency,
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              decoration: BoxDecoration(
                  gradient: RadialGradient(
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
                      stops: [
                    0.7,
                    0.9,
                    0.1
                  ], colors: [
                Colors.black,
                Colors.white,
                Colors.transparent
              ])),
              child: getFeature(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCards extends StatefulWidget {
  final int currencyResult;
  final String symbol;
  final String currency;
  CustomCards({this.symbol, this.currencyResult, this.currency});
  @override
  _CustomCardsState createState() => _CustomCardsState();
}

class _CustomCardsState extends State<CustomCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.grey[850],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.symbol} = ${widget.currencyResult} ${widget.currency}',
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
