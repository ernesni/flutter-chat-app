import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
       // Para crear una instancia global de mi AuthService
       providers: [
         ChangeNotifierProvider(create: ( _ ) => AuthService()),
       ],
       //Como el Multiprovider está arriba del MaterialApp todas las rutas van a tener en su context al AuthService
       child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          initialRoute: 'loading',
          routes: appRoutes,
       ),
     );
  }
}