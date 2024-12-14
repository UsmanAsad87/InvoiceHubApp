import 'package:invoice_producer/features/auth/view/create_auth_company_screen.dart';
import 'package:invoice_producer/features/auth/view/forget_screen.dart';
import 'package:invoice_producer/features/auth/view/phone_verification_screen.dart';
import 'package:invoice_producer/features/auth/view/reset_pass_screen.dart';
import 'package:invoice_producer/features/auth/view/signin_screen.dart';
import 'package:invoice_producer/features/auth/view/signup_screen.dart';
import 'package:invoice_producer/features/auth/view/verify_otp_screen.dart';
import 'package:invoice_producer/features/splash/views/introduction_screen.dart';
import 'package:invoice_producer/features/splash/views/splash_screen.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/mail/views/create_mail_screen.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/mail/views/mails_screen.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/views/conversation_screen.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/views/send_support_message_screen.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/views/supports_screen.dart';
import 'package:invoice_producer/features/user/dashboard/views/dashboard_screen.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/add_work/views/add_work_screen.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/views/select_template.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/signature/views/create_signature_screen.dart';
import 'package:invoice_producer/features/user/invoice/views/congrats_screen.dart';
import 'package:invoice_producer/features/user/invoice/views/createInvoiceScreen.dart';
import 'package:invoice_producer/features/user/invoice/views/scan_qrcode_screen.dart';
import 'package:invoice_producer/features/user/main_menu/views/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/My_Subscription/views/my_subscrption.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/app_setting/views/app_setting_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/edit_profile/views/edit_profile_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/help/views/faqs.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/help/views/helps_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/views/payment_setting_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/tax_setting/views/create_tax_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/tax_setting/views/tax_settings.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/term_and_condition/views/term_and_condition_screen.dart';
import 'package:invoice_producer/features/user/profile/views/profile_screen.dart';
import '../features/auth/view/add_payment_account_screen.dart';
import '../features/user/dashboard/dashboard_extended/company/views/companies_screen.dart';
import '../features/user/dashboard/dashboard_extended/company/views/create_company_screen.dart';
import '../features/user/dashboard/dashboard_extended/customers/customer_extended/customer_detail/views/customer_detail_screen.dart';
import '../features/user/dashboard/dashboard_extended/customers/views/create_customer_screen.dart';
import '../features/user/dashboard/dashboard_extended/customers/views/customers_screen.dart';
import '../features/user/dashboard/dashboard_extended/notification/views/notification_screen.dart';
import '../features/user/dashboard/views/frequent_clients_see_more_screen.dart';
import '../features/user/dashboard/views/recent_invoices_see_more_screen.dart';
import '../features/user/invoice/invoiceExended/add_item/views/add_item_screen.dart';
import '../features/user/invoice/invoiceExended/add_item/views/items_screen.dart';
import '../features/user/invoice/invoiceExended/bill_to/bill_to_screen.dart';
import '../features/user/invoice/invoiceExended/invoice_info/views/invoice_info_screen.dart';
import '../features/user/invoice/invoiceExended/payment_method/views/payment_method_screen.dart';
import '../features/user/invoice/invoiceExended/select_addess/views/select_address_screen.dart';
import '../features/user/invoice/invoiceExended/signature/views/signatures_screen.dart';
import '../features/user/invoice/views/search_invoices_screen.dart';
import '../features/user/invoice/views/singleInvoiceScreen.dart';
import '../features/user/invoice/views/single_draft_invoice_screen.dart';
import '../features/user/products/views/create_product_screen.dart';
import '../features/user/stripe/views/stripe_o_auth.dart';
import 'navigation.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String introductionScreen = '/introductionScreen';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String phoneVerificationScreen = '/phoneVerificationScreen';
  static const String verifyOtpScreen = '/verifyOtpScreen';
  static const String createAuthCompanyScreen = '/createAuthCompanyScreen';
  static const String addPaymentAccountScreen = '/addPaymentAccountScreen';

  static const String mainMenuScreen = '/mainMenuScreen';

  static const String dashboardScreen = '/dashboardScreen';
  static const String searchInvoiceScreen = '/searchInvoiceScreen';
  static const String notificationScreen = '/NotificationScreen';
  static const String customersScreen = '/customersScreen';
  static const String createCustomerScreen = '/createCustomerScreen';
  static const String customerDetailScreen = '/customerDetailScreen';
  static const String companiesScreen = '/CompaniesScreen';
  static const String createCompanyScreen = '/createCompanyScreen';

  static const String createProductScreen = '/createProductScreen';

  // invoice routes

  static const String createInvoiceScreen = '/createInvoiceScreen';
  static const String billToScreen = '/BillToScreen';
  static const String invoiceInfoScreen = '/invoiceInfoScreen';
  static const String selectAddressScreen = '/selectAddressScreen';
  static const String itemsScreen = '/itemsScreen';
  static const String addItemScreen = '/addItemScreen';
  static const String signaturesScreen = '/signatureScreen';
  static const String createSignatureScreen = '/createSignatureScreen';
  static const String paymentMethodScreen = '/paymentMethodScreen';
  static const String selectTemplateScreen = '/selectTemplateScreen';
  static const String addWorkSamples = '/addWorkSample';
  static const String congratsScreen = '/congratsScreen';
  static const String scanQrcodeScreen = '/scanQrcodeScreen';

  // profile part
  static const String profileScreen = '/profileScreen';
  static const String appSettingScreen = '/appSettingScreen ';
  static const String termAndConditionScreen = '/termAndConditionScreen';
  static const String editProfileScreen = '/EditProfileScreen';
  static const String taxSettings = '/taxSettings';
  static const String createTaxScreen = '/createTaxScreen';
  static const String helpScreen = '/helpScreen';
  static const String faqsScreen = '/faqsScreen';
  static const String mySubscription = '/mySubscription';

  static const String paymentSettingScreen = '/paymentSettingScreen';

  static const String mailsScreen = '/mailsScreen';
  static const String createMailScreen = '/createMailScreen';
  static const String supportScreen = '/supportScreen';
  static const String sendSupportMessageScreen = '/sendSupportMessageScreen';
  static const String conversationScreen = '/conversationScreen';
  static const String singleInvoiceScreen = '/singleInvoiceScreen';
  static const String singDraftleInvoiceScreen = '/singDraftleInvoiceScreen';


  static const String oAuthPage = '/OAuthPage';
  static const String frequentClientsSeeMoreScreen = '/frequentClientsSeeMoreScreen';
  static const String recentInvoicesSeeMoreScreen = '/recentInvoicesSeeMoreScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _buildRoute(const SplashScreen());
      case introductionScreen:
        return _buildRoute(const IntroductionScreen());
      case signInScreen:
        return _buildRoute(const SignInScreen());
      case signUpScreen:
        return _buildRoute(const SignUpScreen());
      case forgetPasswordScreen:
        return _buildRoute(const ForgotPasswordScreen());
      case resetPasswordScreen:
        return _buildRoute(const ResetPasswordScreen());
      case phoneVerificationScreen:
        return _buildRoute(const PhoneVerificationScreen());
      case verifyOtpScreen:
        return _buildRoute(const VerifyOtpScreen());
      case mainMenuScreen:
        return _buildRoute(const MainMenuScreen());
      case createAuthCompanyScreen:
        return _buildRoute(const CreateAuthCompanyScreen());
      case addPaymentAccountScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(AddPaymentAccountScreen(
            skip: arguments?['skip'],
            paymentAccount: arguments?['paymentAccount']));
      case dashboardScreen:
        return _buildRoute(const DashboardScreen());
        case searchInvoiceScreen:
        return _buildRoute(const SearchInvoicesScreen());
      case profileScreen:
        return _buildRoute(const ProfileScreen());
      case createProductScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(CreateProductScreen(product: arguments?['product']));
      case appSettingScreen:
        return _buildRoute(const AppSettingScreen());
      case termAndConditionScreen:
        return _buildRoute(const TermAndConditionScreen());
      case notificationScreen:
        return _buildRoute(const NotificationScreen());
      case editProfileScreen:
        return _buildRoute(const EditProfileScreen());
      case customersScreen:
        return _buildRoute(const CustomersScreen());
      case createCustomerScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(CreateCustomerScreen(
          customer: arguments?['customer'],
        ));
      case companiesScreen:
        return _buildRoute(const CompaniesScreen());
      case createCompanyScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(CreateCompanyScreen(
          company: arguments?['company'],
          isSkip:  arguments?['isSkip'],
        ));
      case paymentSettingScreen:
        return _buildRoute(const PaymentSettingScreen());
      case mailsScreen:
        return _buildRoute(const MailsScreen());
      case createMailScreen:
        return _buildRoute(const CreateMailScreen());
      case supportScreen:
        return _buildRoute(const SupportScreen());
      case sendSupportMessageScreen:
        return _buildRoute(const SendSupportMessageScreen());
      case conversationScreen:
        return _buildRoute(const ConversationScreen());
      case createInvoiceScreen:
        return _buildRoute(const CreateInVoiceScreen());
      case billToScreen:
        return _buildRoute(const BillToScreen());
      case invoiceInfoScreen:
        return _buildRoute(const InvoiceInformationScreen());
        case selectAddressScreen:
        return _buildRoute(const SelectAddressScreen());
      case itemsScreen:
        return _buildRoute(const ItemsScreen());
      case addItemScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute( AddItemScreen(
          product: arguments?['product'],
          isUpdate: arguments?['isUpdate'],
        ));
      case signaturesScreen:
        return _buildRoute(const SignatureScreen());
      case createSignatureScreen:
        return _buildRoute(const CreateSignatureScreen());
      case paymentMethodScreen:
        return _buildRoute(const PaymentMethodScreen());
      case customerDetailScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(CustomerDetailScreen(
          customer: arguments?['customer'],
        ));
      case taxSettings:
        return _buildRoute(const TaxSettings());
      case createTaxScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(CreateTaxScreen(tax: arguments?['tax']));
      case helpScreen:
        return _buildRoute(const HelpScreen());
      case faqsScreen:
        return _buildRoute(const FAQsScreen());
      case selectTemplateScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(SelectTemplate(invoice:  arguments?['invoice']));
      case congratsScreen:
        return _buildRoute(const CongratsScreen());
      case scanQrcodeScreen:
        return _buildRoute(const ScanQrcodeScreen());
      case mySubscription:
        return _buildRoute(const MySubscription());
      case addWorkSamples:
        return _buildRoute(const AddWorkScreen());
      case singleInvoiceScreen:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(SingleInvoiceScreen(invoice:  arguments?['invoice']));
      case singDraftleInvoiceScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(SingDraftleInvoiceScreen(invoice:  arguments['invoice']));
      case oAuthPage:
        return _buildRoute( OAuthPage());

      case frequentClientsSeeMoreScreen:
        return _buildRoute( const FrequentClientsSeeMoreScreen());
      case recentInvoicesSeeMoreScreen:
        return _buildRoute( const RecentInvoicesSeeMoreScreen());
      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }

  static _buildRoute(Widget widget, {int? duration = 400}) {
    return forwardRoute(widget, duration);
  }
}
