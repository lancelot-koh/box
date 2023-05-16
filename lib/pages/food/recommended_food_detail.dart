import 'package:box/controllers/popular_product_controller.dart';
import 'package:box/controllers/recommended_product_controller.dart';
import 'package:box/pages/food/app_icon.dart';
import 'package:box/router/router_helper.dart';
import 'package:box/utils/colors.dart';
import 'package:box/utils/dimensions.dart';
import 'package:box/widgets/big_text.dart';
import 'package:box/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int productId;
  const RecommendedFoodDetail({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productList = Get.find<RecommendedProductController>().recommendedProductList;
    var product = productList.firstWhere((element) => element.id == productId);
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterHelper.getInitial());
                    },
                  child: AppIcon(icon: Icons.clear)
                ),
                GetBuilder<PopularProductController>(builder: (productController){
                  return GestureDetector(
                      onTap: () {
                        if (productController.totalItems >= 1) {
                          Get.toNamed(RouterHelper.getCartPage());
                        }
                      },
                    child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopularProductController>().totalItems >= 1 ?
                          Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(icon: Icons.circle,
                                  size:  20, iconColor:
                                  Colors.transparent,
                                  bkColor: AppColors.mainColor,)) : Container(),
                          Get.find<PopularProductController>().totalItems >= 1 ?
                          Positioned(
                              right: 6,
                              top: 4,
                              child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), size:  12, color:  Colors.white)) :
                          Container()
                        ]
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(text: product.title!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              )
            ),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  product.thumbnail!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(content: product.description!),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (productController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        productController.setQuantity(false);
                      },
                      child: AppIcon(
                        bkColor: AppColors.mainColor,
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      )
                  ),
                  BigText(text: "\$ ${product.price} X ${productController.inCartItems}", color: AppColors.mainColor, size: Dimensions.font26,),
                  GestureDetector(
                      onTap: () {
                        productController.setQuantity(true);
                      },
                      child: AppIcon(
                        bkColor: AppColors.mainColor,
                        icon: Icons.add,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      )
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
                color: AppColors.buttonBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.favorite, color: AppColors.mainColor,),
                  ),
                  GestureDetector(
                    onTap: () {
                      productController.addItem(product, );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                      child: BigText(text: "\$ ${product.price! * productController.inCartItems} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
