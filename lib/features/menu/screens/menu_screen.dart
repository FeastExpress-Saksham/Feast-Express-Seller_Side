import 'package:flutter/material.dart';
import 'package:munchmate_admin/common/utils/colors.dart';
import 'package:munchmate_admin/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/item.dart';
import '../widgets/add_item_dialog.dart';
import '../widgets/edit_item_dialog.dart';

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
    "Edit"
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
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Tooltip(
                  message: "Add Item",
                  child: Container(
                    height: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddItemDialog(),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    "MENU",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: AppColors.primaryColor),
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
                    children: List<TableRow>.generate(
                      Provider.of<MenuProvider>(context).items.length,
                      (index) {
                        List<List<bool>> isAvailable =
                            List<List<bool>>.generate(
                          Provider.of<MenuProvider>(context).items.length,
                          (ind) => [
                            Provider.of<MenuProvider>(context)
                                    .items[ind]
                                    .isAvailable ==
                                true,
                            Provider.of<MenuProvider>(context)
                                    .items[ind]
                                    .isAvailable ==
                                false,
                          ],
                        );
                        return TableRow(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                items[index].id,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                items[index].category,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              height: 55,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage:
                                    NetworkImage(items[index].imageUrl),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                items[index].name,
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
                                "₹ ${items[index].price.toString()}",
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
                                fillColor: isAvailable[index][0] == true
                                    ? Colors.green
                                    : Colors.red,
                                onPressed: (i) {
                                  Provider.of<MenuProvider>(context,
                                          listen: false)
                                      .toggleAvailability(index);
                                },
                                isSelected: isAvailable[index],
                                children: [
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: isAvailable[index][0] == true
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    "No",
                                    style: TextStyle(
                                      color: isAvailable[index][0] == true
                                          ? AppColors.blackColor
                                          : AppColors.whiteColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                items[index].deliveredQuantity.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                items[index].totalQuantity.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: "Edit Item",
                              child: Container(
                                height: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EditItemDialog(item: items[index]),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
