import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/auth/auth_bloc.dart';
import 'package:propertio_mobile/bloc/profile/profile_bloc.dart';
import 'package:propertio_mobile/data/model/request/login_request_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

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
          SizedBox(height: 8),
          Image.asset(
            'assets/img_propertio_ilus.png',
            width: 220,
            height: 177,
          ),
        ],
      );
    }

    Widget passwordInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kata Sandi*",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            PasswordField(
                passontroller: passwordController,
                hintText: 'Masukan Kata Sandi')
          ],
        ),
      );
    }

    Widget form() {
      return Column(
        children: [
          CustomTextField(
            controller: emailController,
            title: 'Email',
            mandatory: true,
            hintText: 'Masukan Email Anda',
          ),
          passwordInput()
        ],
      );
    }

    Widget actionBtn() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tidak dapat mengingat kata sandi anda?',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              TextButton(
                onPressed: () {},
                child: Text('Klik disini',
                    style: thirdTextStyle.copyWith(fontSize: 12)),
              )
            ],
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                showMessageModal(context, state.message);
              }
              if (state is AuthSuccess) {
                context.read<ProfileBloc>().add(OnGetProfile());
                Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomButton(
                  text: 'Masuk Sekarang',
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogin(LoginRequestModel(
                        email: emailController.text,
                        password: passwordController.text)));
                  });
            },
          ),
          SizedBox(height: 8),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child:
                  Text('Lewati', style: thirdTextStyle.copyWith(fontSize: 12))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Belum memiliki akun?',
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            header(),
            form(),
            actionBtn(),
          ],
        ),
      ),
    );
  }
}
