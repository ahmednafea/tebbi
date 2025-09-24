class ApiRoutes {
  //base_url
  static final String baseUrl = "https://vcare.integration25.com/api";

  //--------------------------------------------------
  // auth endpoints
  static String register = "$baseUrl/auth/register";
  static String login = "$baseUrl/auth/login";
  static String logout = "$baseUrl/auth/logout";

  //--------------------------------------------------
  // user endpoints
  static String userProfile = "$baseUrl/user/profile";
  static String updateProfile = "$baseUrl/user/update";

  //--------------------------------------------------
  // home endpoints
  static String homeData = "$baseUrl/home/index";

  //--------------------------------------------------
  // governorate endpoints
  static String governorateData = "$baseUrl/governrate/index";

  //--------------------------------------------------
  // city endpoints
  static String cityData = "$baseUrl/city/index";

  static String cityDetailsData(int id) => "$baseUrl/city/show/$id";

  //--------------------------------------------------
  // specialization endpoints
  static String specializationData = "$baseUrl/specialization/index";

  static String specializationDetailsData(int id) =>
      "$baseUrl/specialization/show/$id";

  //--------------------------------------------------
  // appointment endpoints
  static String appointmentData = "$baseUrl/appointment/index";
  static String addAppointment = "$baseUrl/appointment/store";

  //--------------------------------------------------
  // doctor endpoints
  static String doctorData = "$baseUrl/doctor/index";

  static String doctorDetailsData(int id) => "$baseUrl/doctor/show/$id";

  static String cityDoctorsData(int id) =>
      "$baseUrl/doctor/doctor-filter?city=$id";

  static String doctorSearchData(String query) =>
      "$baseUrl/doctor/doctor-search?name=$query";
}
