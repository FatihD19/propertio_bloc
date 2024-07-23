import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/pages/Proyek/proyek_page.dart';

class ItemTipeApartemen extends StatelessWidget {
  String? img;
  String location;

  ItemTipeApartemen(this.location, {this.img, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProjectBloc>().add(OnGetProject(query: location));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProyekPage()));
      },
      child: Stack(
        children: [
          Container(
            width: 126,
            height: 208,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(img ?? 'assets/img_tipe_apart.png')),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
              top: 9,
              left: 9,
              child: Text(location,
                  style: buttonTextStyle.copyWith(
                      fontWeight: bold, fontSize: 12))),
        ],
      ),
    );
  }
}
