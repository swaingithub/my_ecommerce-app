import 'package:fluxy/fluxy.dart';
import 'home.view.dart';
import 'home.controller.dart';
import 'product_detail.view.dart';
import '../checkout/checkout.view.dart';
import '../profile/personal_info.view.dart';
import '../profile/shipping_address.view.dart';
import '../profile/payment_method.view.dart';
import '../splash/splash.view.dart';
import '../splash/splash.controller.dart';
import '../auth/auth.view.dart';
import '../auth/auth.controller.dart';

final homeRoutes = [
  FxRoute(
    path: '/splash',
    controller: () => SplashController(),
    builder: (params, args) => SplashView(controller: SplashController()),
  ),
  FxRoute(
    path: '/auth',
    controller: () => AuthController(),
    builder: (params, args) => AuthView(controller: AuthController()),
  ),
  FxRoute(
    path: '/home',
    controller: () => HomeController(),
    builder: (params, args) => const HomeView(),
  ),
  FxRoute(
    path: '/product',
    controller: () => HomeController(),
    builder: (params, args) {
      final arguments = args as Map<String, dynamic>;
      return ProductDetailView(
        product: arguments['product'] as Product,
        controller: arguments['controller'] as HomeController,
      );
    },
  ),
  FxRoute(
    path: '/checkout',
    builder: (params, args) => CheckoutView(
      controller: args != null 
        ? (args as Map<String, dynamic>)['controller'] as HomeController 
        : HomeController(),
    ),
  ),
  FxRoute(
    path: '/shipping',
    builder: (params, args) => ShippingAddressView(
       controller: args != null 
         ? (args as Map<String, dynamic>)['controller'] as HomeController 
         : HomeController(),
    ),
  ),
  FxRoute(
    path: '/payment',
    builder: (params, args) => PaymentMethodView(
       controller: args != null 
         ? (args as Map<String, dynamic>)['controller'] as HomeController 
         : HomeController(),
    ),
  ),
  FxRoute(
    path: '/personal-info',
    builder: (params, args) => PersonalInfoView(
      controller: args != null 
        ? (args as Map<String, dynamic>)['controller'] as HomeController 
        : HomeController(),
    ),
  ),
];
