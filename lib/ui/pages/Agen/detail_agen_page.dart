import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/agent/agent_bloc.dart';
import 'package:propertio_mobile/data/model/properti_model.dart';
import 'package:propertio_mobile/data/model/responses/detail_agent_response_model.dart';
import 'package:propertio_mobile/shared/theme.dart';

import 'package:propertio_mobile/ui/component/pagination_button.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/view/detail_info_agen_view.dart';
import 'package:propertio_mobile/ui/widgets/properti_card.dart';

class DetailAgenPage extends StatefulWidget {
  final String idAgent;
  DetailAgenPage(this.idAgent, {super.key});

  @override
  State<DetailAgenPage> createState() => _DetailAgenPageState();
}

class _DetailAgenPageState extends State<DetailAgenPage> {
  // DetailAgentResponseModel? detailAgent;
  // late AgentBloc agentBloc;

  // @override
  // void initState() {
  //   context.read<AgentBloc>()..add(OnGetDetailAgent(widget.idAgent));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Widget listProperti() {
      return BlocProvider(
        create: (context) => AgentBloc()..add(OnGetDetailAgent(widget.idAgent)),
        child: BlocBuilder<AgentBloc, AgentState>(
          builder: (context, state) {
            if (state is AgentLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AgentError) {
              return TextFailure(message: state.message);
            }
            if (state is AgentDetailLoaded) {
              List<PropertiModel> listProperti =
                  state.agentModel.data!.properties!.data!;
              DataDetailAgent data = state.agentModel.data!;
              return BlocBuilder<AgentBloc, AgentState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailInfoAgenView(
                          data.fullName.toString(),
                          data.phone.toString(),
                          data.pictureProfileFile.toString(),
                          data.city.toString(),
                          data.province.toString()),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Daftar Properti',
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 16)),
                            SizedBox(height: 16),
                            Center(
                              child: listProperti.isEmpty
                                  ? Text('Tidak terdapat Properti',
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: bold, fontSize: 16))
                                  : Column(
                                      children: listProperti
                                          .map((properti) => PropertiCard(
                                              properti,
                                              hideAgent: true))
                                          .toList(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      );
    }

    return Scaffold(
        body: ListView(
      children: [
        // BlocBuilder<AgentBloc, AgentState>(
        //   builder: (context, state) {
        //     if (state is AgentLoading) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     if (state is AgentDetailLoaded) {
        //       DataDetailAgent data = state.agentModel.data!;
        //       return DetailInfoAgenView(
        //           data.fullName.toString(),
        //           data.phone.toString(),
        //           data.pictureProfileFile.toString(),
        //           data.city.toString(),
        //           data.province.toString());
        //     }
        //     return SizedBox();
        //   },
        // ),
        // DetailInfoAgenV  iew(
        //     detailAgent!.data!.fullName.toString(),
        //     detailAgent!.data!.phone.toString(),
        //     detailAgent!.data!.pictureProfileFile.toString(),
        //     detailAgent!.data!.city.toString(),
        //     detailAgent!.data!.province.toString()),
        listProperti(),
      ],
    ));
  }
}
