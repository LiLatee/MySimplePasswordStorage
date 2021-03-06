import 'package:flutter/material.dart';

import '../../../../../../core/constants/AppConstants.dart';
import '../../../../../../data/entities/account_data_entity.dart';

typedef void SetChosenDefaultIcon(
    {required Image image, required String iconName});

class DefaultIconDropdownMenuItem extends DropdownMenuItem<String> {
  final SetChosenDefaultIcon setChosenDefaultIconCallback;
  final MapEntry<String, Image> mapElement;
  final AccountDataEntity accountDataEntity;

  DefaultIconDropdownMenuItem({
    Key? key,
    required this.accountDataEntity,
    required this.mapElement,
    required this.setChosenDefaultIconCallback,
  }) : super(
          onTap: () {
            setChosenDefaultIconCallback(
                image: mapElement.value, iconName: mapElement.key);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: AppConstants.defaultPadding),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: AppConstants.defaultIconRadius,
                    backgroundImage: mapElement.value.image,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: AppConstants.defaultPadding,
                  ),
                  Expanded(
                    child: Text(
                      mapElement.key,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          value: mapElement.key,
        );
}
