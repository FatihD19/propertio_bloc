import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/properti/properti_bloc.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/pages/Properti/properti_page.dart';

class ItemTipeApartemen extends StatelessWidget {
  String location;

  ItemTipeApartemen(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<PropertiBloc>()
            .add(OnGetProperti(query: location, isRent: false));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PropertiPage(fromHomePage: true, isRent: false)));
      },
      child: Stack(
        children: [
          Container(
            width: 126,
            height: 208,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img_tipe_apart.png')),
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
