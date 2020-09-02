import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/constants.dart' as MyConstants;

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    Key key,
    @required this.label,
    this.isSingleLine = false,
    this.value,
    this.isPassword = false,
    this.onChangedCallback,
  }) : super(key: key);

  final String label;
  final bool isSingleLine;
  final String value;
  final bool isPassword;
  final Function onChangedCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MyConstants.defaultPadding,
          left: MyConstants.defaultPadding,
          right: MyConstants.defaultPadding),
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold)),
        readOnly: false,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: (isSingleLine || isPassword) ? 1 : 5,
        obscureText: isPassword,
        initialValue: (value != null) ? value : "",
        onChanged: (value) {
          if (onChangedCallback != null) {
            onChangedCallback(value);
          }
        },
      ),
    );
  }
}