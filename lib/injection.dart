import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:propertio_bloc/bloc/agent/agent_bloc.dart';

import 'package:propertio_bloc/bloc/auth/auth_bloc.dart';

import 'package:propertio_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_bloc/bloc/homePage/home_page_bloc.dart';

import 'package:propertio_bloc/bloc/profile/profile_bloc.dart';

import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/bloc/propertyType/property_type_bloc.dart';

import 'package:propertio_bloc/bloc/unit/unit_bloc.dart';
import 'package:propertio_bloc/data/datasource/address_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/agent_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';

import 'package:propertio_bloc/data/datasource/favortite_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/homepage_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/auth_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/profile_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/project_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/properti_remote_datasource.dart';
import 'package:propertio_bloc/data/datasource/send_message_remote_datasource.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerFactory(() => HomePageBloc(locator()));

  locator.registerFactory(() => AuthBloc(locator(), locator()));

  locator.registerFactory(() => AgentBloc(locator()));
  locator.registerFactory(() => ProjectBloc(locator()));
  locator.registerFactory(() => UnitBloc(locator()));
  locator.registerFactory(() => PropertyTypeBloc(locator()));
  locator.registerFactory(() => ProfileBloc(locator()));
  // locator.registerFactory(() => AddressCubit(locator()));

  locator.registerFactory(() => FavoriteBloc(locator()));

  locator.registerLazySingleton<HomePageRemoteDataSource>(
      () => HomePageRemoteDataSource());
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());
  locator
      .registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  locator.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSource());
  locator.registerLazySingleton<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSource());
  locator.registerLazySingleton<SendMessageRemoteDataSource>(
      () => SendMessageRemoteDataSource());

  locator.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource());
  locator.registerLazySingleton<PropertiRemoteDataSource>(
      () => PropertiRemoteDataSource());
  locator.registerLazySingleton<AgentRemoteDataSource>(
      () => AgentRemoteDataSource());
  locator.registerLazySingleton<ProjectRemoteDataSource>(
      () => ProjectRemoteDataSource());

  //external
  final secureStorage = FlutterSecureStorage();
  locator.registerLazySingleton(() => secureStorage);
}
