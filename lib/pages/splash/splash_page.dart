import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurants_app/controllers/cart_controller.dart';
import 'package:restaurants_app/controllers/popular_product_controller.dart';
import 'package:restaurants_app/controllers/recommended_product_controller.dart';
import 'package:restaurants_app/routes/route_helper.dart';
import 'package:restaurants_app/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    final popularProductController = Get.find<PopularProductController>();
    await popularProductController.getPopularProductList();
    final recommendedProductController = Get.find<RecommendedProductController>();
    await recommendedProductController.getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
    const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/image/logo part 1.png",
              width: Dimensions.splashImg,
            )),
          ),
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/image/logo part 2.png",
              width: Dimensions.splashImg,
            )),
          ),
        ],
      ),
    );
  }
}
