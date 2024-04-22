import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/auth/auth_bloc.dart';
import 'package:propertio_mobile/bloc/monitoring/monitoring_bloc.dart';
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';

import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/sidebar.dart';
import 'package:propertio_mobile/ui/pages/Agen/agen_page.dart';
import 'package:propertio_mobile/ui/pages/Favorit/favorit_page.dart';
import 'package:propertio_mobile/ui/pages/Home/home_page.dart';
import 'package:propertio_mobile/ui/pages/Kpr/simulasi_kpr_page.dart';
import 'package:propertio_mobile/ui/pages/Monitoring/monitoring_properti_page.dart';
import 'package:propertio_mobile/ui/pages/Profile/profile_page.dart';
import 'package:propertio_mobile/ui/pages/Properti/properti_page.dart';
import 'package:propertio_mobile/ui/pages/Proyek/proyek_page.dart';
import 'package:propertio_mobile/ui/preview_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    context.read<MonitoringBloc>().add(OnGetProjectProgress());
    super.initState();
  }

  // Pages for Bottom Navigation Bar
  final List<Widget> _pages = [
    HomePage(),
    MonitoringPropertiPage(),
    AgentPage(),
    FavoritPage(),
    ProfilePage()
  ];
  int _selectedIndex = 0;
  // Sidebar menu items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/lg_propertio_home.png'),
      ),
      drawer: SideBar(forDashboard: true),
      body:
          // sidebarSection == true ? _buildContent() :
          _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Monitor',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Agent',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined),
              label: 'Profil',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor:
              // sidebarSection == true ? secondaryColor :
              secondaryColor,
          selectedItemColor:
              // sidebarSection == true ? secondaryColor :
              primaryColor),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    if ((index == 1 || index == 3 || index == 4) &&
        await AuthLocalDataSource.statusLogin() == false) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
