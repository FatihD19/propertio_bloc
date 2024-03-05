import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/agent/agent_bloc.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/pagination_button.dart';
import 'package:propertio_mobile/ui/component/search_form.dart';
import 'package:propertio_mobile/ui/component/sidebar.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/widgets/agent_card.dart';

class AgentPage extends StatefulWidget {
  bool? forSidebar;
  AgentPage({this.forSidebar = false, super.key});
  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  bool? visitPage;
  final agentSearch = TextEditingController();
  // searchAgent() {
  //   context.read<AgentBloc>().add(OnGetAgent(search: agentSearch.text));
  // }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Image.asset('assets/img_banner_agent.png'),
          SizedBox(height: 16),
          SearchForm(
              justSearch: true,
              controller: agentSearch,
              hintText: 'Cari Agen',
              action: () {
                context
                    .read<AgentBloc>()
                    .add(OnGetAgent(search: agentSearch.text));
              }),
        ],
      );
    }

    Widget listAgent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daftar Agen',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          Center(child: BlocBuilder<AgentBloc, AgentState>(
            builder: (context, state) {
              if (state is AgentLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is AgentError) {
                return TextFailure(message: state.message);
              }
              if (state is AgentLoaded) {
                return Column(
                  children: [
                    Wrap(
                      spacing: 20,
                      runSpacing: 16,
                      children: state.listAgentModel.data!.agents!.map((agent) {
                        return AgentCard(agent);
                      }).toList(),
                    ),
                    NavigationButton(
                      currentPage:
                          state.listAgentModel.data!.pagination!.currentPage!,
                      lastPage:
                          state.listAgentModel.data!.pagination!.lastPage!,
                      implementLogic: (page) {
                        print('Navigated to page $page');
                        context.read<AgentBloc>().add(OnGetAgent(page: page));
                      },
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ))
          //   BlocProvider(
          //     create: (context) => AgentBloc()..add(OnGetAgent()),
          //     child: BlocBuilder<AgentBloc, AgentState>(
          //       builder: (context, state) {
          //         if (state is AgentLoading) {
          //           return Center(child: CircularProgressIndicator());
          //         }
          //         if (state is AgentError) {
          //           return TextFailure(message: state.message);
          //         }
          //         if (state is AgentLoaded) {
          //           return Wrap(
          //             spacing: 20,
          //             runSpacing: 16,
          //             children: state.listAgentModel.data!.agents!.map((agent) {
          //               return AgentCard(agent);
          //             }).toList(),
          //           );
          //         }
          //         return SizedBox();
          //       },
          //     ),
          //   ),
          // ),
        ],
      );
    }

    Widget body() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<AgentBloc>().add(OnGetAgent());
            agentSearch.clear();
          },
          child: ListView(
            children: [
              header(),
              SizedBox(height: 16),
              listAgent(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: widget.forSidebar == false ? null : propertioAppBar(),
      drawer: widget.forSidebar == false ? null : SideBar(),
      body: body(),
    );
  }
}
