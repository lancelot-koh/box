import 'package:box/controllers/popular_product_controller.dart';
import 'package:box/controllers/recommended_product_controller.dart';
import 'package:box/pages/cart/cart_page.dart';
import 'package:box/pages/home/main_food_page.dart';
import 'package:box/router/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/Dependency.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MainFoodPage(),
      initialRoute: RouterHelper.getInitial(),
      getPages: RouterHelper.routes,
    );
  }
}
