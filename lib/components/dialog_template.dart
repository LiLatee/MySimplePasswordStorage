import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart' as MyConstants;

class MyDialog extends StatelessWidget {
  final Widget content;
  final String title;
  final List<Widget> buttons;

  const MyDialog({
    Key key,
    @required this.content,
    @required this.title,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyConstants.defaultPadding),
      ),
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                buildDialogContent(buttons),
                buildDialogHeader(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDialogContent(List<Widget> buttons) {
    return Container(
      padding: EdgeInsets.only(top: MyConstants.defaultCircularBorderRadius),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: MyConstants.defaultCircularBorderRadius),
      child: Column(
        children: [
          content,
          ButtonBar(
            children: buttons ?? [],
          ),
        ],
      ),
    );
  }

  Widget buildDialogHeader(BuildContext context) {
    return Positioned(
      left: MyConstants.defaultPadding,
      right: MyConstants.defaultPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Theme.of(context).accentColor,
        ),
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(MyConstants.defaultPadding / 4),
            child: AutoSizeText(
              title,
              style: Theme.of(context).textTheme.headline2,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class MyDialogButton extends StatelessWidget {
  const MyDialogButton({
    Key key,
    this.buttonName,
    this.onPressed,
  }) : super(key: key);

  final String buttonName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: MyConstants.pressedButtonColor,
      child: Container(
        child: Text(
          buttonName,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
