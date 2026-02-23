import 'package:auto_route/auto_route.dart';
import 'package:tictactoe/shared/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: GameHome.page, initial: true)];
}
