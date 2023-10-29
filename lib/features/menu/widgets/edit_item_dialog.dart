import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:munchmate_admin/models/item.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';
import '../../../providers/menu_provider.dart';

class EditItemDialog extends StatefulWidget {
  const EditItemDialog({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
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

  List<TextEditingController> textEditingControllers =
      List<TextEditingController>.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void initState() {
    textEditingControllers[0].text = widget.item.name;
    textEditingControllers[1].text = widget.item.category;
    textEditingControllers[2].text = widget.item.price.toString();
    textEditingControllers[3].text = widget.item.totalQuantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController textEditingController
        in textEditingControllers) {
      textEditingController.dispose();
    }
    super.dispose();
  }

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
              "Edit Item",
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
                          child: Image.network(
                            Provider.of<MenuProvider>(context, listen: true)
                                        .imageUrl ==
                                    ""
                                ? widget.item.imageUrl
                                : Provider.of<MenuProvider>(context,
                                        listen: true)
                                    .imageUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pickImage(widget.item.id);
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
                        enableSearch: false,
                        controller: textEditingControllers[1],
                        initialSelection: widget.item.category,
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
                        autofocus: true,
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
                    SizedBox(
                      width: screenWidth * 0.2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    "Delete",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green),
                                ),
                                onPressed: () {
                                  Item item = Item(
                                    id: widget.item.id,
                                    name: textEditingControllers[0].text,
                                    category: textEditingControllers[1].text,
                                    price: int.parse(
                                        textEditingControllers[2].text),
                                    imageUrl: Provider.of<MenuProvider>(context,
                                                    listen: false)
                                                .imageUrl ==
                                            ""
                                        ? widget.item.imageUrl
                                        : Provider.of<MenuProvider>(context,
                                                listen: false)
                                            .imageUrl,
                                    isAvailable: widget.item.isAvailable,
                                    totalQuantity: int.parse(
                                        textEditingControllers[3].text),
                                    deliveredQuantity:
                                        widget.item.deliveredQuantity,
                                    lastUpdated: DateTime.now()
                                        .toUtc()
                                        .millisecondsSinceEpoch,
                                  );
                                  Provider.of<MenuProvider>(context,
                                          listen: false)
                                      .updateItem(item);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  child: const Text(
                                    "Save",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
