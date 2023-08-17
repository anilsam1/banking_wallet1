import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarCommonHeader extends StatefulWidget {
  final Widget? actionMenu;
  final Widget? bottom;
  final Widget? actionMenu2;
  final double paddingStart;
  final Color backgroundColor;
  final String title;

  const AppBarCommonHeader({
    this.actionMenu,
    this.paddingStart = 10.0,
    this.backgroundColor = AppColor.white,
    super.key,
    required this.title,
    this.actionMenu2,
    this.bottom,
  });

  @override
  State<AppBarCommonHeader> createState() => _AppBarCommonHeaderState();
}

double paddingTop = kToolbarHeight;

class _AppBarCommonHeaderState extends State<AppBarCommonHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              28.horizontalSpace,
              Text(
                widget.title,
                style: textAppBarStyle.copyWith(color: AppColor.home_bg),
              ),
              Spacer(),
              widget.actionMenu ?? Container(),
              23.horizontalSpace,
              widget.actionMenu2 ?? Container(),
              28.horizontalSpace
            ],
          ),
          28.verticalSpace,
          widget.bottom ?? 1.verticalSpace
        ],
      ),
    );
  }
}
