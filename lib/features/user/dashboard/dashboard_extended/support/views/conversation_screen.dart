import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/core/enums/message_enum.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/widgets/chat_input.dart';
import 'package:invoice_producer/models/chat_models/message.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../widgets/message_card.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  TextEditingController messageController = TextEditingController();
  final List<Message> _list = [
    Message(
        senderId: 'you',
        receiverId: 'you',
        text: 'hey! developer, how are you?',
        type: MessageEnum.text,
        timeSent: DateTime.now(),
        messageId: '444',
        isSeen: true),
    Message(
        senderId: 'me',
        receiverId: 'you',
        text: 'hey! developer, how are you?',
        type: MessageEnum.text,
        timeSent: DateTime.now(),
        messageId: '444',
        isSeen: true),
    Message(
        senderId: 'you',
        receiverId: 'you',
        text: 'Absolutely',
        type: MessageEnum.text,
        timeSent: DateTime.now(),
        messageId: '444',
        isSeen: true),
    Message(
        senderId: 'me',
        receiverId: 'you',
        text: 'can i change the invoice color to match my brand?',
        type: MessageEnum.text,
        timeSent: DateTime.now(),
        messageId: '444',
        isSeen: true),
    Message(
        senderId: 'you',
        receiverId: 'you',
        text: 'hey! Ali, how are you? hey! Ali, how are you? hey! Ali, how are you?',
        type: MessageEnum.text,
        timeSent: DateTime.now(),
        messageId: '444',
        isSeen: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            leading: Consumer(builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(AppAssets.backArrowIcon,
                    width: 20.w, height: 20.h, color: context.titleColor),
              );
            }),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: context.greenColor.withOpacity(.1),
                    child: Padding(
                      padding:  EdgeInsets.all(5.0.h),
                      child: Image.asset(
                        AppAssets.supportIcon,
                        scale: 5.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'Annette Black',
                  style: getLibreBaskervilleBoldStyle(
                      color: context.titleColor, fontSize: MyFonts.size16),
                ),
              ],
            ),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(16.0),
              child: Container(
                height: 1,
                color: Colors.grey.withOpacity(.3),
              ),
            )),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                padding: EdgeInsets.only(top: 1.sp),
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index) {
                  final currentMessage = _list[index];
                  final nextMessage = index < _list.length - 1 ? _list[index + 1] : null;

                  // Check if the current message date is different from the next one
                  bool showDateLine = nextMessage == null ||
                      !isSameDay(currentMessage.timeSent, nextMessage.timeSent);

                  Widget messageWidget = MessageCard(message: currentMessage);

                  // Display date line at the top if needed
                  if (showDateLine) {
                    String dateText;
                    if (isToday(currentMessage.timeSent)) {
                      dateText = 'Today, ${formatDateTime(currentMessage.timeSent)}';
                    } else {
                      dateText = dayAndTime(currentMessage.timeSent);
                    }

                    messageWidget = Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Text(
                              dateText,
                              style: TextStyle(
                                fontSize:MyFonts.size16,
                                color: context.titleColor,
                              ),
                            ),
                          ),
                        ),
                        messageWidget,
                      ],
                    );
                  }
                  return messageWidget;
                },
              ),
            ),
            ChatInput(messageController: messageController),
          ],
        ),
    );
  }
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return isSameDay(date, now);
  }
}
