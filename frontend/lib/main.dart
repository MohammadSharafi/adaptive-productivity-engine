import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql/graphql_client.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  
  runApp(const FocusCraftApp());
}

class FocusCraftApp extends StatelessWidget {
  const FocusCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = GraphQLService.getClient();

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'FocusCraft',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
