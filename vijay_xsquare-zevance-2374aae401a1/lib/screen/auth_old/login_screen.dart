import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../common/widget/button.dart';
import '../../common/widget/textfield.dart';
import '../../common/widget/textfield_pass.dart';
import '../../theme/color.dart';
import '../../theme/string.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  //Tabbar Controller
  late TabController _tabController;
  late String _verificationCode;
  var firebaseToken = "ssss";
  final fbPlugin = FacebookLogin(debug: true);

  //Login Form Controller
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _signupMobileOrEmailController =
      TextEditingController();
  final TextEditingController _mobileOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  int _currentIndex = 0;

  bool isPassword = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _handleTabSelection();
    });
    getFcmToken();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    buttonAnimation = Tween(
      begin: deviceWidth! - 40,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController!,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    buttonController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Image(
                image: AssetImage(Images.ic_login),
                width: 200,
                height: 230,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      //color: Colors.green,
                      gradient: const LinearGradient(
                          colors: [colors.firstColor, colors.secondColor])),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Sign in',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Sign up',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _currentIndex == 0 ? getLoginForm() : getSignupForm()
            ],
          ),
        ),
      ),
    );
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
      if (kDebugMode) {
        print(_currentIndex);
      }
    });
  }

  Widget getLoginForm() {
    return Column(
      children: [
        CTextField(
          hintText: "Email / Phone Number",
          lable: "Email / Phone Number",
          controller: _mobileOrEmailController,
        ),
        CTextFieldPass(
          hintText: "Password",
          lable: "Password",
          controller: _passwordController,
        ),
        GestureDetector(
            onTap: () {
              navigatorKey.currentState!
                  .pushNamed(RouteName.forgotPasswordScreen);
            },
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 25, top: 15),
              child: Text("Forgot Password?", style: regularGray14),
            )),
        CButton(
          title: "Login",
          btnAnim: buttonAnimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {
            _clickLogin();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Container(
              height: 1,
              color: Colors.grey[300],
            )),
            Text(" Or Continue With ", style: regularGray14),
            Expanded(
                child: Container(
              height: 1,
              color: Colors.grey[300],
            )),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _onPressedLogInButton();
              },
              child: Container(
                width: 40,
                height: 40,
                child: const Image(
                  image: AssetImage(Images.ic_facebook),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                googleLogin(context);
              },
              child: Container(
                width: 40,
                height: 40,
                child: const Image(
                  image: AssetImage(Images.ic_google),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            (Platform.isAndroid)?GestureDetector(
              onTap: () {
                signInWithApple();
              },
              child: Container(
                width: 40,
                height: 40,
                child: const Image(
                  image: AssetImage(Images.ic_apple),
                ),
              ),
            ):Container(),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget getSignupForm() {
    return Column(
      children: [
        CTextField(
          hintText: "Email / Phone Number",
          lable: "Email / Phone Number",
          readOnly: isPassword,
          controller: _signupMobileOrEmailController,
        ),
        (isPassword)
            ? CTextField(
                hintText: "Enter OTP",
                lable: "Enter Your OTP Here",
                keyboardType: TextInputType.number,
                controller: _otpController,
              )
            : Container(),
        (isPassword)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _otpController.text = "";
                    isPassword = false;
                  });
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text("Reset Email Or Number", style: regularPrimary14),
                  margin: const EdgeInsets.only(right: 25, top: 15),
                ))
            : Container(),
        const SizedBox(
          height: 10,
        ),
        CButton(
          title: (isPassword) ? "Verify OTP" : "Signup",
          btnAnim: buttonAnimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {
            (isPassword) ? _clickVerifyOtp() : _clickSignup();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  //Login Logic
  void _clickLogin() {
    var email = _mobileOrEmailController.text.toString();
    var password = _passwordController.text.toString();
    if (!loginValidation(email, password)) {
      return;
    }
    var type = "";
    if (isEmail(email)) {
      type = "email";
    } else if (isPhone(email)) {
      type = "mobile";
    }

    _loginApi(context, email, password, type);
  }

  bool loginValidation(String email, String password) {
    if (email == "") {
      ToastUtils.setSnackBar(context, "Please enter email id or mobile number");
      return false;
    } else if (!isEmail(email) && !isPhone(email)) {
      ToastUtils.setSnackBar(
          context, "Please enter valid email id or mobile number");
      return false;
    } else if (password.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter password");
      return false;
    }
    return true;
  }

  void _loginApi(
      BuildContext context, String email, String password, String type) async {
    try {
      // Log user in
      print("Login Api");
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .login(context, email, password, type, firebaseToken)
          .then((value) {
        responseLogin(value, email, type);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void _socialLoginApi(BuildContext context, String email, String token,
      String type, String platform) async {
    try {
      // Log user in
      print("Login Api");
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .socialLogin(context, email, token, type, firebaseToken, platform)
          .then((value) {
        responseSocialLogin(value, email, type);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseLogin(Users? users, String email, String type) async {
    await buttonController!.reverse();
    if (users != null && users.name!.isNotEmpty) {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
    } else if (users != null) {
      navigatorKey.currentState!.pushNamed(RouteName.createProfileScreen);
    }
  }

  void responseSocialLogin(Users? users, String email, String type) async {
    await buttonController!.reverse();
    if (users != null && users.name!.isNotEmpty) {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
    } else if (users != null) {
      navigatorKey.currentState!.pushNamed(RouteName.createProfileScreen);
    }
  }

//Signup Logic
  void _clickSignup() {
    var email = _signupMobileOrEmailController.text.toString();
    if (!signupValidation(email)) {
      return;
    }
    var type = "";
    if (isEmail(email)) {
      type = "email";
    } else if (isPhone(email)) {
      type = "mobile";
    }

    _signupApi(context, email, type);
  }

  void _clickVerifyOtp() {
    var email = _signupMobileOrEmailController.text.toString();
    var otp = _otpController.text.toString();

    var type = "";
    if (isEmail(email)) {
      type = "email";
    } else if (isPhone(email)) {
      type = "mobile";
    }
    if (type == "email") {
      _verifyOtpApi(email, type, otp);
    } else if (type == "mobile") {
      _verifyFirebaseOTP(email, otp);
    }
  }

  bool signupValidation(String email) {
    if (email == "") {
      ToastUtils.setSnackBar(context, "Please enter email id or mobile number");
      return false;
    } else if (!isEmail(email) && !isPhone(email)) {
      ToastUtils.setSnackBar(
          context, "Please enter valid email id or mobile number");
      return false;
    }
    return true;
  }

  void _signupApi(BuildContext context, String email, String type) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(context, email, type)
          .then((value) {
        responseSignup(value, email, type);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void _verifyOtpApi(String email, String type, String otp) async {
    print("=========================");
    print(email+" "+type+" "+otp);
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .verifyOtp(context, email, type, otp)
          .then((value) {
        responseVerifyOtp(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseSignup(bool value, String email, String type) async {
    await buttonController!.reverse();
    //navigatorKey.currentState!.pushNamed(RouteName.createProfileScreen);

    if (value) {
      if (type == "email") {
        setState(() {
          isPassword = true;
        });
      } else if (type == "mobile") {
        _verifyPhone(email);
      }
    }
  }

  void responseVerifyOtp(Users? value) async {
    await buttonController!.reverse();
    if (value!=null) {
      navigatorKey.currentState!.pushNamed(RouteName.createProfileScreen);
    }
  }

  void _verifyPhone(String phone) async {
    _playAnimation();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            await buttonController!.reverse();
            if (value.user != null) {
              _verifyOtpApi(phone, "mobile", "123456");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) async {
          await buttonController!.reverse();
          ToastUtils.setSnackBar(context, "Please check mobile number!");
        },
        codeSent: (String verficationID, int? resendToken) async {
          await buttonController!.reverse();
          setState(() {
            isPassword = true;
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) async {
          await buttonController!.reverse();
          setState(() {
            isPassword = true;
          });
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  void _verifyFirebaseOTP(String phone, String otp) async {
    _playAnimation();
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otp))
          .then((value) async {
        await buttonController!.reverse();
        if (value.user != null) {
          _verifyOtpApi(phone, "mobile", "123456");
        } else {
          ToastUtils.setSnackBar(context, "Invalid OTP!");
        }
      });
    } catch (e) {
      await buttonController!.reverse();
      ToastUtils.setSnackBar(context, "Invalid OTP!");
    }
  }

// Apple Login

  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print("###############");
      print(appleCredential.email);
      print("###############");
      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );
      final authResult = await auth.signInWithCredential(oauthCredential);
      String displayName = "Test";
      String fname = "Test";
      if (appleCredential.givenName != null) {
        displayName = '${appleCredential.givenName}';
      }
      if (appleCredential.familyName != null) {
        fname = '${appleCredential.familyName}';
      }
      String userEmail = "";
      if (appleCredential.email != null) {
        userEmail = '${appleCredential.email}';
      } else {
        userEmail = '${authResult.user!.email}';
      }
      final firebaseUser = authResult.user;
      print(authResult.user!.email);
      await firebaseUser?.updateProfile(displayName: displayName);
      await firebaseUser?.updateEmail(userEmail);
      _socialLoginApi(context, userEmail, authResult.credential!.providerId,
          "email", SocialType.apple);
      return firebaseUser;
    } catch (exception) {
      print(exception);
    }
    return null;
  }

//Google Signin
  Future<void> googleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      print("==================");
      // log( googleSignInAuthentication.idToken.toString());
      print("==================");
      print(googleSignInAuthentication.accessToken);
      print("==================");
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result != null) {
        var name = user!.displayName!.split(" ");
        _socialLoginApi(
            context,
            user.email!,
            googleSignInAuthentication.accessToken!,
            "email",
            SocialType.google);
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

//Fb Login

  Future<void> _onPressedLogInButton() async {
    await fbPlugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo();
  }

  Future<void> _updateLoginInfo() async {
    final plugin = fbPlugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
      _socialLoginApi(
          context, email!, token.userId, "email", SocialType.facebook);
    }
  }

  void getFcmToken() async {
    if (Platform.isAndroid) {
      firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("androidToken is " + firebaseToken);
    }else{
      firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("iosToken is " + firebaseToken);
    }
  }
}
