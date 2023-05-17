import 'package:flutter/material.dart';
import 'package:mobibazar/routes.dart';
import 'package:mobibazar/store.dart';
import 'package:mobibazar/thene.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Splash_Screen.dart';
import 'Splash_Screen.dart';
import 'cart_page.dart';
import 'home_detail_page.dart';
import 'home_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vxNavigator = VxNavigator(routes: {
      "/": (_, __) => MaterialPage(child: SplashScreen()), // Splash screen route
      MyRoutes.homeRoute: (_, __) => MaterialPage(child: HomePage()),
      // Rest of the routes..
    MyRoutes.homeDetailsRoute: (uri, _) {
        final catalog = (VxState.store as MyStore)
            .catalog
            .getById(int.parse(uri.queryParameters["id"]!));
        return MaterialPage(
            child: HomeDetailPage(
              catalog: catalog, key: null!,
            ));
      },
      MyRoutes.SplachScreen: (_, __) => MaterialPage(child: HomePage()),
      MyRoutes.cartRoute: (_, __) => MaterialPage(child: CartPage()),
    });
    (VxState.store as MyStore).navigator = vxNavigator;

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      routeInformationParser: VxInformationParser(),
      routerDelegate: vxNavigator,
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(
          location: MyRoutes.SplachScreen,
        ),
      ),
    );
  }
}
