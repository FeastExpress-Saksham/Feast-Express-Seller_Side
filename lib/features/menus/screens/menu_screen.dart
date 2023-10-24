import 'package:flutter/material.dart';
import 'package:munchmate_admin/common/utils/colors.dart';
import 'package:munchmate_admin/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/item.dart';
import '../widgets/add_item_dialog.dart';

class MenuScreen extends StatefulWidget {
  final String tileTitle = "Menu";
  final String imageAssetName = "assets/images/dashboard.png";
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<String> tableHeadings = [
    "ItemID",
    "Category",
    "Image",
    "Name",
    "Price",
    "Available",
    "Delivered",
    "Total Quantity",
    "Options"
  ];

  List<Item> items = [];

  @override
  void didChangeDependencies() {
    Provider.of<MenuProvider>(context, listen: false).getItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    items = Provider.of<MenuProvider>(context).items;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Menu",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(
                        child: Text(
                          "Items Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const AddItemDialog(),
                          );
                        },
                        child: const Text(
                          "Add Item",
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List<TableRow>.generate(
                        items.length + 1,
                        (index) {
                          return (index == 0)
                              ? TableRow(
                                  children: List<Widget>.generate(
                                    tableHeadings.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Text(
                                        tableHeadings[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : TableRow(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1].id,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1].category,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerLeft,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            items[index - 1].imageUrl),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1].name,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1].price.toString(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1].isAvailable.toString(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1]
                                            .deliveredQuantity
                                            .toString(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        items[index - 1]
                                            .totalQuantity
                                            .toString(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Edit",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
