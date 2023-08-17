import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/model/activity_per_details.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<ActivityPerModel> dataOfList = [
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "Olivia Johanson",
        prize: 432.9,
        time: "3.30 Am"),
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "James O’Coner",
        prize: 40,
        time: "3.30 Am"),
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "Devid Warner",
        prize: 600,
        time: "3.30 Am"),
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "Olivia Johanson",
        prize: 432.9,
        time: "3.30 Am"),
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "James O’Coner",
        prize: 40,
        time: "3.30 Am"),
    ActivityPerModel(
        image: "https://picsum.photos/200",
        name: "Devid Warner",
        prize: 600,
        time: "3.30 Am"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        /*  appBar: PreferredSize(
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
            )),*/
        body: Column(
          children: [
            35.verticalSpace,
            lineChart(context),
            42.verticalSpace,
            Row(
              children: [
                28.horizontalSpace,
                Text(
                  "All",
                  style: textTab.copyWith(color: AppColor.home_bg),
                ),
                25.horizontalSpace,
                Text(
                  "Expanse",
                  style: textTab,
                ),
                25.horizontalSpace,
                Text(
                  "Income",
                  style: textTab,
                )
              ],
            ),
            29.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: dataOfList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28).r,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              child: Image.network(dataOfList[index].image,
                                  height: 51.r),
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                            22.horizontalSpace,
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        dataOfList[index].name,
                                        style: textMedium.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Text(
                                        "-\$ ${dataOfList[index].prize}",
                                        style:
                                            textBoldE.copyWith(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                  8.verticalSpace,
                                  Row(
                                    children: [
                                      Text("Transfer",
                                          style: textNormal.copyWith(
                                              color: Color(0xff6B6B6B))),
                                      Spacer(),
                                      Text(dataOfList[index].time)
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        20.verticalSpace
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget lineChart(BuildContext context) {
    List<LineChartBarData> lineChartBarData = [
      LineChartBarData(
        color: Colors.green,
        belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [
              Color(0xff009F5E).withOpacity(0.2),
              Colors.transparent,
            ], begin: Alignment(0, 0), end: Alignment(0, 1))),
        dotData: FlDotData(show: false),
        spots: [
          FlSpot(1, 0),
          FlSpot(2, 4),
          FlSpot(3, 2.4),
          FlSpot(4, 9),
          FlSpot(4.3, 6),
          FlSpot(6, 13),
          FlSpot(7, 5),
          FlSpot(7.3, 9),
          FlSpot(9.6, 13),
          FlSpot(10, 23),
          FlSpot(11, 17),
          FlSpot(12, 20),
        ],
      ),
    ];
    return Container(
      height: 168.h,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (value) {
                    return value
                        .map((e) => LineTooltipItem(
                            " ${e.y.toStringAsFixed(2)} ${e.y < 0 ? 'Expense:' : 'USD'} \n  ",
                            children: [
                              TextSpan(
                                  text: "2 Jun, 05:41 UTC",
                                  style: textNormal.copyWith(
                                      color: Color(0xff979797)))
                            ],
                            textNormal.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)))
                        .toList();
                  },
                  tooltipBgColor: Colors.white)),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text((value.toInt() > 0 && value.toInt() <= 12)
                        ? months[value.toInt() - 1]
                        : ''),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: lineChartBarData,
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(drawHorizontalLine: false, verticalInterval: 1),
        ),
      ),
    );
  }
}
