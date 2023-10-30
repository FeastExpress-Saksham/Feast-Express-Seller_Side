import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/contactUs/screens/contact_us_screen.dart';
import 'package:munchmate_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:munchmate_admin/features/recentOrders/screens/recent_orders_screen.dart';
import 'package:munchmate_admin/features/reportProblem/screens/report_problem_screen.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';
import '../../../providers/recent_orders_provider.dart';
import '../../menu/screens/menu_screen.dart';
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
    Provider.of<OrderProvider>(context).getLastOrders();
    Provider.of<HomeProvider>(context).getLocalUsers();
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
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: screenWidth * 0.02,
            backgroundImage: const NetworkImage(
              "https://thumbs.dreamstime.com/z/smiling-teen-boy-character-portrait-d-cartoon-style-handsome-generic-white-clean-background-digital-painting-movies-281956632.jpg",
            ),
          ),
        ),
        title: const Text("Welcome, Ved"),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const SearchBar(
              elevation: MaterialStatePropertyAll(0),
              leading: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) {
                return Container(
                  width: screenWidth * 0.05,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
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
                    ],
                  ),
                );
              },
            ),
            screens[_selectedScreenIndex],
          ],
        ),
      ),
    );
  }
}
