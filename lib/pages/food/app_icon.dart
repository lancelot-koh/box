import 'package:box/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color bkColor;
  final double size;
  final Color iconColor;
  final double iconSize;
  const AppIcon({Key? key,
    required this.icon,
    this.bkColor = const Color(0xFFfcf4e4),
    this.size = 40,
    this.iconSize =  16,
    this.iconColor = const Color(0xFF756d54),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: bkColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
