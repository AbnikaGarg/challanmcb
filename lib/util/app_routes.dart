import 'package:challanmcbjava/bindings/challan_bindings.dart';
import 'package:challanmcbjava/bindings/receipt_bindings.dart';
import 'package:challanmcbjava/bindings/splash_bindings.dart';
import 'package:challanmcbjava/view/add_challan.dart';
import 'package:challanmcbjava/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../view/add_receipt.dart';

class Routes {
  static String home = '/home';
  static String splash = '/';
  static String login = '/login';
  static String signup = '/signup';
  static String addChallan = '/addchallan';
    static String addReceipt = '/addReceipt';
  static String withdrawal = '/withdrawal';
  static String transferFunds = '/transferFunds';
}

appRoutes() => [
      GetPage(
        name: Routes.splash,
        binding: SplashScreenBindings(),
        page: () => SplashScreen(),
      ),
      GetPage(
        name: Routes.addChallan,
        binding: ChallanBindings(),
        page: () => AddChallan(),
      ),
       GetPage(
        name: Routes.addReceipt,
        binding: ReceiptBindings(),
        page: () => AddReceipt(),
      )
    ];
