import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:munchmate_admin/models/item.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';
import '../../../providers/menu_provider.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    super.key,
  });

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  Future<void> pickImage(String itemID) async {
    PlatformFile? pickedImage;
    final filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (filePickerResult == null) return;
    pickedImage = filePickerResult.files.first;
    uploadImage(pickedImage.bytes!, itemID);
  }

  Future<void> uploadImage(Uint8List imageData, String itemID) async {
    Provider.of<MenuProvider>(context, listen: false)
        .uploadImage(imageData, itemID);
  }

  final List<TextEditingController> textEditingControllers =
      List<TextEditingController>.generate(
    4,
    (index) => TextEditingController(),
  );
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Provider.of<MenuProvider>(context).imageUrl ==
                                  ""
                              ? Image.asset(
                                  "assets/images/food.png",
                                  color: AppColors.whiteColor,
                                )
                              : Image.network(
                                  Provider.of<MenuProvider>(context).imageUrl,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            int noOfItems = Provider.of<MenuProvider>(context,
                                    listen: false)
                                .items
                                .length;
                            pickImage("ITEM${noOfItems + 1}");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.whiteColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                      width: screenWidth * 0.2,
                      child: TextFormField(
                        autofocus: true,
                        controller: textEditingControllers[0],
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Item Name",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: DropdownMenu(
                        controller: textEditingControllers[1],
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
                        controller: textEditingControllers[2],
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Price",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      width: screenWidth * 0.2,
                      child: TextFormField(
                        controller: textEditingControllers[3],
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Quantity",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      width: screenWidth * 0.2,
                      child: ElevatedButton(
                        onPressed: () {
                          int noOfItems =
                              Provider.of<MenuProvider>(context, listen: false)
                                  .items
                                  .length;
                          Item item = Item(
                            id: "ITEM${noOfItems + 1}",
                            name: textEditingControllers[0].text,
                            category: textEditingControllers[1].text,
                            price: int.parse(textEditingControllers[2].text),
                            imageUrl: Provider.of<MenuProvider>(context,
                                    listen: false)
                                .imageUrl,
                            isAvailable: false,
                            totalQuantity:
                                int.parse(textEditingControllers[3].text),
                            deliveredQuantity: 0,
                          );
                          Provider.of<MenuProvider>(context, listen: false)
                              .addItem(item);
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          padding: const EdgeInsets.all(8),
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
    );
  }
}
