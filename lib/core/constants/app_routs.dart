import 'package:flutter/material.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/chargingdetails.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_almaadai.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/receipt.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/startcharging.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/createpassword.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/forgetpassword/forgetpassword1.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/forgetpassword/forgetpassword2.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/forgetpassword/forgetpassword3.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/login.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/more.dart';
import 'package:ikarusapp/root.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/sessions.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/sessions_history.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/signup.dart';
import 'package:ikarusapp/features/general_management/presentation/screens/splash.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/stations.dart';
import 'package:ikarusapp/features/authentication_management/presentation/screens/verifyemail.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/wallet.dart';
import 'package:ikarusapp/features/base/presentation/widgets/lowerbalance.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyEmail = "/verifyemail";
  static const String createPassword = "/createpassword";
  static const String forgetPass1 = "/forgetpass1";
  static const String forgetPass2 = "/forgetpass2";
  static const String forgetPass3 = "/forgetpass3";

  static const String stations = "/stations";
  static const String wallet = "/wallet";
  static const String more = "/more";

  static const String videoSplash = "/video-splash";
  static const String zahraaAlmaadai = "/zahraa-Almadai";

  static const String startcharge = "/startcharge";
  static const String viewreceipt = "/viewreceipt";
  static const String chargingdetails = "/chargingdetails";
  static const String sessionspage = "/sessionspage";

  static const String sessionshistory = "/sessionshistory";
  static const String lowbalance = "/lowbalance";

  static const String root = "/root";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const Splash());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const Signup());

      case Routes.verifyEmail:
        return MaterialPageRoute(builder: (_) => const Verifyemail());

      case Routes.createPassword:
        return MaterialPageRoute(builder: (_) => const CreatePassword());

      case Routes.forgetPass1:
        return MaterialPageRoute(builder: (_) => const Forgetpassword1());

      case Routes.forgetPass2:
        return MaterialPageRoute(builder: (_) => const Forgetpassword2());

      case Routes.forgetPass3:
        return MaterialPageRoute(builder: (_) => const ResetPassword());

      case Routes.stations:
        return MaterialPageRoute(builder: (_) => const StationPage());

      case Routes.wallet:
        return MaterialPageRoute(builder: (_) => const WalletPage());

      case Routes.more:
        return MaterialPageRoute(builder: (_) => const MorePage());

      case Routes.zahraaAlmaadai:
        return MaterialPageRoute(builder: (_) => const ZahraaAlmaadai());

      case Routes.startcharge:
        return MaterialPageRoute(builder: (_) => const ZahraaStartCharging());

      case Routes.viewreceipt:
        return MaterialPageRoute(builder: (_) => const ViewReceipt());

      case Routes.chargingdetails:
        return MaterialPageRoute(builder: (_) => const ChargingDetails());

      case Routes.sessionspage:
        return MaterialPageRoute(builder: (_) => const SessionsPage());

      case Routes.sessionshistory:
        return MaterialPageRoute(builder: (_) => const SessionsHistory());

      case Routes.root:
        return MaterialPageRoute(builder: (_) => const Root());

      // case Routes.lowbalance:
      //   return MaterialPageRoute(builder: (_) => const LowBalanceNotification ());

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => const Scaffold(body: Center(child: Text("Route not found"))),
    );
  }
}

// Navigator.pushNamed(context, Routes.login);
