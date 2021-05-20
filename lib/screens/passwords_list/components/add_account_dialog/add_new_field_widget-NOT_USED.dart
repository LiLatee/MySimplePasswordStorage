import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../utils/constants.dart' as MyConstants;

class AddFieldWidget extends StatefulWidget {
  const AddFieldWidget({
    Key key,
    @required this.label,
    this.isPassword = false,
    this.value,
  }) : super(key: key);

  final String label;
  final String value;
  final bool isPassword;

  @override
  _AddFieldWidgetState createState() => _AddFieldWidgetState();
}

class _AddFieldWidgetState extends State<AddFieldWidget> {
  String fieldName;
  String initialValue;

  @override
  Widget build(BuildContext context) {
    initialValue = widget.value;
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
            labelText: fieldName == null ? widget.label : fieldName,
            labelStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold)),
        readOnly: false,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: widget.isPassword ? 1 : 1,
        obscureText: widget.isPassword,
        initialValue: (initialValue != null) ? initialValue : "",
        onFieldSubmitted: (value) {
          setState(() {
            fieldName = value;
            initialValue = '';
          });
        },
      ),
    );
  }
}