import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = 'USD';

  List<DropdownMenuItem> getCurrency() {
    List<DropdownMenuItem<String>> ddItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      ddItems.add(newItem);
    }
    return ddItems;
  }

  Map<String, String> coinValue = {};
  bool isWaiting = false;

  // ignore: non_constant_identifier_names
  BtcData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getData(selectedItem);
      isWaiting = false;
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    BtcData();
    super.initState();
  }

  Column makeCard() {
    List<CryptoCard> cryptoCardList = [];

    for (String crypto in cryptoList) {
      cryptoCardList.add(
        CryptoCard(
          value: isWaiting ? '?' : coinValue[crypto],
          selectedItem: selectedItem,
          cryptoCurrency: crypto,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCardList,
    );
  }

  @override
  Widget build(BuildContext context) {
    getCurrency();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCard(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              itemHeight: 75,
              value: selectedItem,
              items: getCurrency(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                  BtcData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.value,
    @required this.selectedItem,
    @required this.cryptoCurrency,
  }) : super(key: key);

  final String value;
  final String selectedItem;
  final String cryptoCurrency;

  @override
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
            '1 $cryptoCurrency = $value $selectedItem',
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
