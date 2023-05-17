import 'package:box/pages/cart/cart_page.dart';
import 'package:box/pages/food/popular_food_detail.dart';
import 'package:box/pages/food/recommended_food_detail.dart';
import 'package:box/pages/home/home_page.dart';
import 'package:box/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String initial = "/";
  static const String popularProduct = "/popular-product";
  static const String recommendedProduct = "/recommend-product";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";


  static String getInitial() => '$initial';
  static String getPopularProduct(int productId) => '$popularProduct?productId=$productId';
  static String getRecommendedProduct(int productId) => '$recommendedProduct?productId=$productId';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splashPage';


  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=> SplashScreen()),

    GetPage(name: initial, page: ()=> HomePage()),
    GetPage(name: popularProduct, page: () {
        var productId = Get.parameters["productId"];
        return PopularFoodDetail(productId: int.parse(productId!),);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedProduct, page: (){
      var productId = Get.parameters["productId"];
      return RecommendedFoodDetail(productId: int.parse(productId!),);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn,
    ),
  ];
}