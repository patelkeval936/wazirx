import 'package:flutter/material.dart';
import 'package:wazirx/models/stock_route_path.dart';
import 'package:wazirx/utils/route_delegate.dart';

class StockRouteInformationParser extends RouteInformationParser<StockRoutePath> {
  @override
  Future<StockRoutePath> parseRouteInformation(RouteInformation routeInformation) async {

    Uri uri = Uri.parse(routeInformation.location!);

    print('${uri.pathSegments} ${uri.pathSegments.length}');

    if (uri.pathSegments.length >= 2) {
      return StockRoutePath.stockDetails(int.parse(uri.pathSegments[1].toString()));
    }

    if(uri.pathSegments.isNotEmpty){
      if (uri.pathSegments[0] == 'login') {
        print('inside login');
        return StockRoutePath.logIn();
      }
    }

    // if (uri.pathSegments.length == 0)
       return StockRoutePath.home();

  }

  @override
  RouteInformation? restoreRouteInformation(StockRoutePath configuration) {

    if (configuration.showLoginPage) {
      return const RouteInformation(location: '/login');
    } else if (configuration.showStockDetail) {
      return RouteInformation(location: '/stock/${configuration.id}');
    }
      // if (configuration.showHome)
     return const RouteInformation(location: '/');

  }
}
