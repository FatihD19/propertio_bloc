// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/chat/chat_bloc.dart';
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/sidebar.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';

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

  @override
  void initState() {
    getIdAccount();
    context.read<ChatBloc>().add(OnGetListChat(widget.idMonitoring));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: propertioAppBar(),
      drawer: SideBar(),
      body: Container(
        color: bgColor1,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ChatLoaded) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: ListView.builder(
                        itemCount: state.data.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ChatMessage(
                                text: state.data.data![index].message!,
                                isSender:
                                    state.data.data![index].sender == idAccount,
                                sameDate: index == 0
                                    ? true
                                    : state.data.data![index].createdAt! ==
                                            state.data.data![index - 1]
                                                .createdAt!
                                        ? true
                                        : false,
                              ),
                              Text(state.data.data![index].createdAt.toString(),
                                  style: secondaryTextStyle.copyWith(
                                      fontSize: 12)),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is ChatError) {
                    return TextFailure(message: state.message);
                  } else {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    hintText: 'Ketik Pesan',
                  )),
                  SizedBox(width: 16.0),
                  InkWell(
                    onTap: () {
                      // Send message logic goes here
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
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool sameDate;

  const ChatMessage({
    required this.text,
    required this.isSender,
    this.sameDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          if (sameDate)
            Text('11 May 2021',
                style: secondaryTextStyle.copyWith(fontSize: 12)),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: isSender ? primaryColor : buttonTextColor,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        color: isSender ? primaryColor : secondaryColor,
                        width: 2.0,
                        style: BorderStyle.solid),
                  ),
                  child: Text(
                    text,
                    style: isSender
                        ? buttonTextStyle.copyWith(
                            color: Colors.white, fontSize: 16)
                        : primaryTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // Align(
    //   alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    //   child: Container(
    //     margin: EdgeInsets.symmetric(vertical: 8.0),
    //     padding: EdgeInsets.all(16.0),
    //     decoration: BoxDecoration(
    //       color: isSender ? primaryColor : buttonTextColor,
    //       borderRadius: BorderRadius.circular(16.0),
    //       border: Border.all(
    //           color: isSender ? primaryColor : secondaryColor,
    //           width: 2.0,
    //           style: BorderStyle.solid),
    //     ),
    //     child: Text(
    //       text,
    //       style: isSender
    //           ? buttonTextStyle.copyWith(color: Colors.white, fontSize: 16)
    //           : primaryTextStyle.copyWith(fontSize: 16),
    //     ),
    //   ),
    // );
  }
}
