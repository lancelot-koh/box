
import 'dart:async';

import 'package:box/router/router_helper.dart';
import 'package:box/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState(){
    super.initState();
    _loadResource();

    Timer(
      Duration(seconds: 3),
        () => {
          Get.offNamed(RouterHelper.getInitial())
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(child: BigText(text: "Loading...")),
    );
  }
}
