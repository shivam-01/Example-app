import 'package:demo/bloc/cart/cart_bloc.dart';
import 'package:demo/bloc/items/items_bloc.dart';
import 'package:demo/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_it.dart' as di;
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ItemsBloc>()..add(GetItems()),
        ),
        BlocProvider(
          create: (context) => getIt<CartBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
