import 'package:ecommerce_mobile_app/models/response/address_response.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/address/add_address_screen.dart';
import 'package:ecommerce_mobile_app/screens/address/address_screen.dart';
import 'package:ecommerce_mobile_app/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_mobile_app/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce_mobile_app/screens/sign_up/sign_up_screen.dart';
import 'package:ecommerce_mobile_app/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteName.splash,
  routes: [
    GoRoute(
      path: RouteName.splash,
      name: RouteName.splashRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteName.signIn,
      name: RouteName.signInRoute,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: RouteName.signUp,
      name: RouteName.signUpRoute,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteName.dashboard,
      name: RouteName.dashboardRoute,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: RouteName.address,
      name: RouteName.addressRoute,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: RouteName.addAddress,
      name: RouteName.addAddressRoute,
      builder: (context, state) => AddAddressScreen(
        address: state.extra as AddressResponseModel?,
      ),
    ),
  ],
);
