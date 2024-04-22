import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/pagination_button.dart';
import 'package:propertio_mobile/ui/component/search_form.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/widgets/properti_card.dart';
import 'package:propertio_mobile/ui/widgets/proyek_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  int _selectedIndex = 0;
  bool newProperti = true;

  getFavorite() async {
    // context.read<FavoriteBloc>().add(OnGetFavoriteProperty(page: 1));
    context.read<FavoriteBloc>().add(OnGetFavoriteProject(page: 1));
  }

  @override
  void initState() {
    // TODO: implement initState
    getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setFilter() {
      if (_selectedIndex == 0) {
        setState(() {});
        newProperti = true;
        context.read<FavoriteBloc>().add(OnGetFavoriteProject(page: 1));
      } else {
        setState(() {});
        newProperti = false;
        context.read<FavoriteBloc>().add(OnGetFavoriteProperty(page: 1));
      }
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Properti Favorit Saya',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          Center(
            child: ToggleSwitch(
              borderColor: [
                primaryColor,
              ],
              minWidth: (MediaQuery.of(context).size.width / 2) - 28,
              cornerRadius: 20,
              activeBgColors: [
                [Colors.white],
                [Colors.white]
              ],
              activeFgColor: primaryColor,
              inactiveBgColor: primaryColor,
              inactiveFgColor: Colors.white, // Set inactive text color to white
              initialLabelIndex: _selectedIndex,
              totalSwitches: 2,
              customTextStyles: [
                TextStyle(
                    fontWeight:
                        FontWeight.bold), // Add this line to make the text bold
                TextStyle(
                    fontWeight:
                        FontWeight.bold), // Add this line to make the text bold
              ],
              fontSize: 16,

              labels: ['Properti Baru', 'Properti'],
              radiusStyle: true,
              onToggle: (index) {
                _selectedIndex = index ?? 1;
                setFilter();
                print('switched to: $index');
              },
            ),
          ),
        ],
      );
    }

    Widget listFavPropertiBaru() {
      return Column(
        children: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is FavoriteError) {
                return TextFailure(message: state.message);
              }
              if (state is FavoritePropertyLoaded) {
                return state.favoriteProperty.data!.propertyFavorites!.isEmpty
                    ? Center(
                        child: Text('Tidak ada properti yang tersedia',
                            style: primaryTextStyle.copyWith(fontWeight: bold)),
                      )
                    : Column(
                        children: [
                          Column(
                            children: state
                                .favoriteProperty.data!.propertyFavorites!
                                .map((properti) =>
                                    PropertiCard(properti, isFavorite: true))
                                .toList(),
                          ),
                          NavigationButton(
                            currentPage: state.favoriteProperty.data!
                                .pagination!.currentPage!,
                            lastPage: state
                                .favoriteProperty.data!.pagination!.lastPage!,
                            implementLogic: (page) {
                              print('Navigated to page $page');
                              context
                                  .read<FavoriteBloc>()
                                  .add(OnGetFavoriteProperty(page: page));
                            },
                          ),
                        ],
                      );
              }
              return Container();
            },
          ),
        ],
      );
      // Column(
      //   children: [
      //     BlocProvider(
      //       create: (context) => FavoriteBloc()..add(OnGetFavoriteProperty()),
      //       child:
      //     ),
      //   ],
      // );
    }

    Widget listFavProperti() {
      return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteError) {
            return TextFailure(message: state.message);
          }
          if (state is FavoriteProjectLoaded) {
            return Column(
              children: [
                Column(
                  children: state.favoriteProject.data!.projectFavorites!
                      .map((project) => ProyekCard(project, isFavorite: true))
                      .toList(),
                ),
                NavigationButton(
                  currentPage:
                      state.favoriteProject.data!.pagination!.currentPage!,
                  lastPage: state.favoriteProject.data!.pagination!.lastPage!,
                  implementLogic: (page) {
                    print('Navigated to page $page');
                    context
                        .read<FavoriteBloc>()
                        .add(OnGetFavoriteProject(page: page));
                  },
                ),
              ],
            );
          }
          return Container();
        },
      );
      // BlocProvider(
      //   create: (context) => FavoriteBloc()..add(OnGetFavoriteProject()),
      //   child:
      // );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: bgColor1,
      child: ListView(
        children: [
          header(),
          SizedBox(height: 16),
          _selectedIndex == 1 ? listFavPropertiBaru() : listFavProperti(),
        ],
      ),
    );
  }
}
