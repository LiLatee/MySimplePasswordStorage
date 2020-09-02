import 'package:flutter/material.dart';

import '../../../../components/account_name_field_widget.dart';
import '../../../../components/dialog_template.dart';
import '../../../../models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;
import '../../../../utils/functions.dart' as MyFunctions;
import 'choose_icon_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final Function addAccountCallback;
  final List<AccountData> currentAccounts;

  AddAccountDialog({
    @required this.addAccountCallback,
    @required this.currentAccounts,
  });

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountData accountData = AccountData(accountName: 'Account name');
  final accountNameFormKey = GlobalKey<FormState>();
  Color currentColor = MyConstants.iconDefaultColors[0];
  bool isChosenColorIcon = true;

  void setAccountName({String accountName}) {
    setState(() {
      accountData.accountName = accountName;
      if (isChosenColorIcon) {
        accountData.icon = MyFunctions.generateRandomColorIcon(
          name: accountData.accountName,
          color: currentColor,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      actions: [buildCancelButton(context), buildAddButton(context)],
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            currentAccounts: widget.currentAccounts,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          ChooseIconWidget(
            accountData: accountData,
            setAccountDataCallback: ({accountData}) =>
                this.accountData = accountData,
            setIsChosenColorIconCallback: ({isChosenColorIcon}) =>
                this.isChosenColorIcon = isChosenColorIcon,
            currentColor: currentColor,
            setCurrentColorCallback: ({color}) => currentColor = color,
          ),
          // bottomButtonsSection(context)
        ],
      ),
      title: "Adding new account",
    );
  }

  FlatButton buildAddButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (accountNameFormKey.currentState.validate()) {
          widget.addAccountCallback(accountData: accountData);
          Navigator.of(context).pop();
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('zle')));
        }
      },
      child: Container(
        child: Text(
          "Add",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  FlatButton buildCancelButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Container(
        child: Text(
          "Cancel",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  // Widget bottomButtonsSection(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: MyConstants.defaultPadding),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).accentColor,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(MyConstants.defaultCircularBorderRadius),
  //         bottomRight: Radius.circular(MyConstants.defaultCircularBorderRadius),
  //       ),
  //     ),
  //     child: IntrinsicHeight(
  //       child: Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Container(
  //                 child: Text(
  //                   "Cancel",
  //                 ),
  //               ),
  //             ),
  //           ),
  //           VerticalDivider(color: Theme.of(context).primaryColor),
  //           Expanded(
  //             child: FlatButton(
  //               onPressed: () {
  //                 if (accountNameFormKey.currentState.validate()) {
  //                   // if (chooseImageIcon == null) {
  //                   //   accountData.icon = chooseColorIcon;
  //                   // }
  //                   widget.addAccountCallback(accountData: accountData);
  //                   Navigator.of(context).pop();
  //                 } else {
  //                   // Scaffold.of(context)
  //                   //     .showSnackBar(SnackBar(content: Text('zle')));
  //                 }
  //               },
  //               child: Container(
  //                 child: Text("Add"),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}