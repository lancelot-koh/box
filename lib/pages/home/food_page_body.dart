import 'package:box/controllers/popular_product_controller.dart';
import 'package:box/controllers/recommended_product_controller.dart';
import 'package:box/model/product.dart';
import 'package:box/pages/food/popular_food_detail.dart';
import 'package:box/router/router_helper.dart';
import 'package:box/utils/colors.dart';
import 'package:box/widgets/app_column.dart';
import 'package:box/widgets/big_text.dart';
import 'package:box/widgets/icon_and_text.dart';
import 'package:box/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _State();
}

class _State extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPage = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded ? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
             }),
          ): CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return new DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty? 1 : popularProducts.popularProductList.length,
            position: currentPage,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular text*********************************************
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              )
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          if (recommendedProduct.isLoaded) {
            return ListView.builder(
                padding: EdgeInsets.only(top: Dimensions.height10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouterHelper.getRecommendedProduct(recommendedProduct.recommendedProductList[index].id!));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10,),
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular((Dimensions.radius20)),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    recommendedProduct.recommendedProductList[index].thumbnail!
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContainerSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].title!),
                                    SizedBox(height: Dimensions.height10,),
                                    SmallText(text: "description!"),
                                    SizedBox(height: Dimensions.height10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndText(icon: Icons.circle_sharp, text: recommendedProduct.recommendedProductList[index].category!, iconColor: AppColors.iconColor1),
                                        IconAndText(icon: Icons.location_on, text: "", iconColor: AppColors.mainColor),
                                        IconAndText(icon: Icons.access_time_rounded, text: "", iconColor: AppColors.iconColor2),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator(
            color: AppColors.mainColor,
          );
          }
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel product) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currentPage.floor()) {
      var currScale = 1 - (currentPage - index) * ( 1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPage.floor() + 1){
      var currScale = scaleFactor + (currentPage - index + 1) * ( 1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else if (index == currentPage.floor() - 1){
      var currScale = 1 - (currentPage - index) * ( 1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 1);

    }
    var product = Get.find<PopularProductController>().popularProductList[index];
    return Transform(transform: matrix,
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouterHelper.getPopularProduct(product.id));
          },
          child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df): Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        product.thumbnail!
                    )
                )
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  offset: Offset(0, 5),
                  blurRadius: 5.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ]
            ),
            child: Container(
              padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
              child: AppColumn(title: product.title!,),
            ),
          ),
        ),
      ],
    ),);
  }
}
