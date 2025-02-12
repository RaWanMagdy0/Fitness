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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About us`
  String get aboutAs {
    return Intl.message(
      'About us',
      name: 'aboutAs',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCartText {
    return Intl.message(
      'Add To Cart',
      name: 'addToCartText',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an Account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `All prices include tax`
  String get allPricesIncludeTax {
    return Intl.message(
      'All prices include tax',
      name: 'allPricesIncludeTax',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating the profile`
  String get anErrorOccurredWhileUpdatingTheProfile {
    return Intl.message(
      'An error occurred while updating the profile',
      name: 'anErrorOccurredWhileUpdatingTheProfile',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message(
      'Best Seller',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `Best Sellers`
  String get bestSellers {
    return Intl.message(
      'Best Sellers',
      name: 'bestSellers',
      desc: '',
      args: [],
    );
  }

  /// `Bloom with our exquisite best sellers`
  String get bloomWithBestSellers {
    return Intl.message(
      'Bloom with our exquisite best sellers',
      name: 'bloomWithBestSellers',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelText {
    return Intl.message(
      'Cancel',
      name: 'cancelText',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get changeText {
    return Intl.message(
      'Change',
      name: 'changeText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordHintText {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordLabelText {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmTitle {
    return Intl.message(
      'Confirm',
      name: 'confirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuestText {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuestText',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Creating an account, you agree to our\t`
  String get createAccount {
    return Intl.message(
      'Creating an account, you agree to our\t',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Discover something now`
  String get discoverSomethingNow {
    return Intl.message(
      'Discover something now',
      name: 'discoverSomethingNow',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive code?`
  String get didnotReceiveCode {
    return Intl.message(
      'Didn\'t receive code?',
      name: 'didnotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get donotHaveAccountText {
    return Intl.message(
      'Don\'t have an account?',
      name: 'donotHaveAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get emailHintText {
    return Intl.message(
      'Enter Your Email',
      name: 'emailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabelText {
    return Intl.message(
      'Email',
      name: 'emailLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your code that send to your\n email address`
  String get emailVerificationScreenDescription {
    return Intl.message(
      'Please enter your code that send to your\n email address',
      name: 'emailVerificationScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email verification`
  String get emailVerificationScreenTitle {
    return Intl.message(
      'Email verification',
      name: 'emailVerificationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Now you can change your password`
  String get emailVerificationSuccessMessage {
    return Intl.message(
      'Now you can change your password',
      name: 'emailVerificationSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get emptyConfirmPassword {
    return Intl.message(
      'Please enter your confirm password',
      name: 'emptyConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get emptyEmailAddress {
    return Intl.message(
      'Please enter your email address',
      name: 'emptyEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name`
  String get emptyFirstName {
    return Intl.message(
      'Please enter your first name',
      name: 'emptyFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get emptyLastName {
    return Intl.message(
      'Please enter your last name',
      name: 'emptyLastName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get emptyPassword {
    return Intl.message(
      'Please enter your password',
      name: 'emptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone`
  String get emptyPhone {
    return Intl.message(
      'Please enter your phone',
      name: 'emptyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your user name`
  String get emptyUserName {
    return Intl.message(
      'Please enter your user name',
      name: 'emptyUserName',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error loading product details`
  String get errorLoadingProductDetails {
    return Intl.message(
      'Error loading product details',
      name: 'errorLoadingProductDetails',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get exploreText {
    return Intl.message(
      'Explore',
      name: 'exploreText',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Enter first name`
  String get firstNameHintText {
    return Intl.message(
      'Enter first name',
      name: 'firstNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstNameLabelText {
    return Intl.message(
      'First name',
      name: 'firstNameLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email associated to\n your account`
  String get forgetPasswordScreenDescription {
    return Intl.message(
      'Please enter your email associated to\n your account',
      name: 'forgetPasswordScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPasswordScreenTitle {
    return Intl.message(
      'Forget Password',
      name: 'forgetPasswordScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check your email please, we will send to you a verification code in 60s.`
  String get forgetPasswordSuccessMessage {
    return Intl.message(
      'Check your email please, we will send to you a verification code in 60s.',
      name: 'forgetPasswordSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPasswordText {
    return Intl.message(
      'Forget password?',
      name: 'forgetPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homebottom {
    return Intl.message(
      'Home',
      name: 'homebottom',
      desc: '',
      args: [],
    );
  }

  /// `In stock`
  String get inStock {
    return Intl.message(
      'In stock',
      name: 'inStock',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Enter last name`
  String get lastNameHintText {
    return Intl.message(
      'Enter last name',
      name: 'lastNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastNameLabelText {
    return Intl.message(
      'Last name',
      name: 'lastNameLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Loading..`
  String get loadingText {
    return Intl.message(
      'Loading..',
      name: 'loadingText',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logOut {
    return Intl.message(
      'Logout',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Confirm logout!!`
  String get logoutConfirmationMessage {
    return Intl.message(
      'Confirm logout!!',
      name: 'logoutConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `LOGOUT`
  String get logoutConfirmationTitle {
    return Intl.message(
      'LOGOUT',
      name: 'logoutConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get myOrder {
    return Intl.message(
      'My orders',
      name: 'myOrder',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordLabelText {
    return Intl.message(
      'New password',
      name: 'newPasswordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `No description available`
  String get noDescriptionAvailable {
    return Intl.message(
      'No description available',
      name: 'noDescriptionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Occasion`
  String get occasionAppBar {
    return Intl.message(
      'Occasion',
      name: 'occasionAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Bloom with our exquisite best sellers`
  String get occasionTitle {
    return Intl.message(
      'Bloom with our exquisite best sellers',
      name: 'occasionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `OTP sent to your email.\n Please check your Email`
  String get otpSentToEmail {
    return Intl.message(
      'OTP sent to your email.\n Please check your Email',
      name: 'otpSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordAppBarTitle {
    return Intl.message(
      'Password',
      name: 'passwordAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password don't match`
  String get passwordDontMatch {
    return Intl.message(
      'Password don\'t match',
      name: 'passwordDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get passwordHintText {
    return Intl.message(
      'Enter Your Password',
      name: 'passwordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabelText {
    return Intl.message(
      'Password',
      name: 'passwordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Password updated successfully',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get phoneHintText {
    return Intl.message(
      'Enter phone number',
      name: 'phoneHintText',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneLabelText {
    return Intl.message(
      'Phone number',
      name: 'phoneLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Please check internet connection`
  String get pleaseCheckInternetConnection {
    return Intl.message(
      'Please check internet connection',
      name: 'pleaseCheckInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please login\nto see your profile details`
  String get pleaseLoginToSeeProfileDetails {
    return Intl.message(
      'Please login\nto see your profile details',
      name: 'pleaseLoginToSeeProfileDetails',
      desc: '',
      args: [],
    );
  }

  /// `Product not found.`
  String get productNotFound {
    return Intl.message(
      'Product not found.',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Product Title`
  String get productTitle {
    return Intl.message(
      'Product Title',
      name: 'productTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileText {
    return Intl.message(
      'Profile',
      name: 'profileText',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while updating the profile`
  String get profileUpdateError {
    return Intl.message(
      'An error occurred while updating the profile',
      name: 'profileUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Check your email please, Code resent successfully.`
  String get resendCodeSuccessState {
    return Intl.message(
      'Check your email please, Code resent successfully.',
      name: 'resendCodeSuccessState',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resendText {
    return Intl.message(
      'Resend',
      name: 'resendText',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must not be empty and must contain \n 6 characters with upper case letter and one \nnumber at least`
  String get resetPasswordScreenDescription {
    return Intl.message(
      'Password must not be empty and must contain \n 6 characters with upper case letter and one \nnumber at least',
      name: 'resetPasswordScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPasswordScreenTitle {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `You now have a new password`
  String get resetPasswordSuccessMessage {
    return Intl.message(
      'You now have a new password',
      name: 'resetPasswordSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get resultText {
    return Intl.message(
      'Results',
      name: 'resultText',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMeText {
    return Intl.message(
      'Remember me',
      name: 'rememberMeText',
      desc: '',
      args: [],
    );
  }

  /// `Saved address`
  String get savedAddress {
    return Intl.message(
      'Saved address',
      name: 'savedAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchArabic {
    return Intl.message(
      'Search',
      name: 'searchArabic',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get signupEmailHintText {
    return Intl.message(
      'Enter Email',
      name: 'signupEmailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get signupPasswordHintText {
    return Intl.message(
      'Enter Password',
      name: 'signupPasswordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpTitle {
    return Intl.message(
      'Sign up',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInTitle {
    return Intl.message(
      'Sign in',
      name: 'signInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Status:`
  String get statusText {
    return Intl.message(
      'Status:',
      name: 'statusText',
      desc: '',
      args: [],
    );
  }

  /// `Survey`
  String get surveyText {
    return Intl.message(
      'Survey',
      name: 'surveyText',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsandConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsandConditions',
      desc: '',
      args: [],
    );
  }

  /// `Please login\nto see your cart items`
  String get pleaseLoginToSeeCartItems {
    return Intl.message(
      'Please login\nto see your cart items',
      name: 'pleaseLoginToSeeCartItems',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected state.`
  String get unexpectedState {
    return Intl.message(
      'Unexpected state.',
      name: 'unexpectedState',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateText {
    return Intl.message(
      'Update',
      name: 'updateText',
      desc: '',
      args: [],
    );
  }

  /// `User Created Successfully`
  String get userCreatedSuccessfully {
    return Intl.message(
      'User Created Successfully',
      name: 'userCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `User Logged In Successfully`
  String get userLoggedInSuccessfully {
    return Intl.message(
      'User Logged In Successfully',
      name: 'userLoggedInSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter your user name`
  String get userNameHintText {
    return Intl.message(
      'Enter your user name',
      name: 'userNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userNameLabelText {
    return Intl.message(
      'User name',
      name: 'userNameLabelText',
      desc: '',
      args: [],
    );
  }

  /// `User profile edited successfully`
  String get userProfileEditedSuccessfully {
    return Intl.message(
      'User profile edited successfully',
      name: 'userProfileEditedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `This email is not valid`
  String get validateEmailAddress {
    return Intl.message(
      'This email is not valid',
      name: 'validateEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty. Go back and add some items`
  String get yourCartIsEmptyGoBackAndAddSomeItems {
    return Intl.message(
      'Your cart is empty. Go back and add some items',
      name: 'yourCartIsEmptyGoBackAndAddSomeItems',
      desc: '',
      args: [],
    );
  }

  /// `order Number`
  String get orderNumber {
    return Intl.message(
      'order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `active`
  String get active {
    return Intl.message(
      'active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get completed {
    return Intl.message(
      'completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `No completed orders available.`
  String get noCompletedOrdersAvailable {
    return Intl.message(
      'No completed orders available.',
      name: 'noCompletedOrdersAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No orders available.`
  String get noOrdersAvailable {
    return Intl.message(
      'No orders available.',
      name: 'noOrdersAvailable',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get egp {
    return Intl.message(
      'EGP',
      name: 'egp',
      desc: '',
      args: [],
    );
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search for products`
  String get searchHint {
    return Intl.message(
      'Search for products',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Start searching for products`
  String get startSearching {
    return Intl.message(
      'Start searching for products',
      name: 'startSearching',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Location`
  String get unknownLocation {
    return Intl.message(
      'Unknown Location',
      name: 'unknownLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location Error`
  String get locationError {
    return Intl.message(
      'Location Error',
      name: 'locationError',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while searching`
  String get searchError {
    return Intl.message(
      'Error occurred while searching',
      name: 'searchError',
      desc: '',
      args: [],
    );
  }

  /// `Search for products`
  String get searchForProducts {
    return Intl.message(
      'Search for products',
      name: 'searchForProducts',
      desc: '',
      args: [],
    );
  }

  /// ` Checkout `
  String get checkout {
    return Intl.message(
      ' Checkout ',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// ` total `
  String get total {
    return Intl.message(
      ' total ',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// ` Delivery Fee `
  String get deliveryFee {
    return Intl.message(
      ' Delivery Fee ',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// ` Sub Total `
  String get subTotal {
    return Intl.message(
      ' Sub Total ',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// ` Shop local, shop safe with Flowery Online App! `
  String get shopLocalShopSafeWithFloweryOnlineApp {
    return Intl.message(
      ' Shop local, shop safe with Flowery Online App! ',
      name: 'shopLocalShopSafeWithFloweryOnlineApp',
      desc: '',
      args: [],
    );
  }

  /// ` Ahlan! Nice To Meet You `
  String get ahlanNiceToMeetYou {
    return Intl.message(
      ' Ahlan! Nice To Meet You ',
      name: 'ahlanNiceToMeetYou',
      desc: '',
      args: [],
    );
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
