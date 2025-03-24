import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HelpAndSecurityScreen extends StatelessWidget {
  const HelpAndSecurityScreen({super.key});

  static const String _content = '''
    <div style="padding: 16px; color: #FFFFFF;">
      <h1 style="color: #FF7300; text-align: center;">Help</h1>
      <h2 style="color: #FF7300;">🔹 Help & Support</h2>
      <p style="line-height: 1.6;">
        If you need assistance, you can reach our support team 24/7. 
        We are here to help you with any issues or inquiries.
      </p>
      <h2 style="color: #FF7300;">🔐 Security & Privacy</h2>
      <p style="line-height: 1.6;">
        We take security seriously. Your data is encrypted and stored securely. 
        If you suspect any security issues, contact us immediately.
      </p>
      <h2 style="color: #FF7300;">📞 Contact Us</h2>
      <p style="line-height: 1.6;">
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
          'Help',
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
            data: _content,
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
