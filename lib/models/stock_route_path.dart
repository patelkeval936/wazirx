class StockRoutePath {

  int? id;
  bool _goToLoginPage = false;


  StockRoutePath.home();

  StockRoutePath.stockDetails(int stockId){
    id = stockId;
    _goToLoginPage = false;
  }

  StockRoutePath.logIn(){
    _goToLoginPage = true;
    id = null;
  }


  bool get showHome => id == null;

  bool get showStockDetail => id != null;

  bool get showLoginPage => _goToLoginPage;

}

