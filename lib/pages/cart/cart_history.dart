


import 'package:box/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../food/app_icon.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemsPerOrder = {};
    var getCartHistoryList =
    Get.find<CartController>().getCartHistoryList().reversed.toList();

    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time.toString(), (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(
            getCartHistoryList[i].time.toString(), () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parsedDate.toString());
        var outputFormat = DateFormat('MMM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),

        GetBuilder<CartController>(builder: (_cartController){
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(child: Container(
              margin: EdgeInsets.all(Dimensions.width20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amberAccent
                  ),
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      right: 5,
                                      bottom: 10,
                                    ),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          getCartHistoryList[0].thumbnail!
                                        )
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ) ,
                        ),
                    ],
                  )
                ),
              )

          )): SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: const Center(
              child: NoDataPage(
                text: 'You did not buy anything',
                imgPath: 'assets/image/empty_box.png',
              ),
            ),
          );

        }),

    ],
      ),
    );
  }
}

