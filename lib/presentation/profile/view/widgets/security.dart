import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  static const String _securityContent = '''
    <div style="padding: 16px; color: #FFFFFF;">
      <h1 style="color: #FF7300; text-align: center;">Security</h1>
      <p style="line-height: 1.6;">
        Your security is our priority. Learn how to keep your account safe.
      </p>
      <h2 style="color: #FF7300;">1. Change Password</h2>
      <p style="line-height: 1.6;">
        Update your password regularly to maintain account security.
      </p>
      <h2 style="color: #FF7300;">2. Two-Factor Authentication</h2>
      <p style="line-height: 1.6;">
        Enable 2FA to add an extra layer of protection to your account.
      </p>
      <h2 style="color: #FF7300;">3. Privacy Settings</h2>
      <p style="line-height: 1.6;">
        Manage your privacy preferences and control your data.
      </p>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Security',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Html(
            data: _securityContent,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
              "h1": Style(
                fontSize: FontSize(24.sp),
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7300),
              ),
              "h2": Style(
                fontSize: FontSize(18.sp),
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF7300),
              ),
              "p": Style(
                fontSize: FontSize(14.sp),
                lineHeight: LineHeight(1.6),
              ),
            },
          ),
        ),
      ),
    );
  }
}
