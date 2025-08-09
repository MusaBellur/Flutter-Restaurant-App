import 'package:get/get.dart';
import 'package:restaurants_app/pages/cart/cart_page.dart';
import 'package:restaurants_app/pages/food/popular_food_detail.dart';
import 'package:restaurants_app/pages/food/recommended_food_detail.dart';
import 'package:restaurants_app/pages/home/home_page.dart';
import 'package:restaurants_app/pages/home/main_food_page.dart';
import 'package:restaurants_app/pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularfood = "/popular-food";
  static const String recommendedfood = "/recommended-food";
  static const String cartpage = "/cart-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) => '$popularfood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedfood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartpage';

  static List<GetPage> routes =[
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage()),
    
    GetPage(name: popularfood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      //print(pageId);
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn
    ),
    GetPage(name: recommendedfood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      //print(pageId);
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn
    ),
    GetPage(name: cartpage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn
    ),
  ];
}
