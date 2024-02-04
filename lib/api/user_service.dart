import 'package:playbucks/components/user.dart';

import 'base.dart';

Future<PlaybucksResponse<User?>> authenticate(Map<String, dynamic> map,
    {bool login = false}) async {
  try {
    Response response =
        await dio.post("/auth/sign-${login ? "in" : "up"}", data: map);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      User user = User.fromJson(data);
      return PlaybucksResponse(
        value: user,
        message: "Successful",
        success: true,
      );
    }
  } catch (e) {
    log("Authenticate User Error: $e");
  }

  return const PlaybucksResponse(
    value: null,
    message: "An error occurred. Please try again.",
    success: false,
  );
}

Future<PlaybucksResponse> passwordDetails(Map<String, dynamic> map,
    {bool reset = false}) async {
  try {
    Response response = await dio
        .post("/auth/${reset ? "reset" : "forgot"}-password", data: map);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      //Map<String, dynamic> data = response.data as Map<String, dynamic>;

      return const PlaybucksResponse(
        value: null,
        message: "Successful",
        success: true,
      );
    }
  } catch (e) {
    log("Password Details Error: $e");
  }

  return const PlaybucksResponse(
    value: null,
    message: "An error occurred. Please try again.",
    success: false,
  );
}

Future<PlaybucksResponse<User?>> getUser(String id) async {
  try {
    Response response = await dio.get("/auth/$id");

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      User user = User.fromJson(data);
      return PlaybucksResponse(
        value: user,
        message: "Successful",
        success: true,
      );
    }
  } catch (e) {
    log("Authenticate User Error: $e");
  }

  return const PlaybucksResponse(
    value: null,
    message: "An error occurred. Please try again.",
    success: false,
  );
}

Future<PlaybucksResponse<User?>> updateProfile(
    Map<String, dynamic> map, String id) async {
  try {
    Response response = await dio.patch("/auth/$id", data: map);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      User user = User.fromJson(data);
      return PlaybucksResponse(
        value: user,
        message: "Successful",
        success: true,
      );
    }
  } catch (e) {
    log("Authenticate User Error: $e");
  }

  return const PlaybucksResponse(
    value: null,
    message: "An error occurred. Please try again.",
    success: false,
  );
}
