
import 'package:cached_network_image/cached_network_image.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/core/enums/message_enum.dart';

import '../../../../../../models/chat_models/message.dart';
import '../../../../../../utils/constants/assets_manager.dart';
// for showing single message details
class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isMe = 'me' == message.senderId;
    return isMe ? _greenMessage(context) : _senderMessage(context);
  }

  // sender or another user message
  Widget _senderMessage(context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: MyColors.green.withOpacity(.1),
            radius: 22.sp,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppAssets.supportIcon,
                scale: .9.sp,
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(message.type == MessageEnum.image
                ? width * .03
                : width * .02),
            margin: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.withOpacity(.3),
                // width: 2.0,
              ),
            ),
            child: (message.type == MessageEnum.text)
                ?
            //show text
            Text(
              message.text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: message.text,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 70),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            SizedBox(width: width * .04),
            //for adding some space
            const SizedBox(width: 2),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(message.type == MessageEnum.image
                ? width * .03
                : width * .02),
            margin: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: MyColors.green.withOpacity(.2),
                // border:
                borderRadius: BorderRadius.circular(8)
            ),
            child: message.type == MessageEnum.text
                ?
            //show text
            Text(
              message.text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ) :
            //show image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: message.text,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 70),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
