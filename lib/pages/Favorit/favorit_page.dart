import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/shared/ui/components/pagination_button.dart';
import 'package:propertio_bloc/shared/ui/widgets/proyek_card.dart';

import 'package:propertio_bloc/shared/ui/components/search_form.dart';

import 'package:propertio_bloc/shared/ui/components/text_failure.dart';

import 'package:toggle_switch/toggle_switch.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  getFavorite() async {
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
          Text('Properti Favorit Saya',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          listFavProperti(),
        ],
      ),
    );
  }
}
