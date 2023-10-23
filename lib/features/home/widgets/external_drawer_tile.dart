import 'package:flutter/material.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/colors.dart';

class ExternalDrawerTile extends StatelessWidget {
  const ExternalDrawerTile({
    super.key,
    required this.tileTitle,
    required this.imageAssetName,
  });

  final String tileTitle;
  final String imageAssetName;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Provider.of<HomeProvider>(context).selectedScreenTileTitle ==
              tileTitle
          ? AppColors.darkPrimaryColor
          : AppColors.primaryColor,
      child: ListTile(
        minVerticalPadding: 25,
        title: Image(
          image: AssetImage(imageAssetName),
          color: AppColors.whiteColor,
          height: 30,
          alignment: Alignment.bottomCenter,
          fit: BoxFit.contain,
        ),
        titleAlignment: ListTileTitleAlignment.center,
        onTap: () {
          if (Provider.of<HomeProvider>(context, listen: false)
                  .selectedScreenTileTitle !=
              tileTitle) {
            Provider.of<HomeProvider>(context, listen: false)
                .updateSelectedScreenIndex(tileTitle);
          }
        },
      ),
    );
  }
}
