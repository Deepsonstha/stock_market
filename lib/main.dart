import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market/core/bloc_providers/bloc_observer.dart';
import 'package:stock_market/core/bloc_providers/bloc_providers.dart';
import 'package:stock_market/core/dependency_injection/dependency_injection.dart';
import 'package:stock_market/features/stock_chart/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProvidersList.blocList,
      child: ScreenUtilInit(
        designSize: MediaQuery.of(context).size,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Stock Market',
            home: const HomeScreen(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
