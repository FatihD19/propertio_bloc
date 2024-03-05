import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/developer/developer_bloc.dart';
import 'package:propertio_mobile/data/model/developer_model.dart';
import 'package:propertio_mobile/shared/theme.dart';

import 'package:propertio_mobile/ui/component/pagination_button.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/view/detail_info_agen_view.dart';
import 'package:propertio_mobile/ui/widgets/proyek_card.dart';

class DeveloperPage extends StatefulWidget {
  final String id;
  final DeveloperModel developer;
  DeveloperPage(this.id, this.developer, {super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    Widget detailDeveloper() {
      return DetailInfoAgenView(
        widget.developer.fullName.toString(),
        widget.developer.phone.toString(),
        widget.developer.pictureProfileFile.toString(),
        widget.developer.city.toString(),
        widget.developer.province.toString(),
      );
      // return BlocProvider(
      //   create: (context) =>
      //       DeveloperBloc()..add(OnGetDetailDeveloper(widget.id)),
      //   child: BlocBuilder<DeveloperBloc, DeveloperState>(
      //     builder: (context, state) {
      //       if (state is DeveloperLoading) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //       if (state is DeveloperError) {
      //         return TextFailure(message: state.message);
      //       }
      //       if (state is DeveloperLoaded) {
      //         return DetailInfoAgenView(
      //           state.detail.data!.fullName.toString(),
      //           state.detail.data!.phone.toString(),
      //           state.detail.data!.pictureProfileFile.toString(),
      //           state.detail.data!.city.toString(),
      //           state.detail.data!.province.toString(),
      //         );
      //       }
      //       return Container();
      //     },
      //   ),
      // );
    }

    Widget projectDeveloper() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daftar Proyek',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
            SizedBox(height: 16),
            Center(
              child: BlocBuilder<DeveloperBloc, DeveloperState>(
                builder: (context, state) {
                  if (state is DeveloperLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is DeveloperError) {
                    return TextFailure(message: state.message);
                  }
                  if (state is ProjectDeveloperLoaded) {
                    return Column(
                      children: state.projects.data!.map((project) {
                        return ProyekCard(project);
                      }).toList(),
                    );
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      );
    }

    Widget projectPagination() {
      return Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 18),
        child: BlocProvider(
          create: (context) =>
              DeveloperBloc()..add(OnGetProjectDeveloper(widget.id, 1)),
          child: BlocBuilder<DeveloperBloc, DeveloperState>(
            builder: (context, state) {
              if (state is DeveloperLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DeveloperError) {
                return TextFailure(message: state.message);
              }
              if (state is ProjectDeveloperLoaded) {
                return Column(
                  children: [
                    Column(
                      children: state.projects.data!.map((project) {
                        return ProyekCard(project);
                      }).toList(),
                    ),
                    NavigationButton(
                      currentPage: state.projects.pagination!.currentPage!,
                      lastPage: state.projects.pagination!.lastPage!,
                      implementLogic: (page) {
                        print('Navigated to page $page');
                        context
                            .read<DeveloperBloc>()
                            .add(OnGetProjectDeveloper(widget.id, page));
                      },
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          detailDeveloper(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text('Daftar Proyek',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          ),
          projectPagination(),
        ],
      ),
    );
  }
}
