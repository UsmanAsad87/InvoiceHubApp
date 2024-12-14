import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';

import '../../../../../../utils/constants/font_manager.dart';
import '../../../../../../utils/themes/styles_manager.dart';

class AttachmentWidget extends StatelessWidget {
  final Function()? onTap;
  AttachmentWidget({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
              onPressed: onTap,
              icon: Icon(Icons.add,size: 40.h ,color: context.greenColor),
              label: Text('Attachment (invoice)',
                style: getSemiBoldStyle(
                      fontSize: MyFonts.size18,
                      color: context.greenColor),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  // margin: MaterialStateProperty.all(EdgeInsets.all(0)),
      ),
          );

  }
}
