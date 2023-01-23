import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/support_messages_service.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketChatPage extends StatefulWidget {
  const TicketChatPage({Key? key, required this.title, required this.ticketId})
      : super(key: key);

  final String title;
  final ticketId;

  @override
  State<TicketChatPage> createState() => _TicketChatPageState();
}

class _TicketChatPageState extends State<TicketChatPage> {
  bool firstTimeLoading = true;

  TextEditingController sendMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 10,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  FilePickerResult? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: greyParagraph,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: Container(
                //     padding: const EdgeInsets.all(5),
                //     decoration: const BoxDecoration(
                //         shape: BoxShape.circle, color: Colors.white),
                //     child: ClipRRect(
                //       child: Image.asset(
                //         'assets/images/logo.png',
                //       ),
                //     ),
                //   ),
                //   maxRadius: 22,
                // ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "#${widget.ticketId}",
                        style:
                            const TextStyle(color: primaryColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // Icon(
                //   Icons.settings,
                //   color: Colors.black54,
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Consumer<SupportMessagesService>(
            builder: (context, provider, child) {
          if (provider.messagesList.isNotEmpty &&
              provider.sendLoading == false) {
            Future.delayed(const Duration(milliseconds: 500), () {
              _scrollDown();
            });
          }
          return Stack(
            children: <Widget>[
              provider.isloading == false
                  ?
                  //chat messages
                  Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: provider.messagesList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment:
                                provider.messagesList[index]['type'] == "admin"
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                            children: [
                              //small show profile pic
                              // provider.messagesList[index].type == "admin"
                              //     ? Container(
                              //         margin: const EdgeInsets.only(
                              //           left: 13,
                              //         ),
                              //         width: 18,
                              //         height: 18,
                              //         decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.white),
                              //         child: ClipRRect(
                              //           child: Image.asset(
                              //             'assets/images/logo.png',
                              //           ),
                              //         ),
                              //       )
                              //     : Container(),
                              //the message
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: provider.messagesList[index]
                                                  ['type'] ==
                                              "admin"
                                          ? 10
                                          : 90,
                                      right: provider.messagesList[index]
                                                  ['type'] ==
                                              "admin"
                                          ? 90
                                          : 10,
                                      top: 10,
                                      bottom: 10),
                                  child: Align(
                                    alignment: (provider.messagesList[index]
                                                ['type'] ==
                                            "admin"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                    child: Column(
                                      crossAxisAlignment:
                                          (provider.messagesList[index]
                                                      ['type'] ==
                                                  "admin"
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end),
                                      children: [
                                        //the message ==========>
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: (provider.messagesList[index]
                                                        ['type'] ==
                                                    "admin"
                                                ? Colors.grey.shade200
                                                : primaryColor),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          //message =====>
                                          child: Text(
                                            provider.messagesList[index]
                                                ['message'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: (provider.messagesList[
                                                            index]['type'] ==
                                                        "admin"
                                                    ? Colors.grey[800]
                                                    : Colors.white)),
                                          ),
                                        ),

                                        //Attachment =============>
                                        provider.messagesList[index]
                                                    ['attachment'] !=
                                                null
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    top: 11),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                height: 50,
                                                width: screenWidth / 2 - 50,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: (provider.messagesList[
                                                              index]['type'] ==
                                                          "admin"
                                                      ? Colors.grey.shade200
                                                      : primaryColor),
                                                ),
                                                child: provider.messagesList[
                                                                index]
                                                            ['filePicked'] ==
                                                        false
                                                    ?
                                                    //that means file is fetching from server
                                                    InkWell(
                                                        onTap: () {
                                                          launchUrl(
                                                              Uri.parse(provider
                                                                          .messagesList[
                                                                      index][
                                                                  'attachment']),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Attachment',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: (provider.messagesList[index]
                                                                              [
                                                                              'type'] ==
                                                                          "admin"
                                                                      ? Colors.grey[
                                                                          800]
                                                                      : Colors
                                                                          .white)),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Icon(Icons.download,
                                                                size: 17,
                                                                color: (provider.messagesList[index]
                                                                            [
                                                                            'type'] ==
                                                                        "admin"
                                                                    ? Colors.grey[
                                                                        800]
                                                                    : Colors
                                                                        .white))
                                                          ],
                                                        ))

                                                    //local file====>
                                                    : InkWell(
                                                        onTap: () {},
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Attachment',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: (provider.messagesList[index]
                                                                              [
                                                                              'type'] ==
                                                                          "admin"
                                                                      ? Colors.grey[
                                                                          800]
                                                                      : Colors
                                                                          .white)),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Icon(
                                                                Icons.check_box,
                                                                size: 17,
                                                                color: (provider.messagesList[index]
                                                                            [
                                                                            'type'] ==
                                                                        "admin"
                                                                    ? Colors.grey[
                                                                        800]
                                                                    : Colors
                                                                        .white))
                                                          ],
                                                        )))
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // provider.messagesList[index].type == "admin"
                              //     ? Container(
                              //         margin: const EdgeInsets.only(
                              //           right: 13,
                              //         ),
                              //         width: 15,
                              //         height: 15,
                              //         decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.white),
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(100),
                              //           child: Image.network(
                              //             'https://cdn.pixabay.com/photo/2016/09/08/13/58/desert-1654439__340.jpg',
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       )
                              //     : Container(),
                            ],
                          );
                        },
                      ),
                    )
                  : OthersHelper().showLoading(primaryColor),

              //write message section======>
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 10, top: 10, right: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      pickedFile != null
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.file_copy,
                                color: Colors.white,
                                size: 18,
                              ))
                          : Container(),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextField(
                          controller: sendMessageController,
                          decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      //pick image =====>
                      IconButton(
                          onPressed: () async {
                            pickedFile = await provider.pickFile();
                            setState(() {});
                          },
                          icon: const Icon(Icons.attachment)),

                      //send message button
                      const SizedBox(
                        width: 13,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          if (sendMessageController.text.isNotEmpty) {
                            //hide keyboard
                            FocusScope.of(context).unfocus();
                            //send message
                            provider.sendMessage(
                              widget.ticketId,
                              sendMessageController.text,
                              pickedFile?.files.single.path,
                            );

                            //clear input field
                            sendMessageController.clear();
                            //clear image
                            setState(() {
                              pickedFile = null;
                            });
                          } else {
                            OthersHelper().showToast(
                                'Please write a message first', Colors.black);
                          }
                        },
                        backgroundColor: primaryColor,
                        elevation: 0,
                        child: provider.sendLoading == false
                            ? const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              )
                            : const SizedBox(
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
