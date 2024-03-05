import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/address/cities/cities_cubit.dart';
import 'package:propertio_mobile/bloc/address/province/province_cubit.dart';

import 'package:propertio_mobile/data/model/responses/address_response_model.dart';
import 'package:propertio_mobile/data/model/responses/profil_response_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/dropdown_type.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';

class ModalEditProfile extends StatefulWidget {
  ProfilResponseModel profil;
  ModalEditProfile(this.profil, {super.key});

  @override
  State<ModalEditProfile> createState() => _ModalEditProfileState();
}

class _ModalEditProfileState extends State<ModalEditProfile> {
  ProvinceResponseModel selectedProvince =
      ProvinceResponseModel(id: '0', name: 'Pilih Provinsi');
  CitiesResponseModel selectedCity =
      CitiesResponseModel(id: '0', name: 'Pilih Kota');

  String? _selectedProvince;
  String? _selectedCity;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    context.read<CitiesCubit>().disposeCity();
    nameController.text = widget.profil.data!.userData!.fullName!;
    emailController.text = widget.profil.data!.email!;
    phoneController.text = widget.profil.data!.userData!.phone!;
    addressController.text = widget.profil.data!.userData!.address!;
    _selectedProvince = widget.profil.data!.userData!.province;
    _selectedCity = widget.profil.data!.userData!.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget getProvince() {
      return BlocBuilder<ProvinceCubit, ProvinceState>(
        builder: (context, state) {
          if (state is ProvinceLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProvinceError) {
            return TextFailure(message: state.message);
          }
          if (state is ProvinceLoaded) {
            List<ProvinceResponseModel> provinces = state.provinces;

            return CustomDropdown<String>(
              value: _selectedProvince!,
              items: provinces.map((e) => '${e.name}').toList(),
              label: 'Provinsi',
              onChanged: (value) {
                setState(() {
                  var idProvince = provinces
                      .firstWhere((element) => element.name == value)
                      .id;
                  _selectedProvince = value;
                  context.read<CitiesCubit>().disposeCity();
                  _selectedCity = 'Pilih Kota';
                  print(value);
                  print('$idProvince');
                  context.read<CitiesCubit>().getCities('$idProvince');
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            );
          }
          return Container();
        },
      );
    }

    Widget getCity() {
      return BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, state) {
          if (state is CitiesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CitiesError) {
            return TextFailure(message: state.message);
          }
          if (state is CitiesLoaded) {
            List<CitiesResponseModel> cities = state.cities;

            return CustomDropdown<String>(
              value: _selectedCity!,
              items: cities.map((e) => '${e.name}').toList(),
              label: 'Kota',
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            );
          }
          return IgnorePointer(
            ignoring: true,
            child: CustomDropdown<String>(
              value: _selectedCity!,
              items: [_selectedCity!],
              label: 'Kota',
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            ),
          );
        },
      );
    }

    return Container(
        height: 800,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: ListView(
          children: [
            Text(
              'Ubah Data Profil',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: nameController,
              title: 'Nama Lengkap',
              mandatory: true,
              hintText: 'Masukan Nama Lengkap Anda',
            ),
            CustomTextField(
              controller: emailController,
              title: 'Email',
              mandatory: true,
              hintText: 'Masukan Email Anda',
            ),
            CustomTextField(
              controller: phoneController,
              title: 'Nomor Telepon',
              mandatory: true,
              hintText: 'Masukan Nomor Teleopon Anda',
            ),
            getProvince(),
            getCity(),
            CustomTextField(
              controller: addressController,
              title: 'Alamat',
              mandatory: true,
              hintText: 'Masukan Alamat Anda',
            ),
            CustomButton(text: 'Simpan', onPressed: () {})
          ],
        ));
  }
}
