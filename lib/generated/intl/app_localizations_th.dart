// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get headerDeposit => 'ฝากเงิน';

  @override
  String get labelDepositAmount => 'จำนวนเงิน';

  @override
  String infomationDeposit(Object amount, Object currency) {
    return 'ท่านต้องฝากเงินอย่างน้อย $amount $currency';
  }

  @override
  String depositTextButtonAmount(Object amount) {
    return '$amount';
  }

  @override
  String get titleDepositFrom => 'จาก';

  @override
  String get labelDepositMobileBanking => 'Mobile Banking';

  @override
  String get valueDepositSCB => 'Siam Commercial Bank';

  @override
  String get valueDepositBbl => 'Bangkok Bank Mobile Banking';

  @override
  String get valueDepositBay => 'Bank of Ayudhya';

  @override
  String get titleDepositTo => 'ถึง';

  @override
  String get labelDepositWiWallet => 'Wi Wallet ของท่าน';

  @override
  String get labelDepositTotalBalance => 'ยอดเงินรวม:';

  @override
  String get textButtonDepositConfirm => 'ยืนยัน';

  @override
  String get titleDrawerMobileNumber => 'เบอร์มือถือ';

  @override
  String get placeholderDrawerSearch => 'ค้นหา';

  @override
  String get labelHomeTotalBalance => 'ยอดเงินรวม';

  @override
  String get textButtonHomeManage => 'จัดการ';

  @override
  String get titleHomeCards => 'บัตร';

  @override
  String get titleHomeServices => 'บริการ';

  @override
  String get shortcutMenuHomeTransfer => 'โอนเงิน';

  @override
  String get shortcutMenuHomeMore => 'เพิ่มเติม';

  @override
  String get shortcutMenuHomeBill => 'บิล';

  @override
  String get shortcutMenuHomeWiCoin => 'Wi Coin';

  @override
  String get titleHomeHighlight => 'Highlight';

  @override
  String get navigatorHome => 'หน้าหลัก';

  @override
  String get navigatorHomeDeposit => 'ฝากเงิน';

  @override
  String get navigatorHomeConvert => 'แปลงเงิน';

  @override
  String get navigatorHomeSetting => 'ตั้งค่า';

  @override
  String get labelHomeViewAll => 'ดูทั้งหมด';

  @override
  String homeAnnounceVerifyFaceToReceive(Object amount, Object currency) {
    return 'You have received $amount $currency. Please verify face to receive this amount which will incur fee in your wallet.';
  }

  @override
  String get titleDrawerDepositChannel => 'ช่องทางฝากเงิน';

  @override
  String get labelDrawerMobileBanking => 'Mobile Banking';

  @override
  String get valueDrawerScb => 'Siam Commercial Bank';

  @override
  String get valueDrawerBbl => 'Bangkok Bank Mobile Banking';

  @override
  String get valueDrawerBay => 'Bank of Ayudhya';

  @override
  String get valueDrawerKbank => 'Kasikorn Bank';

  @override
  String get titleDepositEnterMobileNumber => 'กรอกเบอร์มือถือ';

  @override
  String get descriptionDepositEnterMobileNumberKbank =>
      'ใส่หมายเลขโทรศัพท์มือถือที่ลงทะเบียนในบัญชีธนาคารกสิกรไทยสำหรับการฝากเงิน';

  @override
  String get placeholderDepositMobileNumber => 'เบอร์มือถือ';

  @override
  String get titleModalError => 'ข้อผิดพลาด';

  @override
  String get descriptionModalErrorSystem =>
      'ขออภัย ระบบพบข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';

  @override
  String get textButtonModalOk => 'ตกลง';

  @override
  String get titleDepositKplusWaitingForPayment => 'รอการชำระเงิน';

  @override
  String get descriptionDepositKplusNotification =>
      'กรุณารอการแจ้งเตือนเพื่อเปิดแอปพลิเคชัน K PLUS หากท่านไม่ได้รับการแจ้งเตือน ท่านสามารถตรวจสอบกล่องข้อความใน K PLUS ของท่านได้';

  @override
  String infomationDepositKplusTimeLimit(Object time) {
    return 'กรุณาดำเนินการให้เสร็จสิ้นภายในเวลา $time นาที';
  }

  @override
  String get valueDepositKplus => 'Kasikorn Bank';

  @override
  String get labelDepositKplusTransactionType => 'ประเภทธุรกรรม';

  @override
  String get labelDepositKplus => 'ฝากเงิน';

  @override
  String get labelDepositKplusMobileNumber => 'เบอร์มือถือ';

  @override
  String get labelDepositKplusTransactionNo => 'เลขที่รายการ';

  @override
  String get labelDepositKplusDateTime => 'วันที่และเวลา';

  @override
  String get textButtonDepositKplusOpen => 'เปิด KPLUS';

  @override
  String get fieldValueDepositKplus => 'ฝากเงิน';

  @override
  String get titleDrawerEmptyNoResultsFound => 'ไม่พบผลการค้นหา';

  @override
  String get descriptionDrawerEmptyTryAgain => 'กรุณาลองใหม่อีกครั้ง';

  @override
  String get inboxTabMenuGeneral => 'General';

  @override
  String get inboxTabMenuForYou => 'For You';

  @override
  String get inboxDetailHeaderTitleReceive => 'Receive';

  @override
  String get inboxTextButtonVerifyFace => 'Verify Face';

  @override
  String get identityVerificationHeaderTitle => 'Identity Verification';

  @override
  String get identityVerificationTitleTakePhoto => 'Take photos of face again.';

  @override
  String get identityVerificationDesTakePhotoCannotMakeInTime =>
      'You cannot make it in time. Please follow the instruction and take new photos.';

  @override
  String get identityVerificationTextButtonRetake => 'Retake';

  @override
  String get identityVerificationDesTakePhotoTheSystem =>
      'The system has detected an irregularity.\nEnsure your face is within the frame and no one else is near the camera.';

  @override
  String get identityVerificationTitleFaceUnsuccess =>
      'Face verification unsuccessful';

  @override
  String get identityVerificationDesFaceUnsuccess =>
      'Your face verification has failed due to a mismatch with the document photo.\nFor more information, please contact customer service available 24 hours daily.';

  @override
  String get identityVerificationTextButtonContact => 'Contact Us';

  @override
  String get homeAlertInfoVerifyAccountToReceiveSuccess =>
      'เงินเข้าบัญชีของท่านเรียบร้อยแล้ว!';

  @override
  String get homeAlertInfoVerifyAccountToReceiveFail =>
      'Sorry, this transaction cannot be made.';

  @override
  String get identityVerificationTitleFaceVerification => 'Face Verification';

  @override
  String get identityVerificationDesFaceVerifacation =>
      'Prepare for your face liveness capture.\nFollow instructions below.';

  @override
  String get identityVerificationDesFaceVerifacationOneStep =>
      'Do not wear hats, glasses, masks or headphones.';

  @override
  String get identityVerificationDesFaceVerifacationTwoStep =>
      'Make sure that your background is not too bright or too dark and avoid backlighting.';

  @override
  String get identityVerificationDesFaceVerifacationThreeStep =>
      'Keep the face within the frame.';

  @override
  String get identityVerificationTextButtonOpenCamera => 'Open Camera';

  @override
  String get transactionDetailHeaderTitle => 'Detail';

  @override
  String get transactionDetailAlertInfoSavedSuccess =>
      'Receipt saved successfully';

  @override
  String get transactionDetailAlertInfoErrorSystem =>
      'Sorry, system has encountered error. Please try again.';

  @override
  String get transactionDetailHeaderTitleTypeReceive => 'Receive';

  @override
  String get transactionDetailHeaderTitleTypeTransfer => 'Transfer';

  @override
  String transactionDetailTotalAmountThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String transactionDetailFeeAmountThb(Object amount, Object currency) {
    return 'Fee $amount $currency';
  }

  @override
  String get transactionDetailTextLabelFrom => 'From';

  @override
  String get transactionDetailTextLabelTo => 'To';

  @override
  String get transactionDetailTextLabelStampDate => 'Date&Time:';

  @override
  String get transactionDetailTextLabelTransId => 'Transaction ID';

  @override
  String get transactionDetailDesRecheckInfo =>
      'Please verify the information and keep the slip for evidence.';

  @override
  String get transactionDetailDesCustomerContact =>
      'Customer service contact 02-026-6679 operates 24 hours daily.';

  @override
  String get transactionDetailTextInfoScanVerify => 'Scan to Verify';

  @override
  String get transactionDetailTextButtonSaveReceipt => 'Save Receipt';

  @override
  String get transactionDetailTextButtonGoHome => 'Go to Home';

  @override
  String get transactionDetailTextCredit => 'Powered by WiPay';

  @override
  String get transactionDetailHeaderTotal => 'Total';

  @override
  String transactionDetailHeaderAmountThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String transactionDetailHeaderFeeAmountThb(Object amount, Object currency) {
    return 'Fee $amount $currency';
  }

  @override
  String get transactionDetailTextLabelType => 'Transaction Type';

  @override
  String get transactionDetailTextValueHoldAmount => 'Hold Amount';

  @override
  String get transactionDetailTextLabelPaymentChannel => 'Payment Channel';

  @override
  String get transactionDetailTextValueWallet => 'Wi Wallet';

  @override
  String get transactionDetailTextLabelDate => 'Date&Time';

  @override
  String transactionDetailTextValueDate(Object date, Object time) {
    return '$date $time';
  }

  @override
  String get settingMainMenuHistory => 'History';

  @override
  String get settingHeaderTitle => 'Setting';

  @override
  String get settingMainMenuFingerprint => 'Fingerprint / Face Recognition';

  @override
  String get settingMainMenuOtp => 'OTP Channel';

  @override
  String get settingMainMenuChangePin => 'Change PIN';

  @override
  String get settingMainMenuSelectLang => 'Select Language';

  @override
  String get settingMainMenuLockTrans => 'Lock Transactions';

  @override
  String get settingMainMenuTerms => 'Terms & Conditions';

  @override
  String get settingMainMenuContact => 'Contact Us';

  @override
  String get settingMainMenuLogout => 'Logout';

  @override
  String get settingValueMainMenuFingerprintOn => 'On';

  @override
  String get settingValueMainMenuFingerprintOff => 'Off';

  @override
  String get settingValueMainMenuOtpSms => 'SMS';

  @override
  String get settingValueMainMenuOtpEmail => 'Email';

  @override
  String get settingValueMainMenuSelectLangEn => 'English';

  @override
  String get settingValueMainMenuLockTransOn => 'On';

  @override
  String get settingValueMainMenuLockTransOff => 'Off';

  @override
  String get settingMainMenuAppearances => 'Appearances';

  @override
  String get settingValueMainMenuAppearDark => 'Dark';

  @override
  String get settingValueMainMenuAppearLight => 'Light';

  @override
  String get settingTextVerAppWiWallet => 'Wi Wallet';

  @override
  String get historyHeaderTitle => 'History';

  @override
  String get identityVerificationTitleError => 'Error';

  @override
  String get identityVerificationDesErrorSystem =>
      'Sorry, system has encountered error.please contact customer service available 24 hours daily.';

  @override
  String get identityVerificationTitleCompareFace => 'Comparing face...';

  @override
  String get identityVerificationDesCompareFace => 'Please wait for a moment.';

  @override
  String get identityVerificationTitleKeepLookingStraight =>
      'Keep looking straight.';

  @override
  String get identityVerificationTitleTurnLeft => 'Turn left and hold.';

  @override
  String get identityVerificationTitleTurnRight => 'Turn Right and hold.';

  @override
  String get historyDrawerSelectMonth => 'Select Month';

  @override
  String get transferHeaderTitleTransfer => 'โอนเงิน';

  @override
  String get transferInputLabelAmount => 'Amount';

  @override
  String transferInputInfoMinimumTransfer(Object amount, Object currency) {
    return 'You need to transfer at least $amount $currency.';
  }

  @override
  String get transferInputLabelFrom => 'From';

  @override
  String get transferCardFromTitleYourWiWallet => 'Your Wi Wallet';

  @override
  String get transferCardFromValueTotalBalance => 'Total Balance:';

  @override
  String transferCardFromValueAmount(Object amount) {
    return '฿ $amount';
  }

  @override
  String get transferCardLabelTo => 'To';

  @override
  String get transferCardToValueSelectAccType => 'Select Account Type';

  @override
  String get transferInputLabelObjective => 'Objective';

  @override
  String get transferInputLabelNote => '(optional)';

  @override
  String get transferInputPlaceholderEnterNote => 'Objective of Transfer';

  @override
  String get transferTextButtonReview => 'Review';

  @override
  String get transferDrawerHeaderTitleSelectAccType => 'Select Account Type';

  @override
  String get transferDrawerLabelOtherWallet => 'Other Wi Wallets';

  @override
  String get transferDrawerSelectValueWallet => 'Wi Wallet';

  @override
  String get transferDrawerLabelPromptPayThai => 'PromptPay Thai';

  @override
  String get transferDrawerSelectValuePromptPay => 'PromptPay';

  @override
  String get transferDrawerLabelMobileBank => 'Mobile Banking';

  @override
  String get transferDrawerSelectValueSiamBank => 'Siam Commercial Bank';

  @override
  String get transferDrawerSelectValueBangkokBank =>
      'Bangkok Bank Mobile Banking';

  @override
  String get transferDrawerSelectValueBankAyudhya => 'Bank of Ayudhya';

  @override
  String get transferDrawerSelectValueKasikornBank => 'Kasikorn Bank';

  @override
  String get transferInputLabelAccountNumber => 'Account Number';

  @override
  String get transferInputPlaceholderEnterAccount => 'Enter account number';

  @override
  String get transferDrawerHeaderTitleReview => 'Review';

  @override
  String get transferDrawerWarningTitleRecheckInfo =>
      'Please recheck information before proceeding';

  @override
  String get transferDrawerWarningInfoPreventFraud =>
      'To prevent wrong account transfers or fraudulent activities. It cannot be changed once confirmed.';

  @override
  String get transferDrawerDetailTotal => 'Total';

  @override
  String transferDrawerDetailAmountThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String transferDrawerDetailFeeAmountThb(Object amount, Object currency) {
    return 'Fee $amount $currency';
  }

  @override
  String get transferDrawerDetailFrom => 'From';

  @override
  String get transferDrawerDetailValueYourWallet => 'Your Wi Wallet';

  @override
  String get transferDrawerDetailMobileNumber => 'Mobile Number';

  @override
  String get transferDrawerDetailTo => 'To';

  @override
  String transferDrawerDetailToValue(Object bank) {
    return '$bank';
  }

  @override
  String get transferDrawerDetailAccountName => 'Account Name';

  @override
  String transferDrawerDetailAccountNameValue(Object accountname) {
    return '$accountname';
  }

  @override
  String transferDrawerDetailMobileNumberValue(Object mobilenumber) {
    return '$mobilenumber';
  }

  @override
  String get transferDrawerDetailAccountNumber => 'Account Number';

  @override
  String transferDrawerDetailAccountNumberValue(Object accountnumber) {
    return '$accountnumber';
  }

  @override
  String get transferDrawerLabelObject => 'Objective';

  @override
  String get transferDrawerTextButtonConfirm => 'Confirm';

  @override
  String get transferModalTitleInsufficientBalance => 'Insufficient Balance';

  @override
  String get transferModalDesDepositBalance =>
      'You don’t have enough balance on Wi Wallet. Please deposit the balance.';

  @override
  String get transferModalTextButtonCancel => 'Cancel';

  @override
  String get transferModalTextButtonConfirm => 'Confirm';

  @override
  String get transferModalTitleErrorAccountNumber => 'Error';

  @override
  String get transferModalDescriptionErrorIncorrectAccount =>
      'Sorry, the system has encountered an error. The destination account number is incorrect. Please contact customer service, available 24 hours daily.';

  @override
  String get transferModalTextButtonOk => 'OK';

  @override
  String get transferModalTitleErrorSystem => 'Error';

  @override
  String get transferModalDescriptionSystemErrorTry =>
      'Sorry, system has encountered error. Please try again.';

  @override
  String get scanHeaderTitle => 'Scan';

  @override
  String get scanInfoHoldCamera => 'Hold the camera to scan a QR code.';

  @override
  String get scanButtonLeftFlash => 'Flash';

  @override
  String get scanButtonRightPhoto => 'Photo';

  @override
  String get homeModalTitlePinIncorrectError => 'Error';

  @override
  String get homeModalDesPinIncorrectError =>
      'The system encountered an error because you entered the PIN incorrectly too many times. Please contact customer service available 24 hours daily.';

  @override
  String get homeModalTextButtonContact => 'Contact Us';

  @override
  String get homeAlertInfoErrorSystem =>
      'Sorry, system has encountered error. Please try again.';

  @override
  String get homeDrawerHeaderTitleBalanceDetail => 'Balance Detail';

  @override
  String get homeDrawerDetailTotalBalance => 'Available Balance';

  @override
  String homeDrawerDetailAmountTotalBalanceThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String get homeDrawerDetailHoldAmount => 'Hold Amount*';

  @override
  String homeDrawerDetailHoldAmountThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String get homeDrawerDetailLedgerBalance => 'Ledger Balance';

  @override
  String homeDrawerDetailLedgerBalanceThb(Object amount, Object currency) {
    return '$amount $currency';
  }

  @override
  String get homeDrawerWarningInfoHoldAmount =>
      '*Hold Amount means they aren\'t immediately available for use. Please contact our customer support team for more details and to process the next steps.';

  @override
  String get homeDrawerTextButtonBalanceDetailOk => 'OK';

  @override
  String get historyCardListItemTitleReserveAmount => 'Reserve Hold Amount';

  @override
  String get historyCardListItemTitleHoldAmount => 'Hold Amount';

  @override
  String get announcement => 'Announcement';

  @override
  String get primaryButton => 'Primary Button';

  @override
  String get secondaryButton => 'Secondary Button';

  @override
  String get cardReviewPreviewTitle => 'Review Transaction';
}
