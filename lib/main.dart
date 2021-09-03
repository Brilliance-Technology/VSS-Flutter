import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/cart_item_title_controller.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/screens/login/login_screen.dart';
import 'package:inventory_management/provider/cart_provider.dart';
import 'package:inventory_management/provider/login_provider.dart';
import 'package:inventory_management/provider/users_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppPrefs appPrefs = AppPrefs();
  var user = await appPrefs.readUser(Constants.user_key);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kPrimaryColorDark,
  ));
  runApp(MyApp(
    userModel: user == null ? UserModel() : user,
  ));
}
//608bb1e48d67853d4d76893a

class MyApp extends StatelessWidget {
  final UserModel userModel;
  final DashBoardController _dashBoardController =
      Get.put(DashBoardController());
  MyApp({Key key, this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartItemTileController());
    _dashBoardController.userModel.value = userModel;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VSS',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.grey,
        ),
        home: userModel == null ? LoginScreen() : HomeScreen(),
      ),
    );
  }
}
