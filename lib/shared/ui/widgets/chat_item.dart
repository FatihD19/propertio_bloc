import 'package:flutter/material.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/shared/utils.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool sameDate;
  DateTime? date;

  ChatMessage({
    required this.text,
    required this.isSender,
    this.sameDate = false,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          if (sameDate)
            Container(
              margin: EdgeInsets.only(bottom: 4.0),
              child: Text(formatDate(date!),
                  style: secondaryTextStyle.copyWith(fontSize: 12)),
            ),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      // alignment: Alignment.topLeft,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                          minWidth: 70),

                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
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
                    Container(
                      margin: EdgeInsets.only(top: 2.0, right: 9, left: 9),
                      child: Text(formatClock(date!),
                          style: secondaryTextStyle.copyWith(fontSize: 12)),
                    ),
                  ],
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
