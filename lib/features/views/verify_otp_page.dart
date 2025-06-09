import 'package:app_nail/features/bloc/verity_opt/verify_otp_bloc.dart';
import 'package:app_nail/features/bloc/verity_opt/verify_otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_nail/core/themes/app_color.dart';
import 'widgets/verify_otp_form.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;
  final String accessToken;

  const VerifyOtpPage({
    super.key,
    required this.email,
    required this.accessToken,
  });

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  @override
  Widget build(BuildContext context) {
    final mainColor = AppColor.brandSupernova;
    return BlocProvider(
      create: (_) => VerifyOtpBloc(),
      child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xác thực thành công!')),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: BackButton(color: mainColor),
              title: const Text(
                'Xác minh tài khoản',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: VerifyOtpForm(
                  email: widget.email,
                  accessToken: widget.accessToken,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
