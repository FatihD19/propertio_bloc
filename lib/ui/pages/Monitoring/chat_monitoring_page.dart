// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:propertio_mobile/bloc/chat/chat_bloc.dart';
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';
import 'package:propertio_mobile/ui/component/sidebar.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';
import 'package:propertio_mobile/ui/widgets/chat_item.dart';

class ChatMonitoringPage extends StatefulWidget {
  final String idMonitoring;
  ChatMonitoringPage(this.idMonitoring, {Key? key}) : super(key: key);

  @override
  State<ChatMonitoringPage> createState() => _ChatMonitoringPageState();
}

class _ChatMonitoringPageState extends State<ChatMonitoringPage> {
  String idAccount = '';
  getIdAccount() async {
    idAccount = await AuthLocalDataSource.getIdAccount();
  }

  final ScrollController _scrollController = ScrollController();

  TextEditingController _messageController = TextEditingController();

  List chat = [];

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Timer? _timer;
  _getChat() {
    context.read<ChatBloc>().add(OnGetListChat(widget.idMonitoring));
    _scrollToBottom();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      context.read<ChatBloc>().add(OnGetListChat(widget.idMonitoring));
    });
  }

  @override
  void initState() {
    initializeDateFormatting('id', null);
    getIdAccount();
    _getChat();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: propertioAppBar(),
      drawer: SideBar(),
      body: Container(
        color: bgColor1,
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            _getChat();
          },
          child: Column(
            children: [
              Expanded(
                child: BlocListener<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatLoaded) {
                      chat = state.data.data!;
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chat.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // _scrollToBottom();
                        return ChatMessage(
                          text: chat[index].message!,
                          isSender: chat[index].sender == idAccount,
                          sameDate: index == 0
                              ? true
                              : formatDate(chat[index].createdAt!) !=
                                  formatDate(chat[index - 1].createdAt!),
                          date: chat[index].createdAt!,
                        );
                      },
                    ),
                  ),
                ),
                // BlocBuilder<ChatBloc, ChatState>(
                //   builder: (context, state) {
                //     if (state is ChatLoading) {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     } else if (state is ChatLoaded) {
                //       List chat = state.data.data!;

                //       return Padding(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                //         child: ListView.builder(
                //           controller: _scrollController,
                //           itemCount: chat.length,
                //           // shrinkWrap: true,
                //           itemBuilder: (context, index) {
                //             // _scrollToBottom();
                //             return ChatMessage(
                //               text: chat[index].message!,
                //               isSender: chat[index].sender == idAccount,
                //               sameDate: index == 0
                //                   ? true
                //                   : formatDate(chat[index].createdAt!) !=
                //                       formatDate(chat[index - 1].createdAt!),
                //               date: formatDate(chat[index].createdAt!),
                //             );
                //           },
                //         ),
                //       );
                //     } else {
                //       return Center(
                //         child: Text('No Data'),
                //       );
                //     }
                //   },
                // ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      controller: _messageController,
                      hintText: 'Ketik Pesan',
                    )),
                    SizedBox(width: 16.0),
                    BlocConsumer<ChatBloc, ChatState>(
                      listener: (context, state) {
                        if (state is ChatSuccessPost) {
                          _getChat();
                        }
                      },
                      builder: (context, state) {
                        // if (state is ChatLoading) {
                        //   return CircularProgressIndicator();
                        // }
                        return InkWell(
                          onTap: () {
                            context.read<ChatBloc>().add(OnPostChatUser(
                                widget.idMonitoring, _messageController.text));
                            _messageController.clear();
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 14),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        );
                      },
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(

                    //     backgroundColor: primaryColor,
                    //   ),
                    //   onPressed: () {
                    //     // Send message logic goes here
                    //   },
                    //   child: Icon(
                    //     Icons.send,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
