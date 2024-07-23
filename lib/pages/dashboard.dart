import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/auth/auth_bloc.dart';

import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';

import 'package:propertio_bloc/constants/api_path.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/pages/Agen/agen_page.dart';
import 'package:propertio_bloc/pages/Favorit/favorit_page.dart';
import 'package:propertio_bloc/pages/Home/home_page.dart';
import 'package:propertio_bloc/pages/Profile/profile_page.dart';
import 'package:propertio_bloc/shared/ui/components/bottom_modal.dart';
import 'package:propertio_bloc/shared/ui/components/sidebar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Pages for Bottom Navigation Bar
  final List<Widget> _pages = [
    HomePage(),
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
    if ((index == 2 || index == 3) &&
        await AuthLocalDataSource.statusLogin() == false) {
      Navigator.pushReplacementNamed(context, '/login');
      showMessageModal(context, 'Anda harus login terlebih dahulu');
    }
  }
}
