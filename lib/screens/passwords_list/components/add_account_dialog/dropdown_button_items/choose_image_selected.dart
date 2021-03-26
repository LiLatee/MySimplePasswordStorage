import 'package:flutter/material.dart';
import '../../../../../utils/AppConstants.dart' as MyConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseImageSelectedDropdownMenuItem extends DropdownMenuItem {
  final Widget chooseImageIcon;
  final BuildContext context;

  ChooseImageSelectedDropdownMenuItem({
    Key? key,
    required this.chooseImageIcon,
    required this.context
  }) : super(
            value: 'Choose image',
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MyConstants.defaultPadding / 2,
                ),
                chooseImageIcon,
                Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.selectIcon,
                  textAlign: TextAlign.center,
                )),
              ],
            ));
}
