class EndPoint {
  static const String baseUrl = "https://money.iuceg.com/api/";
  static const String uploadUrl = "https://money.iuceg.com/";
  static const String _uploadFolder = '${uploadUrl}public/uploads/';
  static const String signin = '${baseUrl}userlogin';
  static const String signup = '${baseUrl}apiuser';
  static const String getUserData = '${baseUrl}apiuser/';
  static const String uploadUser = '${_uploadFolder}users/';
  static const String uploadPayment = '${_uploadFolder}payments/';
  static const String uploadDepositHistory = '${_uploadFolder}deposits/';
  static const String paymentMehods = '${baseUrl}apipayment';
  static const String depositHistory = '${baseUrl}apideposit/';
  static const String withdrawHistory = '${baseUrl}apiwithdrawal/';
  static const String addDeposit = '${baseUrl}apideposit';
  static const String addRefferal = '${baseUrl}apirefferal';
  static const String advertise = '${baseUrl}apiadvertises/3';
  static const String advertiseBanners = "${_uploadFolder}advertises/";
  static const String withdraw = '${baseUrl}apiwithdrawal';
  static const String getChatAfterId = '${baseUrl}apichats/>,';
  static const String getChatBeforeId = '${baseUrl}apichats/<,';
  static const String postNewChatOrGetLastChatId = "${baseUrl}apichats";
  static const String news = '${baseUrl}apiblogs';
  static const String referalsHistory = '${baseUrl}apirefferal/';
  static const String uploadReferalsHistory = '${_uploadFolder}users/';
  static const String certifications = "${baseUrl}apicerts";
  static const String uploadCertifications = "${_uploadFolder}certs/";
  static const String blogNews = "${baseUrl}apiblogs/new";
  static const String uploadBlogNews = "${_uploadFolder}blogs/";
  static const String supportMessages = "${baseUrl}apisupport";
  static const String referralWebLink = "${uploadUrl}ref/";
  static const String addFcmToken = "${baseUrl}apiuser";
  static const String deleteFcmToken = "${baseUrl}apiuser/";
}

class ApiKey {
  //! main keys
  static const String data = "data";
  static const String status = "status";
  static const String error = "error";
  static const String messageAr = "messageAr";
  static const String messageEn = "messageEn";
  static const String success = "success";
  static const String fail = "fail";
  //! getUserData
  static const String id = "id";
  static const String fullName = "last_name";
  static const String userName = "first_name";
  static const String gender = "gender";
  static const String email = "email";
  static const String mobile = "mobile";
  static const String emailVerifiedAt = "email_verified_at";
  static const String password = "password";
  static const String profile = "profile";
  static const String passport = "passport";
  static const String passportBack = "passport_back";
  static const String levelId = "level_id";
  static const String rememberToken = "remember_token";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const String balance = "balance";
  static const String profit = "profit";
  static const String daily = "daily";
  static const String weekly = "weekly";
  static const String referral = "referral";
  static const String chatBlocked = "blocked";
  static const String chatAllowed = "chat";
  static const String chat = "block";
  //! signin
  static const String user = "user";
  //! get payment data
  static const String name = 'name';
  static const String code = 'code';
  static const String image = 'image';
  //! add to balance
  static const userId = 'user_id';
  static const transactionNumber = 'process';
  static const amount = 'amount';
  //! withdraw main and weelkly balance
  static const type = " type";
  static const accountNumber = 'process';
  static const withdrawMainBalance = 'deposit';
  static const withdrawWeeklyBalance = 'profit';
  static const withdrawProfitBlance = 'profitdeposit';
  //! deposit history
  static const String paymentId = "payment_id";
  static const String paymentAmount = "amount";
  static const String paymentUserId = "user_id";
  static const String paymentImageOne = "image";
  static const String paymentAccepted = "accepted";
  static const String depositPaymentProcess = "process";
  static const String paymentRefuseReason = "refuse_reason";
  static const String paymentCreatedAt = "created_at";
  static const String paymentUpdatedAt = "updated_at";
  static const String paymentFirstName = "first_name";
  static const String paymentProfileImage = "profile";
  static const String paymentName = "name";
  static const String paymentImageTwo = "payments_image";
  //! withdraw history
  static const String withdrawPaymentProcess = "account";
  //! banner images
  static const String link = "link";
  //! chat
  static const String cachedId = "cachedId";
  static const String senderId = "sender_id";
  static const String senderMessage = "sender_message";
  static const String senderName = "sender_name";
  //! news bar
  static const String nameAr = "name_ar";
  static const String descriptionAr = "description_ar";
  static const String descriptionEn = "description_en";
  static const String nameEn = "name_en";
  //! refferals history
  static const String currentUserId = "main_user_id";
  static const String refferalUserId = "user_id";
  //  static const String createdAt= "created_at" ;
  static const String currentFirstName = "main_first_name";
  static const String currentLastName = "main_last_name";
  static const String refferalFirstName = "user_first_name";
  static const String refferalLastName = "user_last_name";
  static const String refferalUserProfile = "user_profile";
  //! support chat
  static const String messageId = "message_id";
  static const String supportId = "support_id";
  static const String supportMessage = "support_message";

  static const String supportName = "support_name";
}
