import 'package:flutter/material.dart';
import 'package:propertio_mobile/data/model/project_progress_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/ui/component/custom_chip.dart';
import 'package:propertio_mobile/ui/pages/Monitoring/detail_monitoring_page.dart';
import 'package:propertio_mobile/ui/widgets/properti_card.dart';

class ProgressProperti extends StatelessWidget {
  final ProjectProgressModel projectProgress;
  // final int progress;
  bool? isFail;
  ProgressProperti(this.projectProgress, {this.isFail = false, super.key});

  @override
  Widget build(BuildContext context) {
    Widget infoRow(String img, String title) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Image.asset(img, width: 16, height: 16),
            SizedBox(width: 4),
            Text(title, style: primaryTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      );
    }

    Widget progressIndicator() {
      int progress = int.parse(projectProgress.progressPercentage ?? '0');
      double value = progress / 100;
      return Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 15,
              borderRadius: BorderRadius.circular(8),
              value: isFail == true ? 1.0 : value, // Replace with your value
              backgroundColor: secondaryColor,
              valueColor: isFail == true
                  ? AlwaysStoppedAnimation<Color>(
                      Colors.red,
                    )
                  : AlwaysStoppedAnimation<Color>(
                      progress == 100 ? Colors.green : Colors.orange,
                    ),
            ),
          ),
          SizedBox(width: 10),
          Text(isFail == true ? 'Gagal' : '$progress%',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 12)),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailMonitoringPage()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: customBoxDecoration(),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Image.asset('assets/img_new_properti.png'),
                        Positioned(
                            top: 5,
                            left: 5,
                            child: CustomChip('${projectProgress.status}')),
                        Positioned(bottom: 5, left: 5, child: ChipHouse())
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${projectProgress.title}',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: bold,
                            )),
                        infoRow('assets/ic_location.png',
                            '${projectProgress.address}'),
                        infoRow('assets/ic_calendar.png',
                            '${projectProgress.startDate} - ${projectProgress.endDate}'),
                        infoRow('assets/ic_person.png',
                            '${projectProgress.developerName}'),
                        infoRow('assets/ic_mini_call.png',
                            '${projectProgress.developerPhone}'),
                        SizedBox(height: 4),
                        Text(formatCurrency(projectProgress.price!),
                            style: thirdTextStyle.copyWith(
                                fontWeight: bold, fontSize: 16)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  color: secondaryColor,
                  height: 1,
                  child: SizedBox(width: double.infinity),
                ),
                SizedBox(height: 10),
                progressIndicator(),
                // Text(formatDate(projectProgress.startDate)),

                SizedBox(height: 8),

                // ListTile(
                //   leading: CircleAvatar(
                //     backgroundImage: AssetImage('assets/img_agent.png'),
                //   ),
                //   title: Text('City Connoisseurs',
                //       style: primaryTextStyle.copyWith(
                //           fontWeight: bold, fontSize: 12)),
                //   subtitle: Row(
                //     children: [
                //       Image.asset('assets/img_calendar.png'),
                //       SizedBox(width: 4),
                //       Text('Iklan diposting 1 tahun lalu',
                //           style: primaryTextStyle.copyWith(fontSize: 10))
                //     ],
                //   ),
                //   trailing: FavoriteButton(),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
