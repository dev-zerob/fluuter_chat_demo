import 'package:chat_demo/repositories/service/auth_service.dart';
import 'package:chat_demo/repositories/service/chat_service.dart';
import 'package:chat_demo/repositories/service/firebase_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => ChatService());
}