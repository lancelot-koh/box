

import 'package:box/controllers/cart_controller.dart';
import 'package:box/controllers/popular_product_controller.dart';
import 'package:box/controllers/recommended_product_controller.dart';
import 'package:box/pages/food/app_icon.dart';
import 'package:box/utils/colors.dart';
import 'package:box/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../router/router_helper.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      bkColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                    SizedBox(width: Dimensions.width20 * 5,),
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(RouterHelper.getInitial());
                        },
                        child: AppIcon(icon: Icons.home,
                        iconColor: Colors.white,
                        bkColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),),

                    AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      bkColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController) {
                      var cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              height:  Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                        var popularProductList = Get.find<PopularProductController>().popularProductList;
                                        var recommendProductList = Get.find<RecommendedProductController>().recommendedProductList;
                                        var pindex = popularProductList.indexOf(cartList[index].product);
                                        int pid = 0;
                                        if (pindex == -1) {
                                          pindex = recommendProductList.indexOf(cartList[index].product);
                                          pid = recommendProductList[pindex].id;
                                        } else {
                                          pid = popularProductList[pindex].id;
                                        }

                                        if (pid < 10) {
                                          Get.toNamed(RouterHelper.getPopularProduct(pid));
                                        } else {
                                          Get.toNamed(RouterHelper.getRecommendedProduct(pid));
                                        }
                                    },
                                    child: Container(
                                      width: Dimensions.height20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom:  10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              cartController.getItems[index].thumbnail!
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: Dimensions.width10),
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController.getItems[index].title!.toString(),
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: 'Spicey'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: "\$" + cartController.getItems[index].price!.toString(),
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(
                                                  Dimensions.height10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                    Dimensions.radius20,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(cartList[index].product!, -1);
                                                        },
                                                        child: Icon( Icons.remove, color: AppColors .signColor, )),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                      ),
                                                      child:
                                                      BigText(text: cartList[index].quantity.toString()),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(cartList[index].product!, 1);
                                                        },
                                                        child: Icon(Icons.add,color: AppColors.signColor,)),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ))
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
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
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10 / 2,),
                    BigText(text: "\$" + cartController.totalAmount.toString()),
                    SizedBox(width: Dimensions.width10 / 2,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                child: GestureDetector(
                  child: BigText(text: "\$  | Add to cart", color: Colors.white,),
                  onTap: () {
                    // popularProduct.addItem(product, );
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              )
            ],
          ),
        );
      }),

      
    );
  }
}
