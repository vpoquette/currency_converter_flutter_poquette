import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// this is where all our code goes
class _MyHomePageState extends State<MyHomePage> {
  final dollarTextField = TextEditingController();
  final euroTextField = TextEditingController();
  final poundTextField = TextEditingController();
  // we start out broke
  // I'm ok with variables being public for this because I do not like the underscores and it's all in one file anyway
  double dollars = 0;
  double euros = 0;
  double pounds = 0;
  // conversion rates
  double dollarEuroRate = 1.06; // EUR to USD
  double dollarPoundRate = 1.22; // GBP to USD
  double poundEuroRate = 1.15; // GBP to EUR

  // methods for currency conversions
  void eurosToDollars() { // EUR to USD
    setState(() {
      euros = double.parse(euroTextField.text);
      dollars =  euros * dollarEuroRate; // multiply, not divide
      dollarTextField.text = dollars.toStringAsFixed(2);
    });
  }
  void eurosToPounds() { // USD to GBP
    setState(() {
      euros = double.parse(euroTextField.text);
      pounds = euros / poundEuroRate;
      poundTextField.text = pounds.toStringAsFixed(2);
    });
  }
  void dollarsToEuros() { // USD to EUR
    setState(() {
      dollars = double.parse(dollarTextField.text);
      euros = dollars / dollarEuroRate;
      euroTextField.text = euros.toStringAsFixed(2);
    });
  }
  void dollarsToPounds() { // USD to GBP
    setState(() {
      dollars = double.parse(dollarTextField.text);
      pounds = dollars / dollarPoundRate;
      poundTextField.text = pounds.toStringAsFixed(2);
    });
  }
  void poundsToDollars() { // GBP to USD
    setState(() {
      pounds = double.parse(poundTextField.text);
      dollars = pounds * dollarPoundRate;
      dollarTextField.text = dollars.toStringAsFixed(2);
    });
  }
  void poundsToEuros() { // GBP to EUR
    setState(() {
      pounds = double.parse(poundTextField.text);
      euros = pounds * poundEuroRate;
      euroTextField.text = euros.toStringAsFixed(2);
    });
  }

  // build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Currency Converter"), // widget.title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // let's center the UI actually
          children: <Widget>[
            // dollars to euros, pounds
            Row(
              children: [
                Text("Dollars:", style: Theme.of(context).textTheme.headline4), // header
                Expanded(child: TextField(controller: dollarTextField,)),  // decimal input
              ],
            ),
            ElevatedButton(
              onPressed: () {
                dollarsToEuros();
              },
              child: Text('Convert to Euros'),
            ),
            SizedBox(height: 10), // little ol' line break
            ElevatedButton(
              onPressed: () {
                dollarsToPounds();
              },
              child: Text('Convert to Pounds'),
            ),
            SizedBox(height: 50), // big ol' line break

            // euros to dollars, pounds
            Row(
              children: [
                Text('Euros:', style: Theme.of(context).textTheme.headline4),
                Expanded(child: TextField(controller: euroTextField,)),  // decimal input
              ],
            ),
            ElevatedButton(
              onPressed: () {
                eurosToDollars();
              },
              child: Text('Convert to Dollars'),
            ),
            SizedBox(height: 10), // little ol' line break
            ElevatedButton(
              onPressed: () {
                eurosToPounds();
              },
              child: Text('Convert to Pounds'),
            ),
            SizedBox(height: 50), // big ol' line break

            // pounds to dollars, euros
            Row(
              children: [
                Text('Pounds:', style: Theme.of(context).textTheme.headline4),
                Expanded(child: TextField(controller: poundTextField,)),  // decimal input
              ],
            ),
            ElevatedButton(
              onPressed: () {
                poundsToDollars();
              },
              child: Text('Convert to Dollars'),
            ),
            SizedBox(height: 10), // little ol' line break
            ElevatedButton(
              onPressed: () {
                poundsToEuros();
              },
              child: Text('Convert to Euros'),
            ),
          ],
      )
      )
    );
  }
}
