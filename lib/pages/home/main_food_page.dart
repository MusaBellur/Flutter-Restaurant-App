import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurants_app/pages/home/food_page_body.dart';
import 'package:restaurants_app/utils/colors.dart';
import 'package:restaurants_app/utils/dimensions.dart';
import 'package:restaurants_app/widgets/big_text.dart';
import 'package:restaurants_app/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: 15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Turkiye", color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: "Hatay", color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded, color: const Color.fromARGB(137, 91, 38, 38),),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],   
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}