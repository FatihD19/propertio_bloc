import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/address/cities/cities_cubit.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/dropdown_type.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');

  String _selectedProvince = 'Pilih Provinsi';
  String _selectedCity = 'Pilih Kota';
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/lg_propertio.jpg',
                width: 25,
                height: 33,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Propertio',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Selamat Datang',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 32)),
          SizedBox(height: 8),
          Text('Mari Segera Bergabung',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
        ],
      );
    }

    Widget alamatForm() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alamat',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          Container(
            height: 68,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF79747E),
              ),
            ),
            child: TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Masukan Alamat Anda',
                hintStyle: secondaryTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      );
    }

    Widget uploadFoto() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tambahkan Foto Profil',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: bgColor1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline_outlined),
                SizedBox(width: 8),
                Text(
                  'Tambahkan',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget form() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: firstNameController,
            title: 'Nama Depan',
            mandatory: true,
            hintText: 'Masukan Nama Depan Anda',
          ),
          CustomTextField(
            controller: lastNameController,
            title: 'Nama Belakang',
            mandatory: true,
            hintText: 'Masukan Nama Belakang Anda',
          ),
          CustomTextField(
            controller: emailController,
            title: 'Email',
            mandatory: true,
            hintText: 'Masukan Email Anda',
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Nomor Telepon',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            TextSpan(
              text: ' *',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
                color: Colors.red,
              ),
            ),
          ])),
          PhoneNumberInputField(controller: phoneController),
          SizedBox(height: 10),
          Text(
            'Kata Sandi',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          PasswordField(
            passontroller: passwordController,
            hintText: 'Masukan Kata Sandi Anda',
          ),
          SizedBox(height: 20),
          Text(
            'Konfirmasi Kata Sandi',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          PasswordField(
            passontroller: confirmPasswordController,
            hintText: 'Masukan Konfirmasi Kata Sandi Anda',
          ),
          SizedBox(height: 20),
          AddressForm(
            _selectedProvince,
            _selectedCity,
            onChangedProvince: (value) {
              setState(() {
                context.read<CitiesCubit>().disposeCity();
                _selectedCity = 'Pilih Kota';
                _selectedProvince = value!;
              });
            },
            onChangedCity: (value) {
              setState(() {
                _selectedCity = value!;
              });
            },
          ),
          alamatForm(),
        ],
      );
    }

    Widget actionBtn() {
      return Column(
        children: [
          CustomButton(
              text: 'Bergabung Sekarang',
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sudah memiliki akun?',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Klik disini',
                    style: thirdTextStyle.copyWith(fontSize: 12)),
              )
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            header(),
            SizedBox(height: 26),
            form(),
            SizedBox(height: 20),
            uploadFoto(),
            SizedBox(height: 20),
            actionBtn(),
          ],
        ),
      )),
    );
  }
}
