import 'package:flutter/material.dart';
import 'package:munchmate_admin/common/utils/colors.dart';

import '../../../models/item.dart';

class MenuScreen extends StatefulWidget {
  final String tileTitle = "Menu";
  final String imageAssetName = "assets/images/dashboard.png";
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<TextEditingController> textEditingControllers =
      List<TextEditingController>.generate(
    4,
    (index) => TextEditingController(),
  );

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

  final List<Item> items = [
    Item(
      id: "1",
      name: "Chhole Bhature",
      category: "Meals",
      price: 60,
      imageUrl:
          "https://tse4.mm.bing.net/th?id=OIP.GfIF5YZwxLwFKwW3RJndIgHaFj&pid=Api&P=0&h=180",
      isAvailable: false,
      totalQuantity: 50,
      deliveredQuantity: 10,
    ),
    Item(
      id: "2",
      name: "Chhole Kulche",
      category: "Snacks",
      price: 40,
      imageUrl:
          "https://tse4.mm.bing.net/th?id=OIP.GfIF5YZwxLwFKwW3RJndIgHaFj&pid=Api&P=0&h=180",
      isAvailable: false,
      totalQuantity: 50,
      deliveredQuantity: 10,
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
                            builder: (context) => Dialog(
                              backgroundColor: AppColors.whiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Add Item",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Form(
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        width: screenWidth * 0.35,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/food.png",
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.camera_alt_rounded,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 25, 15, 15),
                                              width: screenWidth * 0.2,
                                              child: TextFormField(
                                                autofocus: true,
                                                controller:
                                                    textEditingControllers[0],
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  labelText: "Item Name",
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              child: DropdownMenu(
                                                controller:
                                                    textEditingControllers[1],
                                                label: const Text("Category"),
                                                width: screenWidth * 0.2,
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                dropdownMenuEntries: const [
                                                  DropdownMenuEntry(
                                                    value: "Snacks",
                                                    label: "Snacks",
                                                  ),
                                                  DropdownMenuEntry(
                                                    value: "Drinks",
                                                    label: "Drinks",
                                                  ),
                                                  DropdownMenuEntry(
                                                    value: "Meals",
                                                    label: "Meals",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              width: screenWidth * 0.2,
                                              child: TextFormField(
                                                controller:
                                                    textEditingControllers[2],
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  labelText: "Price",
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              width: screenWidth * 0.2,
                                              child: TextFormField(
                                                controller:
                                                    textEditingControllers[3],
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  labelText: "Quantity",
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              width: screenWidth * 0.2,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: const Text(
                                                    "Add",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
