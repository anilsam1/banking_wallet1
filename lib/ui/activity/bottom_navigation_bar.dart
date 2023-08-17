import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/ui/activity/activity_screen.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/common_header.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class BottomNavigationBarDemoPage extends StatefulWidget {
  const BottomNavigationBarDemoPage({super.key});

  @override
  State<BottomNavigationBarDemoPage> createState() =>
      _BottomNavigationBarDemoPageState();
}

class _BottomNavigationBarDemoPageState
    extends State<BottomNavigationBarDemoPage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: SizedBox(
            height: 60.r,
            width: 60.r,
            child: FloatingActionButton(
              onPressed: () {},
              child: Image.asset(Assets.imageFourSquaresButtonOfViewOptions,
                  height: 20.r),
              backgroundColor: Colors.white,
              shape: CircleBorder(),
              elevation: 10,
            ),
          ),
        ),
        appBar: PreferredSize(
            preferredSize: Size(0, 120.h),
            child: AppBarCommonHeader(
              backgroundColor: AppColor.transparent,
              paddingStart: 20,
              actionMenu: SvgPicture.asset(
                Assets.imageBtnNotifications,
                height: 21.h,
                width: 4.8.w,
              ),
              actionMenu2: Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/40x40"),
                    fit: BoxFit.fill,
                  ),
                  shape: OvalBorder(),
                ),
              ),
              title: "Activity",
              bottom: Container(
                width: 250.w,
                height: 34.h,
                child: TabBar(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle: textTab,
                  indicator: BoxDecoration(
                      color: AppColor.home_bg,
                      borderRadius: BorderRadius.circular(20).r),
                  labelStyle: textTab.copyWith(color: Colors.white),
                  tabs: [
                    Tab(
                        icon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17).r,
                      child: Text(
                        "Week",
                      ),
                    )),
                    Tab(
                        icon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17).r,
                      child: Text(
                        "Month",
                      ),
                    )),
                    Tab(
                        icon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17).r,
                      child: Text(
                        "Year",
                      ),
                    )),
                  ],
                ),
              ),
            )),
        body: BottomBar(
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Image.asset(
                  color: currentPage == 0 ? AppColor.home_bg : null,
                  Assets.imageCards,
                  height: 20.r,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  color: currentPage == 1 ? AppColor.home_bg : null,
                  Assets.imageAnalytics,
                  height: 20.r,
                ),
              )
            ],
          ),
          borderRadius: BorderRadius.circular(16).r,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: Colors.white,
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [ActivityPage(), ActivityPage()],
          ),
        ),
      ),
    );
  }
}
