class EndPoint {
  ///baseurl  static String baseUrl = "http://78.89.159.126:9393/TheOneLahjAPI/api/";
  static String baseUrl = "http://78.89.159.126:9393/TheOneAPILahj/api/";

  ///search
  static String search(String x,int page,) => "${baseUrl}Advertisement/search?keyword=$x&page=$page&pageSize=50";

  ///auth
  static String login = "${baseUrl}Member/login";
  static String signup = "${baseUrl}Member/register";
  static String otpverifyaccount="${baseUrl}Member/verify-otp";
  static String phone = "${baseUrl}Customer/AddCustomer";
  static String changePass =
      "${baseUrl}Member/forgotpassword";
  static String changePassconfirm =
      "${baseUrl}Member/resetpassword";

  ///categories
  static String categories = "${baseUrl}Group/getAllGroups";
  static String addvertisminteall =
      "${baseUrl}Advertisement/GetApprovedPaged?page=1&pageSize=30";
  static String getAdvertisementsById = "${baseUrl}Advertisements/";
  static String getAdvertisementsByGroupID(int x) =>
      "${baseUrl}Advertisement/By-GroupIdPaged?groupId=$x&page=1&pageSize=30";

  ///item
  static String getitembyid(int x) => "${baseUrl}Advertisement/By-Id/$x";

  /// data
  static String getcurrency =    "${baseUrl}Currency/getAllCurrencies";
  static String getAllGovernorates = "${baseUrl}Governorate/getAllGovernorates";
  static String getallServices = "${baseUrl}Service/getAllServices";
  static String getallGroups = "${baseUrl}Group/getAllGroups";

  ///favourite
  static String favourite =
      "${baseUrl}Advertisement/myFavoriteAdvertisementsPaged?page=1&pageSize=5";
  static String createfavourite(int x) => "${baseUrl}Advertisement/Like/$x";
  static String deletefavourite(int x) => "${baseUrl}Advertisement/UnLike/$x";

  /// ads
  static String myadds =
      "${baseUrl}Advertisement/myAdvertisementsPaged?page=1&pageSize=900000";
  static String addads = "${baseUrl}Advertisements/Create";
  static String deletemyadd="${baseUrl}Advertisement/DeleteAdvertisement";
  static String editmyadd="${baseUrl}Advertisements/Edit";
  /// comment
  static String addcomment="${baseUrl}AdvertisementComments/Create";
  static String getComments(int id,int page,int pagesize) =>"${baseUrl}Advertisement/Comments/By-AdvertIdPaged/$id?page=$page&pageSize=$pagesize";
  ///profile
  static String deleteprofile =
      "${baseUrl}Customer/DeleteCustomerByCustomerID?CustomerID=";
  static String editprofile =
      "${baseUrl}Customer/EditProfile";
  static String getProfile="${baseUrl}Member/profile";
  static String Updateprofile="${baseUrl}Member/updateProfile";
  static String Newpassword ="${baseUrl}Member/updatePassword";



}
