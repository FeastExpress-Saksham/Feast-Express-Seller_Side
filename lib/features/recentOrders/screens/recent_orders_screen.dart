import 'package:flutter/material.dart';

class RecentOrdersScreen extends StatefulWidget {
  final String tileTitle = "Recent Orders";
  final String imageAssetName = "assets/images/recent.png";
  const RecentOrdersScreen({super.key});

  @override
  State<RecentOrdersScreen> createState() => _RecentOrdersScreenState();
}

class _RecentOrdersScreenState extends State<RecentOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
