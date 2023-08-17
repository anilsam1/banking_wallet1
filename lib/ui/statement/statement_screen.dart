import 'package:auto_route/annotations.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/generated/l10n.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/header_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  static List<PieChartSectionData> data = [
    PieChartSectionData(
      value: 10,
      color: AppColor.piePink,
    ),
    PieChartSectionData(
      value: 15,
      color: AppColor.pieYellow,
    ),
    PieChartSectionData(
      value: 30,
      color: AppColor.pieRed,
    ),
    PieChartSectionData(
      value: 25,
      color: AppColor.pieGreen,
    ),
    PieChartSectionData(
      value: 25,
      color: AppColor.pieBlue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.home_bg,
        appBar: PreferredSize(
            preferredSize: Size(0, 62.h),
            child: AppBarWidget(
              backgroundColor: AppColor.home_bg,
              paddingStart: 20,
              actionMenu: SvgPicture.asset(
                Assets.imageDotMenu,
                height: 21.h,
                width: 4.8.w,
              ),
              title: S.current.homeTitle,
            )),
        body: DraggableBottomSheet(
          minExtent: 261.h,
          useSafeArea: false,
          curve: Curves.easeIn,
          previewWidget: _previewWidget(),
          expandedWidget: _expandedWidget(),
          backgroundWidget: _backgroundWidget(),
          duration: const Duration(milliseconds: 10),
          maxExtent: MediaQuery.of(context).size.height * 0.8,
          onDragging: (pos) {},
        ),
      ),
    );
  }

  Padding _backgroundWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          27.verticalSpace,
          _statementHeader(),
          16.verticalSpace,
          Divider(
            height: 1.h,
            color: AppColor.white,
          ),
          46.verticalSpace,
          pieChartBuild(),
          39.verticalSpace,
          pieIndicators(),
        ],
      ),
    );
  }

  Widget pieIndicators() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  indicator(color: AppColor.pieBlue, title: S.current.pieFood),
                  8.verticalSpace,
                  indicator(
                      color: AppColor.piePink, title: S.current.pieTransport),
                  8.verticalSpace,
                  indicator(
                      color: AppColor.pieYellow, title: S.current.pieInvestment)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  indicator(color: AppColor.pieRed, title: S.current.pieRent),
                  8.verticalSpace,
                  indicator(
                      color: AppColor.pieGreen,
                      title: S.current.pieInstallment),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row indicator({required Color color, required String title}) {
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 14.h,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4).r),
          ),
        ),
        16.horizontalSpace,
        Text(
          title,
          style: textNormal,
        )
      ],
    );
  }

  Widget pieChartBuild() {
    return Container(
      height: 168.h,
      width: 168.w,
      decoration: BoxDecoration(
          color: Color(0XFF4E4880), borderRadius: BorderRadius.circular(120).r),
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 40.r,
          sections: data,
        ),
      ),
    );
  }

  Widget _statementHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(S.current.year, style: textNormal),
        Row(
          children: [
            Text(S.current.month, style: textHomeBold),
            Spacer(),
            Text(S.current.money, style: textHomeBold)
          ],
        )
      ],
    );
  }

  Widget _previewWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          23.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              moneyCal("Spent", "\$ 1.250"),
              49.horizontalSpace,
              Container(
                height: 58.h,
                width: 1.w,
                color: Color(0xffC4C4C4),
              ),
              49.horizontalSpace,
              moneyCal("Earned", "\$ 54.500"),
            ],
          ),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.pieBlue,
              onPink: Colors.transparent,
              onYellow: Colors.transparent,
              onGreen: Colors.transparent,
              onRed: Colors.transparent,
              title: 'Food',
              percentage: '25%',
              prize: '\$ 4,499'),
          _detailDevider(),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.transparent,
              onPink: AppColor.piePink,
              onYellow: AppColor.transparent,
              onGreen: Colors.transparent,
              onRed: Colors.transparent,
              title: S.current.pieTransport,
              percentage: '10%',
              prize: '\$ 2,234'),
        ],
      ),
    );
  }

  Padding _detailDevider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28).r,
      child: Container(
        height: 1.h,
        width: 1.sw,
        color: Colors.grey.withOpacity(0.4),
      ),
    );
  }

  Widget _singlePieDetails(
      {required Color onBlue,
      required Color onPink,
      required Color onYellow,
      required Color onRed,
      required Color onGreen,
      required String title,
      required String percentage,
      required String prize}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43).r,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 45.r,
                  width: 45.r,
                  child: Stack(
                    children: [
                      PieChart(
                        PieChartData(
                          centerSpaceRadius: 20.r,
                          sections: [
                            PieChartSectionData(
                                color: Color(0xffF3F3F3), radius: 10),
                          ],
                        ),
                      ),
                      PieChart(
                        PieChartData(
                          centerSpaceRadius: 15.r,
                          sections: [
                            PieChartSectionData(
                              showTitle: false,
                              value: 10,
                              radius: 15,
                              color: onPink,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 15,
                              radius: 15,
                              color: onYellow,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 30,
                              radius: 15,
                              color: onRed,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 25,
                              radius: 15,
                              color: onGreen,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              value: 25,
                              radius: 15,
                              color: onBlue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              24.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: textRegular,
                  ),
                  17.verticalSpace,
                  Text(
                    percentage,
                    style: textRegular.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Text(
                prize,
                style: textRegular,
              ),
            ],
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Column moneyCal(String title, String money) {
    return Column(
      children: [
        Text(
          title,
          style: textNormal.copyWith(color: Colors.black),
        ),
        11.verticalSpace,
        Text(
          money,
          style: textBoldE,
        )
      ],
    );
  }

  Widget _expandedWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        physics: FixedExtentScrollPhysics(),
        children: <Widget>[
          23.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              moneyCal("Spent", "\$ 1.250"),
              49.horizontalSpace,
              Container(
                height: 58.h,
                width: 1.w,
                color: Color(0xffC4C4C4),
              ),
              49.horizontalSpace,
              moneyCal("Earned", "\$ 54.500"),
            ],
          ),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.pieBlue,
              onPink: Colors.transparent,
              onYellow: Colors.transparent,
              onGreen: Colors.transparent,
              onRed: Colors.transparent,
              title: S.current.pieFood,
              percentage: '25%',
              prize: '\$ 4,499'),
          _detailDevider(),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.transparent,
              onPink: AppColor.piePink,
              onYellow: AppColor.transparent,
              onGreen: Colors.transparent,
              onRed: Colors.transparent,
              title: S.current.pieTransport,
              percentage: '10%',
              prize: '\$ 2,234'),
          _detailDevider(),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.transparent,
              onPink: AppColor.transparent,
              onYellow: AppColor.pieYellow,
              onGreen: AppColor.transparent,
              onRed: Colors.transparent,
              title: S.current.pieInvestment,
              percentage: '15%',
              prize: '\$ 4,499'),
          _detailDevider(),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.transparent,
              onPink: AppColor.transparent,
              onYellow: Colors.transparent,
              onGreen: AppColor.pieGreen,
              onRed: Colors.transparent,
              title: S.current.pieInstallment,
              percentage: '30%',
              prize: '\$ 4,499'),
          _detailDevider(),
          20.verticalSpace,
          _singlePieDetails(
              onBlue: AppColor.transparent,
              onPink: AppColor.transparent,
              onYellow: Colors.transparent,
              onGreen: Colors.transparent,
              onRed: AppColor.pieRed,
              title: S.current.pieRent,
              percentage: '25%',
              prize: '\$ 4,499'),
        ],
      ),
    );
  }
}
