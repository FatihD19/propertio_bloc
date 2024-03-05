// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/ui/widgets/progress_properti.dart';

class DetailMonitoringPage extends StatelessWidget {
  const DetailMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Monitoring',
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              )),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xffE2E2E2)),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset('assets/ic_chat.png', width: 16, height: 16),
                  SizedBox(width: 4),
                  Text('Chat',
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 12,
                      ))
                ],
              ))
        ],
      );
    }

    Widget itemProgress(int progress, {bool? lastItem}) {
      double value = progress / 100;
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                // margin: EdgeInsets.only(bottom: 20),
                decoration: customBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 37),
                      child: Text(
                        'Judul Progress',
                        style: primaryTextStyle.copyWith(
                            fontWeight: bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        SizedBox(width: 36),
                        Expanded(
                          child: LinearProgressIndicator(
                            minHeight: 15,
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(8),
                                // bottomRight: Radius.circular(8),
                                ),
                            value: value, // Replace with your value
                            backgroundColor: Color(0xff383838),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progress == 100 ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                        SizedBox(width: 46.7),
                        GestureDetector(
                          onTap: () {
                            // showCustomSnackbar(context, type: 'progress');
                          },
                          child: Image.asset('assets/ic_action_agen.png',
                              width: 24, height: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 37),
                      child: Text(
                        '5 hari yang lalu ',
                        style: primaryTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              lastItem == true
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(left: 45),
                      color: secondaryColor,
                      child: SizedBox(
                        height: 20,
                        width: 8,
                      ),
                    )
            ],
          ),
          Positioned(
              top: 31.2,
              left: 18,
              child: Image.asset('assets/ic_title_progress.png',
                  width: 36, height: 36)),
          Positioned(
              top: 31.2,
              right: 52,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff383838),
                ),
                child: Center(
                  child: Text(
                    '$progress%',
                    style: buttonTextStyle.copyWith(
                        fontWeight: bold, fontSize: 10),
                  ),
                ),
              )),
        ],
      );
    }

    Widget listProgress() {
      return Column(
        children: [
          itemProgress(7),
          itemProgress(100),
          itemProgress(80, lastItem: true),
        ],
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            header(),
            SizedBox(height: 8),
            ProgressProperti(50),
            SizedBox(height: 8),
            listProgress()
          ],
        ),
      ),
    );
  }
}
