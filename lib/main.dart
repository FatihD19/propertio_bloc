// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propertio_mobile/bloc/address/cities/cities_cubit.dart';
import 'package:propertio_mobile/bloc/address/province/province_cubit.dart';

import 'package:propertio_mobile/bloc/agent/agent_bloc.dart';
import 'package:propertio_mobile/bloc/auth/auth_bloc.dart';

import 'package:propertio_mobile/bloc/developer/developer_bloc.dart';
import 'package:propertio_mobile/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_mobile/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_mobile/bloc/kpr/kpr_cubit.dart';
import 'package:propertio_mobile/bloc/monitoring/monitoring_bloc.dart';
import 'package:propertio_mobile/bloc/profile/profile_bloc.dart';
import 'package:propertio_mobile/bloc/project/project_bloc.dart';
import 'package:propertio_mobile/bloc/properti/properti_bloc.dart';
import 'package:propertio_mobile/bloc/propertyType/property_type_bloc.dart';
import 'package:propertio_mobile/bloc/sendMessage/send_message_bloc.dart';
import 'package:propertio_mobile/bloc/unit/unit_bloc.dart';

import 'package:propertio_mobile/injection.dart';

import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/pages/Auth/login_page.dart';
import 'package:propertio_mobile/ui/pages/Auth/register_page.dart';
import 'package:propertio_mobile/ui/pages/dashboard.dart';
import 'package:propertio_mobile/ui/pages/splash_page.dart';
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
          create: (context) => AgentBloc()..add(OnGetAgent()),
        ),
        BlocProvider(
          create: (context) => ProjectBloc()..add(OnGetProject()),
        ),
        BlocProvider(
          create: (context) => PropertiBloc(),
        ),
        BlocProvider(
          create: (context) => UnitBloc(),
        ),
        BlocProvider(
          create: (context) => DeveloperBloc(),
        ),
        BlocProvider(
          create: (context) => locator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) => PropertyTypeBloc()..add(OnGetPropertyType()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(OnGetProfile()),
        ),
        BlocProvider(
          create: (context) => locator<ProvinceCubit>()..getProvinces(),
        ),
        BlocProvider(
          create: (context) => locator<CitiesCubit>(),
        ),
        BlocProvider(create: (context) => locator<SendMessageBloc>()),
        BlocProvider(create: (context) => KprCubit()),
        BlocProvider(
            create: (context) =>
                locator<MonitoringBloc>()..add(OnGetProjectProgress())),
        // BlocProvider(create: (context) => AddressBloc()..add(OnGetProvince())),
        // BlocProvider(create: (context) => locator<AddressCubit>()),
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
          '/register': (context) => RegisterPage(),
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
