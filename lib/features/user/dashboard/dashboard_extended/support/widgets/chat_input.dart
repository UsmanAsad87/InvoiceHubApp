import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/widgets/custom_icon_button.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_imports/common_libs.dart';

class ChatInput extends StatelessWidget {
  final messageController;
   ChatInput({Key? key,required this.messageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppConstants.padding),
      child: CustomTextField(
          controller: messageController,
          hintText: 'Type..',
          label: '',
        tailingIcon : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconButton(image: AppAssets.voice, onTap: (){}),
            CustomIconButton(image: AppAssets.gallery, onTap: (){}),
            CustomIconButton(image: AppAssets.link, onTap: (){}),
          ],
        ),
      ),
    );
  }
}