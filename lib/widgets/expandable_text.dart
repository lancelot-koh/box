
import 'package:box/utils/colors.dart';
import 'package:box/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String content;
  const ExpandableText({Key? key, required this.content}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hidden = true;

  double textHeight = Dimensions.screenHeight/5.63;
  @override
  void initState() {
    super.initState();
    if (widget.content.length > textHeight) {
      firstHalf = widget.content.substring(0, textHeight.toInt());
      secondHalf = widget.content.substring(textHeight.toInt() + 1, widget.content.length);
    } else {
      firstHalf = widget.content;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? SmallText(text: firstHalf) :
          Column(children: [
            SmallText(text:  hidden ? (firstHalf + "...") : firstHalf + secondHalf, size: 16,),
            InkWell(
              onTap: () {
                setState(() {
                  hidden = !hidden;
                });
              },
              child: Row(
                children: [
                  SmallText(text: hidden? "Show more" : "Show less", color: AppColors.mainColor,),
                  Icon(hidden? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,),
                ],
              ),
            )
          ],)
    );
  }
}
