// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/monitoring/monitoring_bloc.dart';
import 'package:propertio_mobile/data/model/project_progress_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/pages/Monitoring/chat_monitoring_page.dart';
import 'package:propertio_mobile/ui/widgets/item_progress_properti.dart';
import 'package:propertio_mobile/ui/widgets/progress_properti.dart';

import '../../../injection.dart';

class DetailMonitoringPage extends StatefulWidget {
  final ProjectProgressModel projectProgress;

  DetailMonitoringPage(this.projectProgress, {super.key});

  @override
  State<DetailMonitoringPage> createState() => _DetailMonitoringPageState();
}

class _DetailMonitoringPageState extends State<DetailMonitoringPage> {
  // @override
  // void initState() {
  //   context.read<MonitoringBloc>()
  //     ..add(OnGetProjectProgressPage('${widget.projectProgress.id}'));
  //   super.initState();
  // }
  String idMonitoring = '';
  @override
  Widget build(BuildContext context) {
    // Widget header() {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text('Monitoring',
    //           style: primaryTextStyle.copyWith(
    //             fontWeight: bold,
    //             fontSize: 16,
    //           )),
    //       ElevatedButton(
    //           style:
    //               ElevatedButton.styleFrom(backgroundColor: Color(0xffE2E2E2)),
    //           onPressed: () {
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) =>
    //                         ChatMonitoringPage(idMonitoring)));
    //           },
    //           child: Row(
    //             children: [
    //               Image.asset('assets/ic_chat.png', width: 16, height: 16),
    //               SizedBox(width: 4),
    //               Text('Chat$idMonitoring',
    //                   style: primaryTextStyle.copyWith(
    //                     fontWeight: bold,
    //                     fontSize: 12,
    //                   ))
    //             ],
    //           ))
    //     ],
    //   );
    // }

    Widget listProgress() {
      return BlocProvider(
        create: (context) => locator<MonitoringBloc>()
          ..add(OnGetProjectProgressPage('${widget.projectProgress.id}')),
        child: BlocBuilder<MonitoringBloc, MonitoringState>(
          builder: (context, state) {
            if (state is MonitoringLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MonitoringError) {
              return TextFailure(message: state.message);
            }
            if (state is ProjectProgressPageLoaded) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monitoring',
                          style: primaryTextStyle.copyWith(
                            fontWeight: bold,
                            fontSize: 16,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE2E2E2)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatMonitoringPage(
                                        '${state.projectProgress.data?.id}')));
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/ic_chat.png',
                                  width: 16, height: 16),
                              SizedBox(width: 4),
                              Text('Chat$idMonitoring',
                                  style: primaryTextStyle.copyWith(
                                    fontWeight: bold,
                                    fontSize: 12,
                                  ))
                            ],
                          ))
                    ],
                  ),
                  ProgressProperti(widget.projectProgress),
                  SizedBox(height: 8),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.projectProgress.data!.progresses!.length,
                      itemBuilder: (context, index) {
                        return ItemProgressProperti(
                          '${state.projectProgress.data!.progresses![index].title}',
                          int.parse(state.projectProgress.data!
                                  .progresses![index].percentage ??
                              '0'),
                          '${state.projectProgress.data?.progresses![index].id}',
                          lastItem: index ==
                              state.projectProgress.data!.progresses!.length -
                                  1,
                        );
                      }),
                ],
              );
            }

            return Container();
          },
        ),
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [SizedBox(height: 8), listProgress()],
        ),
      ),
    );
  }
}
