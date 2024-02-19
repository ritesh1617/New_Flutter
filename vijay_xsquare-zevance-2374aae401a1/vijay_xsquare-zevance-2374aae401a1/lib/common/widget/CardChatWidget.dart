import 'package:flutter/material.dart';
import 'package:grievance/common/widget/RecieveChatWidget.dart';
import 'package:grievance/common/widget/SendChatWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/utils/constants.dart';

class CardChatWidget extends StatelessWidget {
  List<Replies> list;

  CardChatWidget(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15),
        child: Column(children:_chat(),));
  }

  List<Widget> _chat() {
    return List<Widget>.generate(
        (list.length > 2) ? 2 : list.length, (int index) {
      return (list[index].user?.userableType == Usertype.enduser) ? ReceiveChatWidget(list[index],profileVisible: false,):SendChatWidget(list[index],profileVisible: false,);
    });
  }
}
