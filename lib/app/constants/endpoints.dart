class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://65.0.129.68/api/v1";
  // receiveTimeout
  static const int receiveTimeout = 5000;
  // connectTimeout
  static const int connectionTimeout = 10000;
  static const String filterBatch = "/log/B/filter";
  static const String loginUser = "/usersLogin";
  static const String createOrder = "/sales/create";
  static const String ordersList = "/sales";
  static const String editSales = "/sales/edit";
  static const String totalsCountBySales = "/total/get?sales_id=";
  static const String totalsCount = "/total/getadmin";
  //static const String salesManagerDashBoard = "/salesManger/get?sales_id=";
  static const String salesManagerPie = "/peiChart/getstock?sales_id=";
  static const String pieChart = "/peiChart/getallstock?";
  static const String SalesMangerBarGraph = "";
  static const String barGraph = "";

  static const String productInchargeList = "/user_management/role/3";
  static const String accessToken =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuZXdVc2VyIjp7Il9pZCI6IjYwM2IzNDM5MzViODI2MjBhMDg5ZTkwNyIsInVzZXJuYW1lIjoiYWRtaW4iLCJwYXNzd29yZCI6ImFkbWluIn0sImlhdCI6MTYxNTg5MTU2MSwiZXhwIjoxNjE1OTc3OTYxfQ.exU8x5APvJBqlVKtIHHSYrqXMNKu38GyusySo-ZxCp4";
}
