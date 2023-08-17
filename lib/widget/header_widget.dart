import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatefulWidget {
  final Widget? actionMenu;
  final double paddingStart;
  final Color backgroundColor;
  final String title;

  const AppBarWidget({
    this.actionMenu,
    this.paddingStart = 10.0,
    this.backgroundColor = AppColor.white,
    super.key,
    required this.title,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

double paddingTop = kToolbarHeight - 20;

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          28.horizontalSpace,
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Image.asset(
              Assets.imageBack,
              height: 11.h,
              width: 24.w,
            ),
          ),
          70.horizontalSpace,
          Text(
            widget.title,
            style: textAppBarStyle,
          ),
          Spacer(),
          widget.actionMenu ?? Container(),
          34.horizontalSpace
        ],
      ),
    );
  }
}
