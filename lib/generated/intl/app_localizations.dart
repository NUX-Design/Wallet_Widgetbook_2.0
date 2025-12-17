import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
    Locale('ru'),
    Locale('th'),
    Locale('zh'),
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get headerDeposit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get labelDepositAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'You need to deposit at least {amount} {currency}.'**
  String infomationDeposit(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount}'**
  String depositTextButtonAmount(Object amount);

  ///
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get titleDepositFrom;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Banking'**
  String get labelDepositMobileBanking;

  ///
  ///
  /// In en, this message translates to:
  /// **'Siam Commercial Bank'**
  String get valueDepositSCB;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bangkok Bank Mobile Banking'**
  String get valueDepositBbl;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bank of Ayudhya'**
  String get valueDepositBay;

  ///
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get titleDepositTo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Wi Wallet'**
  String get labelDepositWiWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total Balance:'**
  String get labelDepositTotalBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get textButtonDepositConfirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get titleDrawerMobileNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get placeholderDrawerSearch;

  ///
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get labelHomeTotalBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get textButtonHomeManage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get titleHomeCards;

  ///
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get titleHomeServices;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get shortcutMenuHomeTransfer;

  ///
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get shortcutMenuHomeMore;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get shortcutMenuHomeBill;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wi Coin'**
  String get shortcutMenuHomeWiCoin;

  ///
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get titleHomeHighlight;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigatorHome;

  ///
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get navigatorHomeDeposit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get navigatorHomeConvert;

  ///
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navigatorHomeSetting;

  ///
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get labelHomeViewAll;

  ///
  ///
  /// In en, this message translates to:
  /// **'You have received {amount} {currency}. Please verify face to receive this amount which will incur fee in your wallet.'**
  String homeAnnounceVerifyFaceToReceive(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Deposit Channel'**
  String get titleDrawerDepositChannel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Banking'**
  String get labelDrawerMobileBanking;

  ///
  ///
  /// In en, this message translates to:
  /// **'Siam Commercial Bank'**
  String get valueDrawerScb;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bangkok Bank Mobile Banking'**
  String get valueDrawerBbl;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bank of Ayudhya'**
  String get valueDrawerBay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kasikorn Bank'**
  String get valueDrawerKbank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get titleDepositEnterMobileNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter the mobile number registered in Kasikorn\nBank account for deposit.'**
  String get descriptionDepositEnterMobileNumberKbank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get placeholderDepositMobileNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get titleModalError;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, system has encountered error. Please try again.'**
  String get descriptionModalErrorSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get textButtonModalOk;

  ///
  ///
  /// In en, this message translates to:
  /// **'Waiting for Payment'**
  String get titleDepositKplusWaitingForPayment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please wait for notification to open\nK PLUS application. If you do not receive the\nnotification, you can check Inbox on your\nK PLUS.'**
  String get descriptionDepositKplusNotification;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please complete the process\nwithin {time} minutes.'**
  String infomationDepositKplusTimeLimit(Object time);

  ///
  ///
  /// In en, this message translates to:
  /// **'Kasikorn Bank'**
  String get valueDepositKplus;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get labelDepositKplusTransactionType;

  ///
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get labelDepositKplus;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get labelDepositKplusMobileNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transaction No.'**
  String get labelDepositKplusTransactionNo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get labelDepositKplusDateTime;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open in KPLUS'**
  String get textButtonDepositKplusOpen;

  ///
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get fieldValueDepositKplus;

  ///
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get titleDrawerEmptyNoResultsFound;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get descriptionDrawerEmptyTryAgain;

  ///
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get inboxTabMenuGeneral;

  ///
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get inboxTabMenuForYou;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get inboxDetailHeaderTitleReceive;

  ///
  ///
  /// In en, this message translates to:
  /// **'Verify Face'**
  String get inboxTextButtonVerifyFace;

  ///
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identityVerificationHeaderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Take photos of face again.'**
  String get identityVerificationTitleTakePhoto;

  ///
  ///
  /// In en, this message translates to:
  /// **'You cannot make it in time. Please follow the instruction and take new photos.'**
  String get identityVerificationDesTakePhotoCannotMakeInTime;

  ///
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get identityVerificationTextButtonRetake;

  ///
  ///
  /// In en, this message translates to:
  /// **'The system has detected an irregularity.\nEnsure your face is within the frame and no one else is near the camera.'**
  String get identityVerificationDesTakePhotoTheSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Face verification unsuccessful'**
  String get identityVerificationTitleFaceUnsuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your face verification has failed due to a mismatch with the document photo.\nFor more information, please contact customer service available 24 hours daily.'**
  String get identityVerificationDesFaceUnsuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get identityVerificationTextButtonContact;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your account has been credited successfully!'**
  String get homeAlertInfoVerifyAccountToReceiveSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, this transaction cannot be made.'**
  String get homeAlertInfoVerifyAccountToReceiveFail;

  ///
  ///
  /// In en, this message translates to:
  /// **'Face Verification'**
  String get identityVerificationTitleFaceVerification;

  ///
  ///
  /// In en, this message translates to:
  /// **'Prepare for your face liveness capture.\nFollow instructions below.'**
  String get identityVerificationDesFaceVerifacation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Do not wear hats, glasses, masks or headphones.'**
  String get identityVerificationDesFaceVerifacationOneStep;

  ///
  ///
  /// In en, this message translates to:
  /// **'Make sure that your background is not too bright or too dark and avoid backlighting.'**
  String get identityVerificationDesFaceVerifacationTwoStep;

  ///
  ///
  /// In en, this message translates to:
  /// **'Keep the face within the frame.'**
  String get identityVerificationDesFaceVerifacationThreeStep;

  ///
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get identityVerificationTextButtonOpenCamera;

  ///
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get transactionDetailHeaderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receipt saved successfully'**
  String get transactionDetailAlertInfoSavedSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, system has encountered error. Please try again.'**
  String get transactionDetailAlertInfoErrorSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get transactionDetailHeaderTitleTypeReceive;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transactionDetailHeaderTitleTypeTransfer;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String transactionDetailTotalAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Fee {amount} {currency}'**
  String transactionDetailFeeAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get transactionDetailTextLabelFrom;

  ///
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get transactionDetailTextLabelTo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date&Time:'**
  String get transactionDetailTextLabelStampDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionDetailTextLabelTransId;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please verify the information and keep the slip for evidence.'**
  String get transactionDetailDesRecheckInfo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Customer service contact 02-026-6679 operates 24 hours daily.'**
  String get transactionDetailDesCustomerContact;

  ///
  ///
  /// In en, this message translates to:
  /// **'Scan to Verify'**
  String get transactionDetailTextInfoScanVerify;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save Receipt'**
  String get transactionDetailTextButtonSaveReceipt;

  ///
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get transactionDetailTextButtonGoHome;

  ///
  ///
  /// In en, this message translates to:
  /// **'Powered by WiPay'**
  String get transactionDetailTextCredit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get transactionDetailHeaderTotal;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String transactionDetailHeaderAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Fee {amount} {currency}'**
  String transactionDetailHeaderFeeAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionDetailTextLabelType;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hold Amount'**
  String get transactionDetailTextValueHoldAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Payment Channel'**
  String get transactionDetailTextLabelPaymentChannel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wi Wallet'**
  String get transactionDetailTextValueWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date&Time'**
  String get transactionDetailTextLabelDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'{date} {time}'**
  String transactionDetailTextValueDate(Object date, Object time);

  ///
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get settingMainMenuHistory;

  ///
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settingHeaderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Fingerprint / Face Recognition'**
  String get settingMainMenuFingerprint;

  ///
  ///
  /// In en, this message translates to:
  /// **'OTP Channel'**
  String get settingMainMenuOtp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get settingMainMenuChangePin;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingMainMenuSelectLang;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lock Transactions'**
  String get settingMainMenuLockTrans;

  ///
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingMainMenuTerms;

  ///
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get settingMainMenuContact;

  ///
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingMainMenuLogout;

  ///
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingValueMainMenuFingerprintOn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingValueMainMenuFingerprintOff;

  ///
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get settingValueMainMenuOtpSms;

  ///
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get settingValueMainMenuOtpEmail;

  ///
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingValueMainMenuSelectLangEn;

  ///
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingValueMainMenuLockTransOn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingValueMainMenuLockTransOff;

  ///
  ///
  /// In en, this message translates to:
  /// **'Appearances'**
  String get settingMainMenuAppearances;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingValueMainMenuAppearDark;

  ///
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingValueMainMenuAppearLight;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wi Wallet'**
  String get settingTextVerAppWiWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyHeaderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get identityVerificationTitleError;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, system has encountered error.please contact customer service available 24 hours daily.'**
  String get identityVerificationDesErrorSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Comparing face...'**
  String get identityVerificationTitleCompareFace;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please wait for a moment.'**
  String get identityVerificationDesCompareFace;

  ///
  ///
  /// In en, this message translates to:
  /// **'Keep looking straight.'**
  String get identityVerificationTitleKeepLookingStraight;

  ///
  ///
  /// In en, this message translates to:
  /// **'Turn left and hold.'**
  String get identityVerificationTitleTurnLeft;

  ///
  ///
  /// In en, this message translates to:
  /// **'Turn Right and hold.'**
  String get identityVerificationTitleTurnRight;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get historyDrawerSelectMonth;

  ///
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transferHeaderTitleTransfer;

  ///
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transferInputLabelAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'You need to transfer at least {amount} {currency}.'**
  String transferInputInfoMinimumTransfer(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get transferInputLabelFrom;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Wi Wallet'**
  String get transferCardFromTitleYourWiWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total Balance:'**
  String get transferCardFromValueTotalBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'฿ {amount}'**
  String transferCardFromValueAmount(Object amount);

  ///
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get transferCardLabelTo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Account Type'**
  String get transferCardToValueSelectAccType;

  ///
  ///
  /// In en, this message translates to:
  /// **'Objective'**
  String get transferInputLabelObjective;

  ///
  ///
  /// In en, this message translates to:
  /// **'(optional)'**
  String get transferInputLabelNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Objective of Transfer'**
  String get transferInputPlaceholderEnterNote;

  ///
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get transferTextButtonReview;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Account Type'**
  String get transferDrawerHeaderTitleSelectAccType;

  ///
  ///
  /// In en, this message translates to:
  /// **'Other Wi Wallets'**
  String get transferDrawerLabelOtherWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wi Wallet'**
  String get transferDrawerSelectValueWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'PromptPay Thai'**
  String get transferDrawerLabelPromptPayThai;

  ///
  ///
  /// In en, this message translates to:
  /// **'PromptPay'**
  String get transferDrawerSelectValuePromptPay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Banking'**
  String get transferDrawerLabelMobileBank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Siam Commercial Bank'**
  String get transferDrawerSelectValueSiamBank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bangkok Bank Mobile Banking'**
  String get transferDrawerSelectValueBangkokBank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bank of Ayudhya'**
  String get transferDrawerSelectValueBankAyudhya;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kasikorn Bank'**
  String get transferDrawerSelectValueKasikornBank;

  ///
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get transferInputLabelAccountNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter account number'**
  String get transferInputPlaceholderEnterAccount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get transferDrawerHeaderTitleReview;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please recheck information before proceeding'**
  String get transferDrawerWarningTitleRecheckInfo;

  ///
  ///
  /// In en, this message translates to:
  /// **'To prevent wrong account transfers or fraudulent activities. It cannot be changed once confirmed.'**
  String get transferDrawerWarningInfoPreventFraud;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get transferDrawerDetailTotal;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String transferDrawerDetailAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Fee {amount} {currency}'**
  String transferDrawerDetailFeeAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get transferDrawerDetailFrom;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your Wi Wallet'**
  String get transferDrawerDetailValueYourWallet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get transferDrawerDetailMobileNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get transferDrawerDetailTo;

  ///
  ///
  /// In en, this message translates to:
  /// **'{bank}'**
  String transferDrawerDetailToValue(Object bank);

  ///
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get transferDrawerDetailAccountName;

  ///
  ///
  /// In en, this message translates to:
  /// **'{accountname}'**
  String transferDrawerDetailAccountNameValue(Object accountname);

  ///
  ///
  /// In en, this message translates to:
  /// **'{mobilenumber}'**
  String transferDrawerDetailMobileNumberValue(Object mobilenumber);

  ///
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get transferDrawerDetailAccountNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'{accountnumber}'**
  String transferDrawerDetailAccountNumberValue(Object accountnumber);

  ///
  ///
  /// In en, this message translates to:
  /// **'Objective'**
  String get transferDrawerLabelObject;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get transferDrawerTextButtonConfirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Insufficient Balance'**
  String get transferModalTitleInsufficientBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'You don’t have enough balance on Wi Wallet. Please deposit the balance.'**
  String get transferModalDesDepositBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get transferModalTextButtonCancel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get transferModalTextButtonConfirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get transferModalTitleErrorAccountNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, the system has encountered an error. The destination account number is incorrect. Please contact customer service, available 24 hours daily.'**
  String get transferModalDescriptionErrorIncorrectAccount;

  ///
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get transferModalTextButtonOk;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get transferModalTitleErrorSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, system has encountered error. Please try again.'**
  String get transferModalDescriptionSystemErrorTry;

  ///
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanHeaderTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hold the camera to scan a QR code.'**
  String get scanInfoHoldCamera;

  ///
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get scanButtonLeftFlash;

  ///
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get scanButtonRightPhoto;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get homeModalTitlePinIncorrectError;

  ///
  ///
  /// In en, this message translates to:
  /// **'The system encountered an error because you entered the PIN incorrectly too many times. Please contact customer service available 24 hours daily.'**
  String get homeModalDesPinIncorrectError;

  ///
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get homeModalTextButtonContact;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sorry, system has encountered error. Please try again.'**
  String get homeAlertInfoErrorSystem;

  ///
  ///
  /// In en, this message translates to:
  /// **'Balance Detail'**
  String get homeDrawerHeaderTitleBalanceDetail;

  ///
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get homeDrawerDetailTotalBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String homeDrawerDetailAmountTotalBalanceThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Hold Amount*'**
  String get homeDrawerDetailHoldAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String homeDrawerDetailHoldAmountThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'Ledger Balance'**
  String get homeDrawerDetailLedgerBalance;

  ///
  ///
  /// In en, this message translates to:
  /// **'{amount} {currency}'**
  String homeDrawerDetailLedgerBalanceThb(Object amount, Object currency);

  ///
  ///
  /// In en, this message translates to:
  /// **'*Hold Amount means they aren\'t immediately available for use. Please contact our customer support team for more details and to process the next steps.'**
  String get homeDrawerWarningInfoHoldAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get homeDrawerTextButtonBalanceDetailOk;

  ///
  ///
  /// In en, this message translates to:
  /// **'Reserve Hold Amount'**
  String get historyCardListItemTitleReserveAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hold Amount'**
  String get historyCardListItemTitleHoldAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  ///
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Secondary Button'**
  String get secondaryButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'Review Transaction'**
  String get cardReviewPreviewTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my', 'ru', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
