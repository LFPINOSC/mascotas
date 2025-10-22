import 'package:flutter/material.dart';
import 'package:mascotas/providers/mascotas_providerbd.dart';
import 'package:mascotas/providers/razas_providerbd.dart';
import 'package:mascotas/screens/inicio_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RazasProviderBD()),
        ChangeNotifierProvider(create: (_) => MascotaProviderBD()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InicioScreen(),
    );
  }
}

