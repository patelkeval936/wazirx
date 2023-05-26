import 'package:flutter/material.dart';
import 'package:wazirx/main.dart';
import '../data.dart';
import '../models/stock_route_path.dart';

final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

bool isLoggedIn = false;

class StockRouterDelegate extends RouterDelegate<StockRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<StockRoutePath> {

  Stock? selectedStock;
  bool showLoginPage = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: const ValueKey('home page'),
          child: MyHomePage(
            onTap: () {
              showLoginPage = true;
              notifyListeners();
            },
            onStockSelected: (stock) {
              selectedStock = stock;
              notifyListeners();
            },
          ),
        ),
        if (showLoginPage)
          MaterialPage(
              key: const ValueKey('login page'),
              child: LoginPage(onTap: () {
                isLoggedIn = !isLoggedIn;
                notifyListeners();
              })),
        if (selectedStock != null && isLoggedIn)
          MaterialPage(key: ValueKey('stock/${selectedStock?.name}'), child: StockDetailPage(stock: selectedStock!)),
        if (selectedStock != null && !isLoggedIn)
          MaterialPage(
              key: const ValueKey('login '),
              child: LoginPage(onTap: () {
                isLoggedIn = !isLoggedIn;
                notifyListeners();
              })),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        selectedStock = null;

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => key;

  @override
  StockRoutePath get currentConfiguration {
    if (showLoginPage || selectedStock != null && !isLoggedIn) {
      return StockRoutePath.logIn();
    } else if (selectedStock != null && isLoggedIn) {
      return StockRoutePath.stockDetails(stocks.indexOf(selectedStock!));
    }else{
      return StockRoutePath.home();
    }

  }

  @override
  Future<void> setNewRoutePath(StockRoutePath configuration) async {

    if (configuration.showLoginPage) {
      showLoginPage = true;
      selectedStock = null;
      notifyListeners();
    } else if (configuration.id != null) {
      selectedStock = stocks[configuration.id!];
      showLoginPage = false;
      notifyListeners();
    }else
      {
      showLoginPage = false;
      selectedStock = null;
      notifyListeners();
    }

  }
}
