import 'package:get_it/get_it.dart';
import 'package:propertio_mobile/bloc/address/cities/cities_cubit.dart';
import 'package:propertio_mobile/bloc/address/province/province_cubit.dart';

import 'package:propertio_mobile/bloc/auth/auth_bloc.dart';

import 'package:propertio_mobile/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_mobile/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_mobile/bloc/sendMessage/send_message_bloc.dart';
import 'package:propertio_mobile/data/datasource/address_remote_datasource.dart';
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/datasource/favortite_remote_datasource.dart';
import 'package:propertio_mobile/data/datasource/homepage_remote_datasource.dart';
import 'package:propertio_mobile/data/datasource/login_remote_datasource.dart';
import 'package:propertio_mobile/data/datasource/send_message_remote_datasource.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerFactory(() => HomePageBloc(locator()));

  locator.registerFactory(() => AuthBloc(locator(), locator()));

  locator.registerFactory(() => ProvinceCubit(locator()));

  locator.registerFactory(() => CitiesCubit(locator()));
  locator.registerFactory(() => SendMessageBloc(locator()));
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
}
