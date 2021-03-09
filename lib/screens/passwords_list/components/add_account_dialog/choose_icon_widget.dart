import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';

import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'dropdown_button_items/choose_color.dart';
import 'dropdown_button_items/choose_color_selected.dart';
import 'dropdown_button_items/choose_image.dart';
import 'dropdown_button_items/choose_image_selected.dart';
import 'dropdown_button_items/default_icon.dart';
import 'dropdown_button_items/default_icon_selected.dart';

typedef void SetIsChosenColorIcon({bool isChosenColorIcon});

class ChooseIconWidget extends StatefulWidget {
  Color currentColor;
  final SetIsChosenColorIcon setIsChosenColorIconCallback;

  ChooseIconWidget({
    Key key,
    @required this.currentColor,
    @required this.setIsChosenColorIconCallback,
  }) : super(key: key);

  @override
  _ChooseIconWidgetState createState() => _ChooseIconWidgetState();
}

class _ChooseIconWidgetState extends State<ChooseIconWidget> {
  AccountDataEntity _accountDataEntity;
  String _valueSelectedItem = 'Choose color';
  bool isShowColorPickerNeeded = false;
  bool isChosenColorIcon = true;
  Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);


    return Container(
      margin: EdgeInsets.only(
        left: MyConstants.defaultPadding,
        right: MyConstants.defaultPadding,
        top: MyConstants.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          itemHeight:
              MyConstants.defaultIconRadius * 2 + MyConstants.defaultPadding,
          value: _valueSelectedItem,
          selectedItemBuilder: (context) =>
              [
                ChooseImageSelectedDropdownMenuItem(
                    chooseImageIcon: _accountDataEntity.iconWidget),
                ChooseColorSelectedDropdownMenuItem(
                    icon: _accountDataEntity.iconWidget),
              ] +
              dropdownButtonsDefaultIconsSelected(context),
          items: [
                ChooseImageDropdownMenuItem(
                  setIconImageCallback: setIconImage,
                  context: context,
                ),
                ChooseColorDropdownMenuItem(
                  showColorPickerCallback: ({isShowNeeded}) =>
                      isShowColorPickerNeeded = isShowNeeded,
                  chooseColorIconWidget: _accountDataEntity.iconWidget,
                ),
              ] +
              dropdownButtonsDefaultIcons(context),
          onChanged: (value) {
            setState(() {
              _valueSelectedItem = value;

              if (isShowColorPickerNeeded) {
                showDialog(
                  builder: (context) => MyDialog(
                    title: 'Pick a color',
                    content: Container(
                      margin: EdgeInsets.all(MyConstants.defaultPadding),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: BlockPicker(
                        availableColors: MyConstants.iconDefaultColors,
                        pickerColor: _currentColor,
                        onColorChanged: (value) {
                          setIconColor(color: value);
                        },
                        // availableColors: , TODO wybrać kolory
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                  context: context,
                );
                isShowColorPickerNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }

  void setChosenDefaultIconImage({Image image, String iconName}) async {
    var temp = await rootBundle.load('images/${iconName.toLowerCase()}.png');
    Provider.of<AccountDataEntity>(context, listen: false).iconImage = temp.buffer.asUint8List();

    setState(() {
      _accountDataEntity.iconWidget = CircleAvatar(
        radius: MyConstants.defaultIconRadius,
        backgroundImage: image.image,
        backgroundColor: Colors.transparent,
      );
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
      // chooseImageIcon = widget.accountData.icon;
    });
  }

  void setIconColor({Color color}) {
    setState(() {
      _currentColor = color;
      _accountDataEntity.iconWidget =
          MyFunctions.generateRandomColorIconAsWidget(
        name: _accountDataEntity.accountName,
        color: color,
      );
      _accountDataEntity.iconColorHex = color.value.toRadixString(16);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: true);
    });
    Navigator.of(context).pop();
  }

  void setIconImage({PickedFile pickedFile}) {
    setState(() async {
      var image = Image.file(
        File(pickedFile.path),
        width: MyConstants.defaultIconRadius * 2,
        height: MyConstants.defaultIconRadius * 2,
      );

      Provider.of<AccountDataEntity>(context, listen: false).iconImage = await pickedFile.readAsBytes();

      _accountDataEntity.iconWidget =
          MyFunctions.buildCircleAvatarUsingImage(imageForIcon: image);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
    });
  }

  List<DefaultIconDropdownMenuItem> dropdownButtonsDefaultIcons(
      BuildContext context) {
    return MyConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconDropdownMenuItem(
            accountDataEntity: _accountDataEntity,
            mapElement: e,
            setChosenDefaultIconCallback: setChosenDefaultIconImage,
          ),
        )
        .toList();
  }

  List<DefaultIconSelectedDropdownMenuItem> dropdownButtonsDefaultIconsSelected(
      BuildContext context) {
    return MyConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconSelectedDropdownMenuItem(mapElement: e),
        )
        .toList();
  }
}
