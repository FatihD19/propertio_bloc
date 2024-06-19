import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/shared/theme.dart';
import 'package:propertio_bloc/ui/component/search_form.dart';
import 'package:propertio_bloc/ui/component/sidebar.dart';
import 'package:propertio_bloc/ui/component/text_failure.dart';
import 'package:propertio_bloc/ui/widgets/new_properti_card.dart';
import 'package:propertio_bloc/ui/widgets/properti_card.dart';

class PropertiPage extends StatefulWidget {
  bool? isRent;
  bool? fromHomePage;
  PropertiPage({this.isRent, this.fromHomePage = false, super.key});

  @override
  State<PropertiPage> createState() => _PropertiPageState();
}

class _PropertiPageState extends State<PropertiPage> {
  getProperti() {
    widget.fromHomePage == false
        ? context.read<PropertiBloc>().add(OnGetProperti(isRent: widget.isRent))
        : null;
  }

  @override
  void initState() {
    // TODO: implement initState
    getProperti();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final propertiSearch = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Image.asset('assets/img_banner_properti.jpeg'),
          SizedBox(height: 16),
          SearchForm(
            controller: propertiSearch,
            action: () {
              context.read<PropertiBloc>().add(OnGetProperti(
                  query: propertiSearch.text,
                  isRent: widget.isRent,
                  type: selectedType));
            },
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            selectedItem: selectedType,
            sellOrRent: widget.isRent == true ? 1 : 0,
          ),
          // Text('${selectedType}')
        ],
      );
    }

    Widget propertiTerbaru() {
      return BlocBuilder<PropertiBloc, PropertiState>(
        builder: (context, state) {
          if (state is PropertiLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PropertiError) {
            return TextFailure(message: state.message);
          }
          if (state is PropertiLoaded) {
            return Column(
              children: state.listPropertiModel!.data!.projects!
                  .map((propertiBaru) => NewPropertiCard(propertiBaru))
                  .toList(),
            );
          }
          return SizedBox();
        },
      );
      // BlocProvider(
      //   create: (context) =>
      //       PropertiBloc()..add(OnGetProperti(isRent: widget.isRent)),
      //   child: BlocBuilder<PropertiBloc, PropertiState>(
      //     builder: (context, state) {
      //       if (state is PropertiLoading) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //       if (state is PropertiError) {
      //         return TextFailure(message: state.message);
      //       }
      //       if (state is PropertiLoaded) {
      //         return Column(
      //           children: state.listPropertiModel.data!.projects!
      //               .map((propertiBaru) => NewPropertiCard(propertiBaru))
      //               .toList(),
      //         );
      //       }
      //       return SizedBox();
      //     },
      //   ),
      // );
    }

    Widget daftarProperti() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daftar Properti di Indonesia',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          Center(
            child: BlocBuilder<PropertiBloc, PropertiState>(
              builder: (context, state) {
                if (state is PropertiLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is PropertiError) {
                  return TextFailure(message: state.message);
                }
                if (state is PropertiLoaded) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 4,
                    children:
                        state.listPropertiModel!.data!.properties!.length == 0
                            ? [Text('Tidak ada properti')]
                            : state.listPropertiModel!.data!.properties!
                                .map((properti) => PropertiCard(properti))
                                .toList(),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: propertioAppBar(),
        drawer: SideBar(),
        body: Container(
          color: bgColor1,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              header(),
              SizedBox(height: 16),
              propertiTerbaru(),
              SizedBox(height: 16),
              daftarProperti(),
            ],
          ),
        ));
  }
}
