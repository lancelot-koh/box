import 'package:box/controllers/cart_controller.dart';
import 'package:box/controllers/popular_product_controller.dart';
import 'package:box/pages/cart/cart_page.dart';
import 'package:box/pages/food/app_icon.dart';
import 'package:box/router/router_helper.dart';
import 'package:box/utils/colors.dart';
import 'package:box/utils/dimensions.dart';
import 'package:box/widgets/app_column.dart';
import 'package:box/widgets/big_text.dart';
import 'package:box/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int productId;
  const PopularFoodDetail({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productList = Get.find<PopularProductController>().popularProductList;
    var product = productList.firstWhere((element) => element.id == productId);
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.foodDetailImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      product.thumbnail
                    ),
                  ),
                ),
          ),),
          // icon
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouterHelper.getInitial());
                    },
                      child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProductController>(builder: (productController){
                    return Stack(
                    children: [
                      GestureDetector(
                          onTap: (){
                            if (productController.totalItems >= 1) {
                              Get.toNamed(RouterHelper.getCartPage());
                            }
                          },
                          child: AppIcon(icon: Icons.shopping_cart_outlined)),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                        Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(icon: Icons.circle,
                              size:  20, iconColor:
                              Colors.transparent,
                              bkColor: AppColors.mainColor,)) :
                        Container(),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                      Positioned(
                          right: 6,
                          top: 4,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), size:  12, color:  Colors.white)) :
                      Container()
                    ]
                    );
                  }),
                ],

              ),
          ),
          // introduce
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.foodDetailImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top:  Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(title: product.title,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20),
                    Expanded(child:
                      SingleChildScrollView(child:
                          ExpandableText(content: product.description),
                          ),
                      ),
                  ],
                )
              ),
          ),


        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
                    GestureDetector(
                      child: Icon(Icons.remove, color: AppColors.signColor,),
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                    ),
                    SizedBox(width: Dimensions.width10 / 2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10 / 2,),
                    GestureDetector(
                      child: Icon(Icons.add, color: AppColors.signColor,),
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                child: GestureDetector(
                    child: BigText(text: "\$ ${product.price * popularProduct.quantity } | Add to cart", color: Colors.white,),
                    onTap: () {
                    popularProduct.addItem(product, );
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
