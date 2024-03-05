import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/auth/auth_bloc.dart';
import 'package:propertio_mobile/bloc/profile/profile_bloc.dart';
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/datasource/kpr_local_calculation.dart';
import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/pages/Agen/agen_page.dart';
import 'package:propertio_mobile/ui/pages/Kpr/simulasi_kpr_page.dart';
import 'package:propertio_mobile/ui/pages/Properti/properti_page.dart';
import 'package:propertio_mobile/ui/pages/Proyek/proyek_page.dart';

class SideBar extends StatelessWidget {
  bool? forDashboard;
  SideBar({this.forDashboard = false, super.key});

  @override
  Widget build(BuildContext context) {
    Widget menuSidebar(String item, String img, Widget page) {
      return Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120), color: Colors.white),
        child: ListTile(
          leading: Image.asset(img, width: 24, height: 24),
          title: Text(item, style: primaryTextStyle.copyWith(fontSize: 14)),
          onTap: () {
            Navigator.pop(context);
            forDashboard == true
                ? Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page))
                : Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => page));
          },
        ),
      );
    }

    Widget sidebar({String? fullname, String? imgProfil, bool? isLogin}) {
      return Drawer(
        backgroundColor: Color(0xffF7F7F7),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 100, // To change the height of DrawerHeader
                    width: double.infinity,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/bg_header_sidebar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white, width: 0.6),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffD9D9D9).withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: isLogin == false
                              ? ListTile(
                                  tileColor: Colors.transparent,
                                  leading: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.person_outline_rounded,
                                          size: 18)),
                                  title: Text(
                                    'Login/Registrasi',
                                    style: buttonTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 16),
                                      )),
                                )
                              : ListTile(
                                  tileColor: Colors.transparent,
                                  leading: Image.network(
                                    ApiPath.image('${imgProfil}'),
                                    width: 48,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          size: 24,
                                        ),
                                      );
                                    },
                                  ),
                                  title: Text(
                                    'Halo Selamat Datang',
                                    style: buttonTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${fullname}',
                                    style: buttonTextStyle,
                                  ),
                                )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        menuSidebar(
                            'Beli', 'assets/ic_buy.png', PropertiPage()),
                        menuSidebar('Sewa', 'assets/ic_sewa.png',
                            PropertiPage(isRent: true)),
                        menuSidebar('Agent', 'assets/ic_agent.png',
                            AgentPage(forSidebar: true)),
                        menuSidebar('Properti Baru',
                            'assets/ic_new_properti.png', ProyekPage()),
                        menuSidebar(
                            'KPR', 'assets/ic_kpr.png', SimulasiKprPage()),
                        menuSidebar('Berita', 'assets/ic_news.png',
                            MortgageCalculator()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  isLogin == false
                      ? SizedBox()
                      : CustomButton(
                          text: 'Keluar Akun',
                          onPressed: () {
                            AuthLocalDataSource().clearLocalStorage();
                            context.read<ProfileBloc>().add(OnDisposeProfile());
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          icon: Icons.login_rounded,
                        ),
                  SizedBox(height: 8),
                  Text('App version 0.1',
                      style: secondaryTextStyle.copyWith(fontSize: 12))
                ],
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return sidebar(
              fullname: '${state.data.data?.userData?.fullName}',
              imgProfil: '${state.data.data?.userData?.pictureProfile}',
              isLogin: true);
        }
        return sidebar(isLogin: false);
      },
    );
    // return BlocBuilder<AuthBloc, AuthState>(
    //   builder: (context, state) {
    //     if (state is AuthSuccess) {
    //       return sidebar(
    //           fullname: '${state.user.data?.user?.fullName}',
    //           imgProfil: '${state.user.data?.user?.pictureProfileFile}',
    //           isLogin: true);
    //     }
    //     return sidebar(isLogin: false);
    //   },
    // );
  }
}

AppBar propertioAppBar() {
  return AppBar(
    centerTitle: true,
    title: Image.asset('assets/lg_propertio_home.png'),
  );
}
