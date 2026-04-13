import 'package:ecommerce_mobile_app/router/route_name.dart';
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
  ],
);
