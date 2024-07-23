import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/profile/profile_bloc.dart';
import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';

import 'package:propertio_bloc/data/model/request/udpate_profil_request_model.dart';
import 'package:propertio_bloc/data/model/responses/profil_response_model.dart';
import 'package:propertio_bloc/constants/api_path.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/shared/ui/components/button.dart';

import 'package:propertio_bloc/shared/ui/components/container_style.dart';
import 'package:propertio_bloc/shared/ui/components/text_failure.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

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
                  profile?.pictureProfile == null
                      ? CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 100,
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            ApiPath.image('${profile?.pictureProfile}'),
                            scale: 1.0,
                          ),
                          // child: Image.network(
                          //   ApiPath.image('${profile?.pictureProfile}'),
                          //   width: 100,
                          //   height: 100,
                          //   fit: BoxFit.cover,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return CircleAvatar(
                          //       backgroundColor: Colors.black,
                          //       child: Icon(
                          //         Icons.person_outline_rounded,
                          //         size: 24,
                          //       ),
                          //     );
                          //   },
                          // ),
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
                    text: 'Keluar Akun',
                    onPressed: () {
                      AuthLocalDataSource().clearLocalStorage();
                      context.read<ProfileBloc>().add(OnDisposeProfile());
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    icon: Icons.login_rounded,
                  ),
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
