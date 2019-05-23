import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  

  List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Cryptic"),
        centerTitle: true,
      ),
      body: _crypticWidget(),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(currency['price_usd'], currency['percentage_change_1h']),
    );
  }

  Widget _crypticWidget (){
  return new Container(
    child: new Column(
      children: <Widget>[ new Flexible(
      child: new ListView.builder(
        itemCount: widget.currencies.length,
        itemBuilder: (BuildContext context, int index){
          final Map currency = widget.currencies[index];
          final MaterialColor color = _colors[index % _colors.length];

          return _getListItemUI(currency, color);
        },
      ),
    ),],
    ),
  );
}

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",
    style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if(double.parse(percentageChange)>0){
      percentageChangeTextWidget = new TextSpan(
       text: percentageChangeText,
       style: new TextStyle(color: Colors.green)
     ); 
    }
    else{
      percentageChangeTextWidget = new TextSpan(
       text: percentageChangeText,
       style: new TextStyle(color: Colors.red)); 
    }
    return new RichText(
      text: new TextSpan(
        children: [priceTextWidget, percentageChangeTextWidget],
      ),
    );
  }

}

