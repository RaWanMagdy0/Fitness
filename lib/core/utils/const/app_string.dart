class AppStrings {
  static const String passwordAppBarTitle = "Password";
  static const String loginTitle = "Login";
  static const String confirmTitle = "Confirm";
  static const String signUpTitle = "Sign up";
  static const String forgetPasswordText = 'Forget password?';
  static const String alreadyHaveAccount = 'Already have an Account?';
  static const String gender = 'Gender';
  static const String male = 'Male';
  static const String female = 'Female';
  static const String createAccount = 'Creating an account, you agree to our\t';
  static const String termsAndConditions = 'Terms&Conditions';

  static const String forgetPasswordScreenTitle = 'Forget Password';
  static const String forgetPasswordScreenDescription =
      'Please enter your email associated to\n your account';

  static const String emailVerificationScreenTitle = 'Email verification';
  static const String emailVerificationScreenDescription =
      'Please enter your code that send to your\n email address';

  static const String resetPasswordScreenTitle = 'Reset password';
  static const String resetPasswordScreenDescription =
      'Password must not be empty and must contain \n 6 characters with upper case letter and one \nnumber at least';

  static const String donotHaveAccountText = "Don't have an account?";
  static const String didnotReceiveCode = "Didn't receive code?";
  static const String resendText = "Resend";

  static const String emailHintText = 'Enter Your Email';
  static const String signupEmailHintText = 'Enter Email';
  static const String emailLabelText = 'Email';
  static const String passwordHintText = 'Enter Your Password';
  static const String signupPasswordHintText = 'Enter Password';
  static const String newPasswordLabelText = 'New password';
  static const String passwordLabelText = 'Password';
  static const String enterPassword = 'Enter password';
  static const String description = 'Description';
  static const String allPricesIncludeTax = 'All prices include tax';

  static const String rememberMeText = 'Remember me';

  static const String confirmPasswordHintText = 'Confirm Password';
  static const String confirmPasswordLabelText = 'Confirm password';

  static const String emptyEmailAddress = "Please enter your email address";
  static const String validateEmailAddress = "This email is not valid";

  static const String emptyPassword = 'Please enter your password';
  static const String emptyConfirmPassword =
      'Please enter your confirm password';

  static const String userNameHintText = "Enter your user name";
  static const String userNameLabelText = "User name";
  static const String firstNameHintText = "Enter first name";
  static const String firstNameLabelText = "First name";
  static const String lastNameHintText = "Enter last name";
  static const String lastNameLabelText = "Last name";
  static const String phoneHintText = "Enter phone number";
  static const String phoneLabelText = "Phone number";
  static const String emptyUserName = 'Please enter your user name';
  static const String emptyFirstName = 'Please enter your first name';
  static const String emptyLastName = 'Please enter your user name';
  static const String emptyPhone = 'Please enter your phone';
  static const String passwordDontMatch = "Password don't match";
  static const String addToCart = "Add to cart";
  static const String invalidCode = 'Invalid code';
  static const String continueText = "Continue";
  static const String continueAsGusetText = "Continue as Guset";

  static const String loadingText = "Loading..";
  static const String somethingWentWrong = "Somthing went wrong";
  static const String pleaseCheckInternetConnection =
      "Please check internet connection";
  static const String ok = 'Ok';

  static const String userLoggedInSuccessfully = 'User Logged In Successfully';
  static const String userCreatedSuccessfully = 'User Created Successfully';
  static const String forgetPasswordSuccessMessage =
      "Check your email please, we will send to you a verification code in 60s.";
  static const String emailVerificationSuccessMessage =
      "Now you can change your password";
  static const String resendCodeSuccessState =
      'Check your email please, Code resent successfully.';
  static const String resetPasswordSuccessMessage =
      "You now have a new password";

  static const String exploreText = "Explore";
  static const String surveyText = "Survey";
  static const String resultText = "Results";
  static const String profileText = "Profile";
  static const String status = "Status";

  static const String changeText = 'Change';
  static const String updateText = 'Update';
  static const String userProfileEditedSucceessfully =
      'User profile edited successfully';

  static const String currentPassword = 'Current password';
  static const String occasionAppBar = "Occasion";
  static const String occasionTitle = "Bloom with our exquisite best sellers";

  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
}
