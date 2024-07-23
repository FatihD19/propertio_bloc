// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:propertio_bloc/bloc/agent/agent_bloc.dart';
import 'package:propertio_bloc/bloc/auth/auth_bloc.dart';

import 'package:propertio_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_bloc/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_bloc/bloc/kpr/kpr_cubit.dart';

import 'package:propertio_bloc/bloc/profile/profile_bloc.dart';

import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/bloc/propertyType/property_type_bloc.dart';

import 'package:propertio_bloc/bloc/unit/unit_bloc.dart';

import 'package:propertio_bloc/injection.dart';

import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/pages/Auth/login_page.dart';

import 'package:propertio_bloc/pages/dashboard.dart';
import 'package:propertio_bloc/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<AuthBloc>()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(
          create: (context) => locator<HomePageBloc>()..add(OnGetHomePage()),
        ),
        BlocProvider(
          create: (context) => locator<AgentBloc>()..add(OnGetAgent()),
        ),
        BlocProvider(
          create: (context) => locator<ProjectBloc>()..add(OnGetProject()),
        ),
        BlocProvider(
          create: (context) => locator<UnitBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              locator<PropertyTypeBloc>()..add(OnGetPropertyType()),
        ),
        BlocProvider(
          create: (context) => locator<ProfileBloc>()..add(OnGetProfile()),
        ),
        BlocProvider(create: (context) => KprCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: bgColor1,
              elevation: 0,
            )),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/dashboard': (context) => Dashboard(),
        },
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
