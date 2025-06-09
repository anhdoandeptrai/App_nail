import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_nail/core/themes/app_color.dart';
import '../../bloc/verity_opt/verify_otp_bloc.dart';
import '../../bloc/verity_opt/verify_otp_event.dart';
import '../../bloc/verity_opt/verify_otp_state.dart';

class VerifyOtpForm extends StatefulWidget {
  final String email;
  final String accessToken;
  const VerifyOtpForm({
    super.key,
    required this.email,
    required this.accessToken,
  });

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String get _otp => _otpControllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(int idx, String value) {
    if (value.length == 1 && idx < 5) {
      _focusNodes[idx + 1].requestFocus();
    }
    if (value.isEmpty && idx > 0) {
      _focusNodes[idx - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = AppColor.brandSupernova;
    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Xác thực thành công!')));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        int seconds = 60;
        String? error;
        bool loading = false;
        bool resending = false;
        if (state is VerifyOtpFailure) error = state.error;
        if (state is VerifyOtpLoading) loading = true;
        if (state is VerifyOtpResending) resending = true;
        if (state is VerifyOtpResent) seconds = state.seconds;
        if (state is VerifyOtpInitial) seconds = state.seconds;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 160),
            const SizedBox(height: 24),
            const Text(
              'Xác thực tài khoản',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (i) {
                return Container(
                  width: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextField(
                    controller: _otpControllers[i],
                    focusNode: _focusNodes[i],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 22, letterSpacing: 2),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: mainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: mainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: mainColor, width: 2),
                      ),
                    ),
                    onChanged: (value) => _onOtpChanged(i, value),
                    onTap: () => _otpControllers[i].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _otpControllers[i].text.length,
                    ),
                  ),
                );
              }),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: const TextStyle(color: Colors.red)),
              ),
            if (seconds > 0) const SizedBox(height: 12),
            if (seconds > 0)
              Text(
                'Thời gian còn ${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')} để gửi lại mã',
                style: const TextStyle(fontSize: 15),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading || _otp.length != 6
                    ? null
                    : () {
                        context.read<VerifyOtpBloc>().add(
                          OtpSubmitted(
                            email: widget.email,
                            accessToken: widget.accessToken,
                            otp: _otp,
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Xác nhận', style: TextStyle(fontSize: 16)),
              ),
            ),
            if (seconds == 0) const SizedBox(height: 8),
            if (seconds == 0)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: resending
                      ? null
                      : () {
                          context.read<VerifyOtpBloc>().add(
                            OtpResendRequested(
                              email: widget.email,
                              accessToken: widget.accessToken,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor.withOpacity(0.15),
                    foregroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: resending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Gửi lại', style: TextStyle(fontSize: 16)),
                ),
              ),
          ],
        );
      },
    );
  }
}
