class EnvironmentConfig {
  static
  const BASE_URL = String.fromEnvironment(AppConstants.BASE_URL,
      defaultValue: "https://api.themoviedb.org/3/");
  static
  const IMAGE_BASE_URL = String.fromEnvironment(AppConstants.IMAGE_BASE_URL,
      defaultValue: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/");
  static
  const IMAGE_BASE_URL_COVER = String.fromEnvironment(AppConstants.IMAGE_BASE_URL,
      defaultValue: "https://image.tmdb.org/t/p/w500_and_h282_face/");
  static
  const API_KEY = String.fromEnvironment(AppConstants.API_KEY,
      defaultValue: "709dd7d81d18788a7277683e0c11215f");
}

class AppConstants{
  static const BASE_URL = "BASE_URL";
  static const IMAGE_BASE_URL = "IMAGE_BASE_URL";
  static const API_KEY = "API_KEY";
}