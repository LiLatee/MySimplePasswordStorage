import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef void ShowColorPicker({required bool isShowNeeded});

class ChooseColorSelectedDropdownMenuItem extends DropdownMenuItem {
  final ShowColorPicker? showColorPickerCallback;
  final Widget icon;
  final BuildContext context;

  ChooseColorSelectedDropdownMenuItem({
    Key? key,
    this.showColorPickerCallback,
    required this.icon,
    required this.context,
  }) : super(
            onTap: () {
              if (showColorPickerCallback != null)
                showColorPickerCallback(isShowNeeded: true);
            },
            value: "Choose color",
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MyConstants.defaultPadding / 2,
                ),
                icon,
                // MyFunctions.generateRandomColorIconAsWidget(
                //   name: 'A',
                //   color: MyConstants.iconDefaultColors[5],
                // ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.selectIcon,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ));
}
