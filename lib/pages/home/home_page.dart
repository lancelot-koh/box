
import 'package:box/pages/cart/cart_history.dart';
import 'package:box/pages/home/main_food_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(child:  Center(child: Text("Next page"),),),
    CartHistory(),
    Container(child:  Center(child: Text("Next page 3"),),),
  ];

  void onTapNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.titleColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTapNav,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),
              label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,),
            label: "History",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings,),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
