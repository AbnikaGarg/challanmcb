class AppUrl {
  static const String APP_NAME = 'MCB';
  static const double APP_VERSION = 1.0;
  static const String baseUrl = 'https://apivehiclechallan.mcbathinda.com';
  static const String login = baseUrl + '/api/Login/UserLogin';
  static const String reasonsApi = baseUrl + '/api/Master/FillChallanReason';
  static const String categoryApi = baseUrl + '/api/Master/FillVehicleCategory';
   static const String addChallan = baseUrl + '/api/VehicleTow/VehicleTowEntry';
      static const String getChallan = baseUrl + '/api/VehicleTow/VehicleTowEntryList';
        static const String paymodes = baseUrl + '/api/Master/FillPaymode';
      static const String addReceipt = baseUrl + '/api/VehicleTow/PaymentReceiveEntry';
      static const String getReceipt = baseUrl + '/api/VehicleTow/PaymentRecEntryList';
  static const String getDashboard = baseUrl + '/api/VehicleTow/GetTodaySummary';
}
