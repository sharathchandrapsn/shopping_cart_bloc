import 'package:get_it/get_it.dart';
import 'package:shopping_cart_bloc/repository/home_repository.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
}
