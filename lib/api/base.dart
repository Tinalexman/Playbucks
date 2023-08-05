import 'dart:developer';
import 'package:dio/dio.dart';

export 'dart:developer';
export 'package:dio/dio.dart';
export 'package:playbucks/utils/constants.dart';


//const String baseURL = "http://192.168.43.169:9099";
const String baseURL = "https://king-david-elites.onrender.com";
const String success = "successful";
const String users = "/users";

const String imgPrefix = "data:image/jpeg;base64,";
const String vidPrefix = "data:image/mp4;base64,";

const String notifySignal = "sendNotification";
const String messageSignal = "sendMessage";
const String getMessageSignal = "getMessage";

//Socket? _socket;
String? token;

// final Map<String, List<Function>> _socketManager = {};

final Dio dio = Dio(BaseOptions(
  baseUrl: baseURL,
  receiveTimeout: const Duration(minutes: 5),
  connectTimeout: const Duration(minutes: 5),
  sendTimeout: const Duration(minutes: 5),
));

final Options configuration = Options(headers: {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer ${token!}"
});

void init(String userID) {
  // _socket = io(
  //   'ws://king-david-elites.onrender.com',
  //   //'ws://192.168.43.169:9099',
  //   OptionBuilder().setTransports(['websocket']).build(),
  // );
  //
  // _socket?.onConnect((e) {
  //   log("Connected To WebSocket");
  //   _socket?.emit("addUser", {"_id" : userID});
  // });
  // _socket?.onConnectError((e) => log("Socket Connection Error: $e"));
  // _socket?.onDisconnect((e) => log('Disconnected From WebSocket'));
  // _socket?.onError((e) => log("WebSocket Error: $e"));
  //
  // _socketManager[notifySignal] = [];
  // _socketManager[getMessageSignal] = [];
  //
  // _socket?.on(getMessageSignal, (data) {
  //   if(data == null) return;
  //   List<Function> handlers = _socketManager[getMessageSignal]!;
  //   for(Function handler in handlers) {
  //     handler(data);
  //   }
  // });
  //
  // _socket?.on(notifySignal, (data) {
  //   if(data == null) return;
  //   List<Function> handlers = _socketManager[notifySignal]!;
  //   for(Function handler in handlers) {
  //     handler(data);
  //   }
  // });

}

// void addHandler(String key, Function handler) => _socketManager[key]?.add(handler);
//
// void removeHandler(String key, Function handler) => _socketManager[key]?.remove(handler);
//
// void emit(String signal, Map<String, dynamic> data) => _socket?.emit(signal, data);
//
// void shutdown() => _socket?.disconnect();

class DataListing<T> {
  final int total;
  final List<T> data;

  const DataListing({required this.total, required this.data});
}

class PlaybucksApiResponse<T>
{
  final String message;
  final Status status;
  final T value;

  const PlaybucksApiResponse({required this.value, required this.message, required this.status});
}

enum Status {
  failed,
  success
}