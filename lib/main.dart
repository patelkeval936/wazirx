import 'package:flutter/material.dart';
import 'package:wazirx/utils/route_delegate.dart';
import 'package:wazirx/utils/route_information_parser.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WazirX',
      theme: ThemeData.dark(),
      routerDelegate: StockRouterDelegate(),
      routeInformationParser: StockRouteInformationParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function onTap;
  final Function onStockSelected;

  const MyHomePage({required this.onTap, required this.onStockSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
      children: [
        ...stocks
            .map((e) => ListTile(
                  title: Text(e.name),
                  trailing: Text(e.price.toString()),
                  onTap: () {
                    onStockSelected(e);
                  },
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: ElevatedButton(
            onPressed: () {
              onTap();
            },
            child: Text(isLoggedIn ? ' Go To Log Out Page' : 'Go To Log In Page'),
          ),
        )
      ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final Function onTap;

  const LoginPage({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    onTap();
                  },
                  child: Text(isLoggedIn ? 'Log Out ' : 'Log In')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Pop')),
            ),
          ],
        ),
      ),
    );
  }
}

class StockDetailPage extends StatelessWidget {
  final Stock stock;
  const StockDetailPage({required this.stock, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stock.name), automaticallyImplyLeading: false),
      body: Center(
        child: Text(stock.price.toString()),
      ),
    );
  }
}
