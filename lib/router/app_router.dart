import 'package:auto_route/auto_route.dart';
import 'package:flutter_demo_structure/ui/activity/activity_screen.dart';
import 'package:flutter_demo_structure/ui/activity/bottom_navigation_bar.dart';
import 'package:flutter_demo_structure/ui/statement/statement_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: StatementRoute.page, initial: true),
    AutoRoute(page: ActivityRoute.page),
    AutoRoute(page: BottomNavigationBarDemoRoute.page),
  ];
}
