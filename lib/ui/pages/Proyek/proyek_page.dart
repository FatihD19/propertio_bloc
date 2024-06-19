import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/shared/theme.dart';
import 'package:propertio_bloc/ui/component/pagination_button.dart';
import 'package:propertio_bloc/ui/component/search_form.dart';
import 'package:propertio_bloc/ui/component/sidebar.dart';
import 'package:propertio_bloc/ui/component/text_failure.dart';

import 'package:propertio_bloc/ui/widgets/proyek_card.dart';
import 'package:propertio_bloc/ui/widgets/small_proyek_card.dart';

class ProyekPage extends StatefulWidget {
  const ProyekPage({super.key});

  @override
  State<ProyekPage> createState() => _ProyekPageState();
}

class _ProyekPageState extends State<ProyekPage> {
  final proyekSearch = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Image.asset('assets/img_banner_proyek.jpeg')),
          SearchForm(
            isProyek: true,
            controller: proyekSearch,
            action: () {
              context.read<ProjectBloc>().add(
                  OnGetProject(query: proyekSearch.text, type: selectedType));
            },
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            selectedItem: selectedType,
          ),
          SizedBox(height: 16),
        ],
      );
    }

    Widget pilihanTerbaik() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pilihan terbaik untuk anda',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProjectError) {
                return TextFailure(message: state.message);
              }
              if (state is ProjectLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state
                          .listProjectModel.data!.projectsRecomendation!
                          .map((proyek) => SmallProyekCard(proyek: proyek))
                          .toList()),
                );
              }
              return SizedBox();
            },
          )
        ],
      );
    }

    Widget daftarProperti() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daftar Properti di Indonesia',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          Center(child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProjectError) {
                return TextFailure(message: state.message);
              }
              if (state is ProjectLoaded) {
                return Column(
                  children: [
                    Column(
                      children: state.listProjectModel.data!.projects!
                          .map((proyek) => ProyekCard(proyek))
                          .toList(),
                    ),
                    NavigationButton(
                      currentPage:
                          state.listProjectModel.data!.pagination!.currentPage!,
                      lastPage:
                          state.listProjectModel.data!.pagination!.lastPage!,
                      implementLogic: (page) {
                        context
                            .read<ProjectBloc>()
                            .add(OnGetProject(page: page));
                      },
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          )),
        ],
      );
    }

    return Scaffold(
        appBar: propertioAppBar(),
        drawer: SideBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: bgColor1,
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<ProjectBloc>().add(OnGetProject());
              proyekSearch.clear();
            },
            child: ListView(
              children: [
                header(),
                pilihanTerbaik(),
                SizedBox(height: 16),
                daftarProperti(),
              ],
            ),
          ),
        ));
  }
}
