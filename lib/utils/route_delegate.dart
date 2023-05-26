import 'package:flutter/material.dart';
import 'package:wazirx/main.dart';
import '../data.dart';
import '../models/stock_route_path.dart';

final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

bool isLoggedIn = false;
bool showLoginPage = false;

class StockRouterDelegate extends RouterDelegate<StockRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<StockRoutePath> {

  Stock? selectedStock;

  bool showStockPage = false;
  bool showStockDetailPage = false;

  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);
    print('show login page status $showLoginPage');
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('home page'),
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
              key: ValueKey('login page'),
              child: LoginPage(onTap: () {
                isLoggedIn = !isLoggedIn;
                notifyListeners();
              })),
        if (selectedStock != null && isLoggedIn)
          MaterialPage(key: ValueKey('stock/${selectedStock?.name}'), child: StockDetailPage(stock: selectedStock!)),
        if (selectedStock != null && !isLoggedIn)
          MaterialPage(
              key: ValueKey('login '),
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
      print('giving show login page config');
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
      print('inside config show login page ${configuration.showLoginPage}');
      showLoginPage = true;
      notifyListeners();

    }
      if (configuration.id != null) {
      showStockDetailPage = true;
      selectedStock = stocks[configuration.id!];
      notifyListeners();
    }
      if (configuration.id == null) {
      showLoginPage = false;
      showStockDetailPage = false;
      selectedStock = null;
      notifyListeners();
    }
  }
}
