import 'package:demo/bloc/cart/cart_bloc.dart';
import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Bloc

  getIt
      .registerLazySingleton<CartBloc>(() => CartBloc(itemRepository: getIt()));

  getIt.registerLazySingleton(() => ItemsBloc(
        itemRepository: getIt(),
        cartBloc: getIt(),
      ));

  // Repository
  getIt.registerSingleton<ItemRepository>(ItemRepository());
  //! Core
}
