// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hey There`
  String get hey_there {
    return Intl.message('Hey There', name: 'hey_there', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email_text {
    return Intl.message('Email', name: 'email_text', desc: '', args: []);
  }

  /// `Password `
  String get password {
    return Intl.message('Password ', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password `
  String get confirm_password {
    return Intl.message(
      'Confirm Password ',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Register `
  String get register {
    return Intl.message('Register ', name: 'register', desc: '', args: []);
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet?`
  String get dont_have_an_account_yet {
    return Intl.message(
      'Don\'t have an account yet?',
      name: 'dont_have_an_account_yet',
      desc: '',
      args: [],
    );
  }

  /// `CREATE AN ACCOUNT`
  String get create_an_account {
    return Intl.message(
      'CREATE AN ACCOUNT',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `First Name `
  String get first_name {
    return Intl.message('First Name ', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name `
  String get last_name {
    return Intl.message('Last Name ', name: 'last_name', desc: '', args: []);
  }

  /// `Next `
  String get next {
    return Intl.message('Next ', name: 'next', desc: '', args: []);
  }

  /// `Already Have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already Have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `TELL US ABOUT YOURSELF!`
  String get tell_us_about_yourself {
    return Intl.message(
      'TELL US ABOUT YOURSELF!',
      name: 'tell_us_about_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Need To Know Your Gender`
  String get we_need_to_know_your_gender {
    return Intl.message(
      'Need To Know Your Gender',
      name: 'we_need_to_know_your_gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `HOW OLD ARE YOU ?`
  String get how_old_are_you {
    return Intl.message(
      'HOW OLD ARE YOU ?',
      name: 'how_old_are_you',
      desc: '',
      args: [],
    );
  }

  /// `This Helps Us Create Your Personalized Plan`
  String get this_helps_us_create_Your_personalized_plan {
    return Intl.message(
      'This Helps Us Create Your Personalized Plan',
      name: 'this_helps_us_create_Your_personalized_plan',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `WHAT IS YOUR WEIGHT?`
  String get what_is_your_weight {
    return Intl.message(
      'WHAT IS YOUR WEIGHT?',
      name: 'what_is_your_weight',
      desc: '',
      args: [],
    );
  }

  /// `WHAT IS YOUR HEIGHT?`
  String get what_is_your_height {
    return Intl.message(
      'WHAT IS YOUR HEIGHT?',
      name: 'what_is_your_height',
      desc: '',
      args: [],
    );
  }

  /// `Gain Weight`
  String get gain_weight {
    return Intl.message('Gain Weight', name: 'gain_weight', desc: '', args: []);
  }

  /// `Lose Weight`
  String get lose_weight {
    return Intl.message('Lose Weight', name: 'lose_weight', desc: '', args: []);
  }

  /// `Get Fitter`
  String get get_fitter {
    return Intl.message('Get Fitter', name: 'get_fitter', desc: '', args: []);
  }

  /// `Gain More Flexible`
  String get gain_more_flexible {
    return Intl.message(
      'Gain More Flexible',
      name: 'gain_more_flexible',
      desc: '',
      args: [],
    );
  }

  /// `Learn The Basics`
  String get learn_the_basics {
    return Intl.message(
      'Learn The Basics',
      name: 'learn_the_basics',
      desc: '',
      args: [],
    );
  }

  /// `WHAT IS YOUR Goal?`
  String get what_is_your_goal {
    return Intl.message(
      'WHAT IS YOUR Goal?',
      name: 'what_is_your_goal',
      desc: '',
      args: [],
    );
  }

  /// `Level 1`
  String get level1 {
    return Intl.message('Level 1', name: 'level1', desc: '', args: []);
  }

  /// `Level 2`
  String get level2 {
    return Intl.message('Level 2', name: 'level2', desc: '', args: []);
  }

  /// `Level 3`
  String get level3 {
    return Intl.message('Level 3', name: 'level3', desc: '', args: []);
  }

  /// `Level 4`
  String get level4 {
    return Intl.message('Level 4', name: 'level4', desc: '', args: []);
  }

  /// `Level 5`
  String get level5 {
    return Intl.message('Level 5', name: 'level5', desc: '', args: []);
  }

  /// `YOUR REGULAR PHYSICAL ACTIVITY LEVEL?`
  String get your_regular_physical_activity_level {
    return Intl.message(
      'YOUR REGULAR PHYSICAL ACTIVITY LEVEL?',
      name: 'your_regular_physical_activity_level',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Enter Your Email`
  String get enter_your_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get enter_your_password {
    return Intl.message(
      'Enter Your Password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Sent OTP`
  String get sent_otp {
    return Intl.message('Sent OTP', name: 'sent_otp', desc: '', args: []);
  }

  /// `OTP CODE`
  String get otp_code {
    return Intl.message('OTP CODE', name: 'otp_code', desc: '', args: []);
  }

  /// `Enter Your OTP Check Your Email`
  String get enter_your_otp_check_your_email {
    return Intl.message(
      'Enter Your OTP Check Your Email',
      name: 'enter_your_otp_check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Didnt Receive Verification Code`
  String get didnt_receive_verification_code {
    return Intl.message(
      'Didnt Receive Verification Code',
      name: 'didnt_receive_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code?`
  String get resend_code {
    return Intl.message(
      'Resend Code?',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Make Sure Its 8 Characters Or More`
  String get make_sure_its_char_or_more {
    return Intl.message(
      'Make Sure Its 8 Characters Or More',
      name: 'make_sure_its_char_or_more',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get create_new_password {
    return Intl.message(
      'Create New Password',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Kg`
  String get kg {
    return Intl.message('Kg', name: 'kg', desc: '', args: []);
  }

  /// `CM`
  String get cm {
    return Intl.message('CM', name: 'cm', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
