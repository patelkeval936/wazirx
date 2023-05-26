class StockRoutePath{

  int? id;
  bool goToLoginPage = false;


  StockRoutePath.home();

  StockRoutePath.stockDetails(int stockId){
    id = stockId;
  }

  StockRoutePath.logIn(): goToLoginPage = true;



  bool get showHome => id == null;

  bool get showStockDetail => id != null;

  bool get showLoginPage => goToLoginPage;

}

