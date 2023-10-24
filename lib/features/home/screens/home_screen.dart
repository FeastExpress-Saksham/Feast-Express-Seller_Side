import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/contactUs/screens/contact_us_screen.dart';
import 'package:munchmate_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:munchmate_admin/features/menus/screens/menu_screen.dart';
import 'package:munchmate_admin/features/recentOrders/screens/recent_orders_screen.dart';
import 'package:munchmate_admin/features/reportProblem/screens/report_problem_screen.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';
import '../widgets/drawer_header.dart';
import '../widgets/drawer_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;
  List screens = const [
    DashboardScreen(),
    RecentOrdersScreen(),
    MenuScreen(),
    ReportProblemScreen(),
    ContactUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    _selectedScreenIndex =
        Provider.of<HomeProvider>(context).selectedScreenIndex;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawerEdgeDragWidth: screenWidth * 0.2,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEnableOpenDragGesture: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text("Welcome, Ved"),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const SearchBar(
              leading: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Builder(
          builder: (context) {
            return Drawer(
              width: Scaffold.of(context).isDrawerOpen
                  ? screenWidth * 0.15
                  : screenWidth * 0.05,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              backgroundColor: AppColors.primaryColor,
              shadowColor: Colors.transparent,
              elevation: 0.0,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  DrawerHeaderWidget(screenWidth: screenWidth),
                  SizedBox(
                    height: screenHeight * 0.6,
                    child: ListView.builder(
                      itemCount: screens.length,
                      itemBuilder: (context, index) {
                        return DrawerTile(
                          tileTitle: screens[index].tileTitle,
                          imageAssetName: screens[index].imageAssetName,
                          index: index,
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    leading: const Image(
                      image: AssetImage("assets/images/logout.png"),
                      color: AppColors.whiteColor,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: screens[_selectedScreenIndex],
      ),
    );
  }
}
