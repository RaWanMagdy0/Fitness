import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String _privacyContent = '''
    <div style="padding: 16px;">
      <h1 style="color: #FF7300; text-align: center;">Privacy Policy</h1>
      <p style="line-height: 1.6;">
        Your privacy is important to us. This Privacy Policy explains how we collect, 
        use, disclose, and safeguard your information when you use our application.
      </p>
      <h2 style="color: #FF7300;">1. Information We Collect</h2>
      <p style="line-height: 1.6;">
        We may collect personal information such as your name, email, and contact details 
        when you register or interact with our services.
      </p>
      <h2 style="color: #FF7300;">2. How We Use Your Information</h2>
      <p style="line-height: 1.6;">
        The collected information is used to provide better services, personalize user 
        experiences, and ensure security.
      </p>
      <h2 style="color: #FF7300;">3. Data Security</h2>
      <p style="line-height: 1.6;">
        We implement industry-standard security measures to protect your personal information.
      </p>
      <h2 style="color: #FF7300;">4. Contact Us</h2>
      <p style="line-height: 1.6;">
        If you have any questions about this Privacy Policy, contact us at:<br>
        Email: support@yourapp.com<br>
        Phone: +0 (000) 000-0000
      </p>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Privacy Policy',
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
            data: _privacyContent,
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
            },
          ),
        ),
      ),
    );
  }
}
