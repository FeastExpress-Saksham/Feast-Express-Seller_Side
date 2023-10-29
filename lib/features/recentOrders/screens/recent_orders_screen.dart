import 'package:flutter/material.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
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
    "Ordered At",
    "Order ID",
    "Ordered By",
    "Items",
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
                  0: IntrinsicColumnWidth(flex: 0.85),
                  3: IntrinsicColumnWidth(flex: 2),
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
                      3: IntrinsicColumnWidth(flex: 3.5),
                      4: IntrinsicColumnWidth(flex: 1.25),
                    },
                    children: List<TableRow>.generate(
                      lastOrders.length,
                      (index) {
                        List<List<bool>> isDelivered =
                            List<List<bool>>.generate(
                          lastOrders.length,
                          (ind) => [
                            lastOrders[ind].isDelivered == true,
                            lastOrders[ind].isDelivered == false,
                          ],
                        );
                        DateTime orderDateTime =
                            DateTime.fromMillisecondsSinceEpoch(
                                lastOrders[index].dateTime);
                        if (localUsers[lastOrders[index].orderedBy] == null) {
                          return TableRow(
                            children: List.generate(
                              tableHeadings.length,
                              (index) => Container(),
                            ),
                          );
                        }
                        return TableRow(
                          decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                              BorderSide(
                                  color: AppColors.primaryColor, width: 0.001),
                            ),
                          ),
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                "${(orderDateTime.hour > 12) ? (orderDateTime.hour - 12 < 10) ? '0${orderDateTime.hour - 12}' : orderDateTime.hour - 12 : orderDateTime.hour}:${(orderDateTime.minute < 10) ? '0${orderDateTime.minute}' : orderDateTime.minute} ${(orderDateTime.hour > 12) ? "PM" : "AM"}\n${weekDaysName[orderDateTime.weekday - 1]}\n${orderDateTime.day} ${monthsName[orderDateTime.month - 1]} ${orderDateTime.year}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                lastOrders[index].id.replaceRange(0, 20, ""),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                        localUsers[lastOrders[index].orderedBy]!
                                            .photoURL,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      localUsers[lastOrders[index].orderedBy]!
                                          .name
                                          .split(" ")
                                          .first,
                                      overflow: TextOverflow.ellipsis,
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
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        lastOrders[index]
                                            .itemCounts[ind]
                                            .toString(),
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
                                      .toggleDeliveryStatus(lastOrders[index]);
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
