import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_nail/core/themes/app_color.dart';
import 'package:app_nail/features/bloc/forgot_password/forgot_password_bloc.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final mainColor = AppColor.brandSupernova;
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quên mật khẩu'),
          leading: BackButton(color: mainColor),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: const ForgotPasswordForm(),
          ),
        ),
      ),
    );
  }
}
