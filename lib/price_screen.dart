// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:bitcoin_ticker/currency_dealer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  String btcP = '???';
  String ethP = '???';
  String ltcP = '???';

  Currencier currencier = Currencier();

  void updateUI() async {
    String bbttcc;
    String eetthh;
    String llttcc;
    setState(() {
      btcP = 'Loading for';
      ethP = 'Loading for';
      ltcP = 'Loading for';
    });
    try {
      bbttcc = await currencier.getFormatedCurrency('BTC', currency);
      eetthh = await currencier.getFormatedCurrency('ETH', currency);
      llttcc = await currencier.getFormatedCurrency('LTC', currency);
    } catch (e) {
      print(e);
      bbttcc = '???';
      eetthh = '???';
      llttcc = '???';
    }
    setState(() {
      btcP = bbttcc;
      ethP = eetthh;
      ltcP = llttcc;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> listDrop = [];
    for (int i = 0; i < 21; i++) {
      listDrop.add(DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      ));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Color(0xff000000)
          image: DecorationImage(
            image: AssetImage('images/_background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 64,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CardCoin(
                    coin: btcP,
                    currency: currency,
                    title: 'Bitcoin',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CardCoin(
                    coin: ethP,
                    currency: currency,
                    title: 'Ethereum',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CardCoin(
                    coin: ltcP,
                    currency: currency,
                    title: 'Litecoin',
                  ),
                ],
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      transform: GradientRotation(1.37),
                      colors: [
                        Color(0xcc0f0f0f),
                        Colors.deepPurple.withOpacity(0.2),
                      ],
                      stops: [0.54, 1],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    border: Border.all(
                        width: 5,
                        color: Color(0xff3b3b3b).withOpacity(0.2),
                        strokeAlign: StrokeAlign.center),
                  ),
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Select the currency :',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                        value: currency,
                        onChanged: (value) {
                          setState(() {
                            currency = value!;
                            updateUI();
                          });
                        },
                        items: listDrop,
                        menuMaxHeight: 220,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardCoin extends StatelessWidget {
  CardCoin({
    Key? key,
    required this.coin,
    required this.currency,
    required this.title,
  }) : super(key: key);

  final String coin;
  final String currency;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(0.4),
              colors: [
                Color(0xcc0f0f0f),
                Colors.teal.shade900.withOpacity(.2),
              ],
              stops: [0.5, 1],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              width: 3,
              color: Color(0xffbdbdbd).withOpacity(0.2),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Color(0xff1c1c1c),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'images/${title.toLowerCase()}.svg',
                      width: 55,
                      height: 55,
                      color: Colors.white38,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.125,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      coin + ' $currency',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
