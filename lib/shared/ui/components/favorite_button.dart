// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_bloc/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';

import 'package:propertio_bloc/pages/Home/home_page.dart';
import 'package:propertio_bloc/shared/ui/components/bottom_modal.dart';

class FavoriteButton extends StatefulWidget {
  bool? isFavorite;
  String? propertyCode;
  String? projectCode;

  FavoriteButton({
    this.isFavorite = false,
    this.propertyCode,
    this.projectCode,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteSuccessAdd &&
            state.projectCode == widget.projectCode) {
          setState(() {
            _isFavorite = true;
          });
        } else if (state is FavoriteSuccessDelete &&
            state.projectCode == widget.projectCode) {
          setState(() {
            _isFavorite = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          if (_isFavorite) {
            context.read<FavoriteBloc>().add(OnDeleteFavorite(
                  propertyCode: widget.propertyCode,
                  projectCode: widget.projectCode,
                ));
          } else {
            context.read<FavoriteBloc>().add(OnAddFavorite(
                  propertyCode: widget.propertyCode,
                  projectCode: widget.projectCode,
                ));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff94949480).withOpacity(0.5),
          ),
          child: Center(
            child: _isFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 18,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
          ),
        ),
      ),
    );
  }
}
// class FavoriteButton extends StatefulWidget {
//   bool? isFavorite;
//   String? propertyCode;
//   String? projectCode;

//   FavoriteButton(
//       {this.isFavorite = false, this.propertyCode, this.projectCode});

//   @override
//   State<FavoriteButton> createState() => _FavoriteButtonState();
// }

// class _FavoriteButtonState extends State<FavoriteButton> {
//   void toogleFavorite(String projectCode) async {
//     if (await AuthLocalDataSource.statusLogin() == false) {
//       errorDialog(context, 'Anda harus login terlebih dahulu',
//           'Untuk menambahkan ke favorit', onConfirm: () {
//         Navigator.pushNamed(context, '/login');
//       });
//       return;
//     }
//     if (widget.isFavorite == true) {
//       confirmDialog(context, 'Hapus dari favorit',
//           'Apakah anda yakin ingin menghapus dari favorit?', () {
//         context.read<FavoriteBloc>().add(
//               OnDeleteFavorite(
//                 propertyCode: widget.propertyCode,
//                 projectCode: widget.projectCode,
//               ),
//             );
//         widget.isFavorite = false;
//         showMessageModal(context, 'Berhasil menghapus Properti favorit',
//             color: Colors.green);
//         context.read<HomePageBloc>().add(OnGetHomePage());
//       });
//     } else {
//       context.read<FavoriteBloc>().add(
//             OnAddFavorite(
//               propertyCode: widget.propertyCode,
//               projectCode: widget.projectCode,
//             ),
//           );
//       widget.isFavorite = true;
//     }
//   }

//   addFavorite(bool isDelete) async {
//     isDelete
//         ? confirmDialog(context, 'Hapus dari favorit',
//             'Apakah anda yakin ingin menghapus dari favorit?', () {
//             context.read<FavoriteBloc>().add(
//                   OnDeleteFavorite(
//                     propertyCode: widget.propertyCode,
//                     projectCode: widget.projectCode,
//                   ),
//                 );
//             widget.isFavorite = false;
//             showMessageModal(context, 'Berhasil menghapus Properti favorit',
//                 color: Colors.green);
//             context.read<HomePageBloc>().add(OnGetHomePage());
//           })
//         : succsessDialog(context, 'Berhasil menambahkan ke favorit', () {
//             context.read<FavoriteBloc>().add(
//                   OnAddFavorite(
//                     propertyCode: widget.propertyCode,
//                     projectCode: widget.projectCode,
//                   ),
//                 );
//             widget.isFavorite = true;
//             context.read<HomePageBloc>().add(OnGetHomePage());
//           });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FavoriteBloc, FavoriteState>(
//       listener: (context, state) {
//         if (state is FavoriteError) {
//           showMessageModal(context, state.message);
//         }
//         if (state is FavoriteSuccessAdd) {
//           showMessageModal(context, 'Berhasil menambahkan ke favorit',
//               color: Colors.green);
//         }
//         // if (state is FavoriteSuccessDelete) {
//         //   showMessageModal(context, 'Berhasil menghapus dari favorit');
//         // }
//       },
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () async {
//             toogleFavorite(widget.projectCode!);
//             // await AuthLocalDataSource.statusLogin() == false
//             //     ? errorDialog(context, 'Anda harus login terlebih dahulu',
//             //         'Untuk menambahkan ke favorit', onConfirm: () {
//             //         Navigator.pushNamed(context, '/login');
//             //       })
//             //     : setState(() {
//             //         addFavorite(widget.isFavorite!);

//             //         // widget.isFavorite = !widget.isFavorite!;
//             //       });
//           },
//           child: Container(
//             padding: EdgeInsets.all(4),
//             width: 28,
//             height: 28,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xff94949480).withOpacity(0.5),
//               // boxShadow: [
//               //   BoxShadow(
//               //     color: Color(0xff94949480)..withOpacity(0.5),
//               //     spreadRadius: 1,
//               //     blurRadius: 0.8,
//               //   ),
//               // ]
//             ),
//             child: Center(
//                 child: (widget.isFavorite == true)
//                     ? Icon(Icons.favorite_rounded, color: Colors.red, size: 18)
//                     : Icon(
//                         Icons.favorite_border_outlined,
//                         color: Colors.white,
//                         size: 18,
//                       )),
//           ),
//         );
//       },
//     );
//   }
// }
