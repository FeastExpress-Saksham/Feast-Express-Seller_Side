import 'package:flutter/material.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.tileTitle,
    required this.imageAssetName,
    required this.index,
  });

  final String tileTitle;
  final int index;
  final String imageAssetName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Provider.of<HomeProvider>(context).selectedScreenIndex == index
          ? AppColors.darkPrimaryColor
          : AppColors.primaryColor,
      minVerticalPadding: 30,
      title: Text(
        tileTitle,
        style: const TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      leading: Image(
        image: AssetImage(imageAssetName),
        color: AppColors.whiteColor,
        height: 30,
        alignment: Alignment.bottomCenter,
        fit: BoxFit.contain,
      ),
      onTap: () {
        if (Provider.of<HomeProvider>(context, listen: false)
                .selectedScreenIndex !=
            index) {
          Provider.of<HomeProvider>(context, listen: false)
              .updateSelectedScreenIndex(index);
        }
      },
    );
  }
}
