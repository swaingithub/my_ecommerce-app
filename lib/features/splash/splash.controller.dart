import 'package:fluxy/fluxy.dart';

class SplashController extends FluxController {
  SplashController() {
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Fluxy.offAll('/auth');
  }
}
