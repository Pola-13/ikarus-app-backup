import 'package:flutter/material.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/stations.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/wallet.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/sessions.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/more.dart';
import 'package:ikarusapp/features/base/presentation/widgets/custom_bottom_nav.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index); // INSTANT SWITCH
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          StationPage(),
          WalletPage(),
          SessionsPage(),
          MorePage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
