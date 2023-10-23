import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/contactUs/screens/contact_us_screen.dart';
import 'package:munchmate_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:munchmate_admin/features/menus/screens/menu_screen.dart';
import 'package:munchmate_admin/features/recentOrders/screens/recent_orders_screen.dart';
import 'package:munchmate_admin/features/reportProblem/screens/report_problem_screen.dart';

import '../../../common/utils/colors.dart';
import '../widgets/drawer_header.dart';
import '../widgets/drawer_tile.dart';
import '../widgets/external_drawer_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screens = const [
    DashboardScreen(),
    RecentOrdersScreen(),
    MenuScreen(),
    ReportProblemScreen(),
    ContactUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawerEdgeDragWidth: screenWidth * 0.2,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEnableOpenDragGesture: true,
      resizeToAvoidBottomInset: true,
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
        child: Builder(builder: (context) {
          return SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.06,
                  color: AppColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DrawerHeader(
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.6,
                        child: ListView.builder(
                          itemCount: screens.length,
                          itemBuilder: (context, index) {
                            return ExternalDrawerTile(
                              tileTitle: screens[index].tileTitle,
                              imageAssetName: screens[index].imageAssetName,
                            );
                          },
                        ),
                      ),
                      ListTile(
                        minVerticalPadding: 20,
                        title: const Image(
                          image: AssetImage("assets/images/logout.png"),
                          color: AppColors.whiteColor,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                screens[0],
              ],
            ),
          );
        }),
      ),
    );
  }
}
