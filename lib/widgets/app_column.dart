import 'package:box/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String title;
  const AppColumn({Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: title, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(Icons.star,  color: AppColors.mainColor, size: 12,);
              }),
            ),
            SizedBox(width: 5,),
            SmallText(text: "4.5"),
            SizedBox(width: 20,),
            SmallText(text: "1287"),
            SizedBox(width: 5,),
            SmallText(text: "Comments"),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
            IconAndText(icon: Icons.location_on, text: "32mins", iconColor: AppColors.mainColor),
            IconAndText(icon: Icons.access_time_rounded, text: "Normal", iconColor: AppColors.iconColor2),
          ],
        ),

      ],
    );
  }
}
