import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penerjemahv2/bloc_file/terjemah_cubit.dart';
import 'bloc_file/listkata_cubit.dart';
import 'menu_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TranslationCubit>(
          create: (context) => TranslationCubit(),
        ),
        BlocProvider<KamusCubit>(
          create: (context) => KamusCubit()..fetchData(),
        ),
      ],
      child: const MaterialApp(
        home: MenuTab(),
      ),
    );
  }
}
