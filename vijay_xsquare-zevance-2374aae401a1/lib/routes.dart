import 'package:flutter/cupertino.dart';
import 'package:grievance/screen/auth/otp_screen.dart';
import 'package:grievance/screen/auth_old/area_of_intrest_screen.dart';
import 'package:grievance/screen/auth_old/change_password_screen.dart';
import 'package:grievance/screen/auth/create_profile_screen.dart';
import 'package:grievance/screen/auth_old/forgot_password_screen.dart';
import 'package:grievance/screen/auth_old/area_of_intrest_screen.dart';
import 'package:grievance/screen/dashboard/add_grievance/add_grievance_screen.dart';
import 'package:grievance/screen/dashboard/company_list/company_list_screen.dart';
import 'package:grievance/screen/dashboard/dashboard.dart';
import 'package:grievance/screen/dashboard/feedback/feedback_screen.dart';
import 'package:grievance/screen/dashboard/grievance_details/view_proofofpurchase_screen.dart';
import 'package:grievance/screen/dashboard/grievance_details/grivance_replies_screen.dart';
import 'package:grievance/screen/dashboard/image_viewer/image_viewer_screen.dart';
import 'package:grievance/screen/dashboard/notification/notification_screen.dart';
import 'package:grievance/screen/dashboard/pdf_viewer/pdf_view_screen.dart';
import 'package:grievance/screen/dashboard/profile/anonymous/anonymous_profile_screen.dart';
import 'package:grievance/screen/dashboard/profile/followers/folllows_screen.dart';
import 'package:grievance/screen/dashboard/profile/ifeelyou/ifeelyou_screen.dart';
import 'package:grievance/screen/dashboard/profile/louder/louder_screen.dart';
import 'package:grievance/screen/dashboard/profile/profile_screen.dart';
import 'package:grievance/screen/dashboard/profile/public/public_profile_screen.dart';
import 'package:grievance/screen/dashboard/profile/ticket_managment/ticket_management_screen.dart';
import 'package:grievance/screen/dashboard/profile/zivance/zivance_screen.dart';
import 'package:grievance/screen/dashboard/search/search_screen.dart';
import 'package:grievance/screen/dashboard/share/share_screen.dart';
import 'package:grievance/screen/dashboard/thank_you/thank_you_screen.dart';

import 'screen/auth/phone_auth_screen.dart';
import 'screen/auth_old/login_screen.dart';
import 'screen/dashboard/camera/camera_screen.dart';
import 'screen/dashboard/grievance_details/grivance_details_screen.dart';
import 'screen/dashboard/grievance_details_old/grivance_details_screen.dart';
import 'screen/dashboard/grievance_details_old/grivance_proof_screen.dart';
import 'screen/dashboard/profile/comment/comments_screen.dart';
import 'screen/dashboard/profile/company/company_profile_screen.dart';
import 'screen/dashboard/profile/setting/profile_setting_screen.dart';
import 'screen/splash.dart';
import 'theme/string.dart';

Map<String, WidgetBuilder> route({RouteSettings? settings}) {
  return {
    RouteName.splashScreen: (context) => const Splash(),
    RouteName.phoneAuthScreen: (context) => const PhoneAuthScreen(),
    RouteName.otpScreen: (context) => OTPScreen(settings!.arguments),
    RouteName.loginScreen: (context) => const LoginScreen(),
    RouteName.forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    RouteName.changePasswordScreen: (context) => const ChangePasswordScreen(),
    RouteName.createProfileScreen: (context) => CreateProfileScreen(settings!.arguments),
    RouteName.dashboardScreen: (context) => const DashBoardScreen(),
    RouteName.addGrievanceScreen: (context) => AddGrievanceScreen(settings!.arguments),
    RouteName.profileScreen: (context) => ProfileScreen(settings!.arguments),
    RouteName.profileSettingScreen: (context) => ProfileSettingScreen(),
    RouteName.publicProfileScreen: (context) => PublicProfileScreen(settings!.arguments),
    RouteName.companyProfileScreen: (context) => CompanyProfileScreen(settings!.arguments),
    RouteName.notificationScreen: (context) => const NotificationScreen(),
    RouteName.ticketManagementScreen: (context) => TicketManagementScreen(settings!.arguments),
    RouteName.zivanceScreen: (context) => ZivanceScreen(settings!.arguments),
    RouteName.thankyouScreen: (context) => ThankyouScreen(settings!.arguments),
    RouteName.areaInterestScreen: (context) => const AreaInterestScreen(),
    RouteName.searchGrievanceScreen: (context) => const SearchScreen(),
    RouteName.followersScreen: (context) => FollowersScreen(settings!.arguments),
    RouteName.grievanceDetailsScreen: (context) => GrievanceDetailsScreen(settings!.arguments),
    RouteName.commentScreen: (context) => CommentScreen(settings!.arguments),
    RouteName.companiesScreen: (context) => const CompaniesScreen(),
    RouteName.cameraScreen: (context) => CameraScreen(settings!.arguments),
    RouteName.pdfViewerScreen: (context) => PdfViewerScreen(settings!.arguments),
    RouteName.imageViewerScreen: (context) => ImageViewerScreen(settings!.arguments),
    RouteName.grievanceRepliesScreen: (context) => GrievanceRepliesScreen(settings!.arguments),
    RouteName.grievanceProofScreen: (context) => GrievanceProofScreen(settings!.arguments),
    RouteName.feedBackScreen: (context) => FeedBackScreen(settings!.arguments),
    RouteName.shareScreen: (context) => ShareScreen(settings!.arguments),
    RouteName.ifeelyouScreen: (context) => IFeelYouScreen(settings!.arguments),
    RouteName.louderScreen: (context) => LouderScreen(settings!.arguments),
    RouteName.viewProofOfPurchaseScreen: (context) => ViewProofOfPurchaseScreen(settings!.arguments),
    RouteName.anonymousProfileScreen: (context) => const AnonymousProfileScreen(),
  };
}
