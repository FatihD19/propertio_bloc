import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/profile/profile_bloc.dart';
import 'package:propertio_mobile/data/model/responses/profil_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';
import 'package:propertio_mobile/ui/view/edit_profil_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget infoRow(String img, String title) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Image.asset(img, width: 16, height: 16),
            SizedBox(width: 4),
            Text(title, style: primaryTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      );
    }

    Widget gantiPassword() {
      return Container(
          padding: EdgeInsets.all(16),
          decoration: customBoxDecoration(),
          child: Column(
            children: [
              Text('Ganti Kata Sandi',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16)),
              PasswordField(hintText: 'Kata Sandi Lama'),
              PasswordField(hintText: 'Kata Sandi Baru'),
              PasswordField(hintText: 'Konfirmasi Kata Sandi'),
              SizedBox(height: 16),
              CustomButton(
                  text: 'Ganti Kata Sandi',
                  color: Color(0xff21C35E),
                  onPressed: () {})
            ],
          ));
    }

    Widget infoProfile() {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: customBoxDecoration(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return Column(
                children: [
                  Text('Login / Register untuk melihat Profil',
                      style: primaryTextStyle.copyWith(fontWeight: bold)),
                  SizedBox(height: 16),
                  CustomButton(
                      text: 'Masuk Sekarang',
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      }),
                ],
              );
            }
            if (state is ProfileSuccess) {
              UserData? profile = state.data.data?.userData!;
              return Column(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Image.network(
                        ApiPath.image('${profile?.pictureProfile}'),
                        width: 48,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 24,
                            ),
                          );
                        },
                      )
                      // CircleAvatar(
                      //     backgroundImage: AssetImage('assets/img_profile.png')),
                      ),
                  Text('${profile?.fullName}',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 4),
                        Column(
                          children: [
                            infoRow('assets/ic_mail.png',
                                '${state.data.data?.email}'),
                            infoRow(
                                'assets/ic_mini_call.png', '${profile?.phone}'),
                            infoRow('assets/ic_location.png',
                                '${profile?.city}, ${profile?.province}'),
                          ],
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  CustomButton(
                      text: 'Edit Profil',
                      icon: Icons.mode_edit_outline_outlined,
                      color: Color(0xff949494),
                      onPressed: () {
                        showCustomSnackbar(
                            context, ModalEditProfile(state.data));
                      }),
                  SizedBox(height: 16),
                  gantiPassword(),
                ],
              );
            }
            return Container();
          },
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: bgColor1,
      child: ListView(
        children: [
          infoProfile(),
        ],
      ),
    );
  }
}