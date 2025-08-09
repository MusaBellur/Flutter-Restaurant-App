import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurants_app/controllers/cart_controller.dart';
import 'package:restaurants_app/controllers/popular_product_controller.dart';
import 'package:restaurants_app/data/repository/popular_product_repo.dart';
import 'package:restaurants_app/pages/cart/cart_page.dart';
import 'package:restaurants_app/pages/home/food_page_body.dart';
import 'package:restaurants_app/pages/home/main_food_page.dart';
import 'package:restaurants_app/routes/route_helper.dart';
import 'package:restaurants_app/utils/app_constants.dart';
import 'package:restaurants_app/utils/colors.dart';
import 'package:restaurants_app/utils/dimensions.dart';
import 'package:restaurants_app/widgets/app_column.dart';
import 'package:restaurants_app/widgets/app_icon.dart';
import 'package:restaurants_app/widgets/big_text.dart';
import 'package:restaurants_app/widgets/expandable_text_widget.dart';
import 'package:restaurants_app/widgets/icon_and_text_widget.dart';
import 'package:restaurants_app/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(page == "cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                        else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_new)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.snackbar("Uyarı", "Sepetiniz Boş!",
                              backgroundColor: AppColors.mainColor,
                              colorText: Colors.white);
                        }
                      },
                      child: Stack(children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 4,
                                top: 2,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ]),
                    );
                  })
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height15),
                  BigText(text: "İçeriği:"),
                  SizedBox(height: Dimensions.height15),
                  Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                    text: product.description!,
                  )))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (PopularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          PopularProduct.setQuentity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: PopularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          PopularProduct.setQuentity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    PopularProduct.addItem(product);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height15,
                          bottom: Dimensions.height15,
                          left: Dimensions.width15,
                          right: Dimensions.width15),
                      child: GestureDetector(
                        child: BigText(
                          text: product.price.toString()! + "₺ | Sepete Ekle",
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20))),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
