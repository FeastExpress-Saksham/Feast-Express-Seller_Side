import 'package:flutter/material.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';
import '../../../models/order.dart';
import '../../../models/user.dart';
import '../../../providers/recent_orders_provider.dart';

class RecentOrdersScreen extends StatefulWidget {
  final String tileTitle = "Recent Orders";
  final String imageAssetName = "assets/images/recent.png";
  const RecentOrdersScreen({super.key});

  @override
  State<RecentOrdersScreen> createState() => _RecentOrdersScreenState();
}

class _RecentOrdersScreenState extends State<RecentOrdersScreen> {
  final List<String> tableHeadings = [
    "Photo",
    "Name",
    "Order Info",
    "Items",
    "Quantity",
    "Price",
    "Total Price",
    "Delivered",
  ];

  List<Order> lastOrders = [];
  Map<String, LocalUser> localUsers = {};

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getLastOrders();
    for (LocalUser localUser in Provider.of<HomeProvider>(context).localUsers) {
      localUsers[localUser.id] = localUser;
    }
    lastOrders =
        List.from(Provider.of<OrderProvider>(context).lastOrders.reversed);
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: screenHeight,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Text(
              "Recent Orders",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  3: IntrinsicColumnWidth(flex: 1.3),
                  4: IntrinsicColumnWidth(flex: 0.01),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    children: List<Widget>.generate(
                      tableHeadings.length,
                      (index) => Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        child: Text(
                          tableHeadings[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      3: IntrinsicColumnWidth(flex: 3),
                    },
                    children: List<TableRow>.generate(
                      Provider.of<OrderProvider>(context).lastOrders.length,
                      (index) {
                        List<List<bool>> isDelivered =
                            List<List<bool>>.generate(
                          Provider.of<OrderProvider>(context).lastOrders.length,
                          (ind) => [
                            Provider.of<OrderProvider>(context)
                                    .lastOrders[ind]
                                    .isDelivered ==
                                true,
                            Provider.of<OrderProvider>(context)
                                    .lastOrders[ind]
                                    .isDelivered ==
                                false,
                          ],
                        );
                        return TableRow(
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: AppColors.primaryColor, width: 0.2),
                            ),
                          ),
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                              height: 55,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                  localUsers[lastOrders[index].orderedBy]!
                                      .photoURL,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                localUsers[lastOrders[index].orderedBy]!.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(5),
                                    child: Text(
                                      lastOrders[index]
                                          .id
                                          .replaceRange(0, 20, ""),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(5),
                                    child: Text(
                                      lastOrders[index]
                                          .id
                                          .replaceRange(0, 20, ""),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: List.generate(
                                lastOrders[index].items.length,
                                (ind) => TableRow(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          5, 5, 10, 5),
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundImage: NetworkImage(
                                            lastOrders[index]
                                                .items[ind]
                                                .imageUrl),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        lastOrders[index].items[ind].name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        "${lastOrders[index].itemCounts[ind].toString()}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        lastOrders[index]
                                            .items[ind]
                                            .price
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                lastOrders[index].totalPrice.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: ToggleButtons(
                                color: AppColors.primaryColor,
                                fillColor: isDelivered[index][0] == true
                                    ? Colors.green
                                    : Colors.red,
                                onPressed: (i) {
                                  Provider.of<OrderProvider>(context,
                                          listen: false)
                                      .toggleAvailability(index);
                                },
                                isSelected: isDelivered[index],
                                children: [
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: isDelivered[index][0] == true
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    "No",
                                    style: TextStyle(
                                      color: isDelivered[index][0] == true
                                          ? AppColors.blackColor
                                          : AppColors.whiteColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
