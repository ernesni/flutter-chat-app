
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/button_blue.dart';

import 'package:chat/models/mostrar_alerta.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: 'Registro',),
                _Form(),
                Labels(
                  ruta: 'login',
                  title: 'Ya tienes una cuenta?',
                  subtitle: 'Ingresa ahora!'
                ),
                Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ))
            
              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Form extends StatefulWidget {

   const _Form( { super.key } );

  @override
   _FormState createState() =>  _FormState();

}

class  _FormState extends State<_Form>{

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context){

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_lock_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_clock_outlined,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          ButtonBlue(
            text: 'Crear cuenta',
            onPressed: authService.autenticando ? null : () async {
              //Para quitar el foco
              FocusScope.of(context).unfocus();
              final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());

              if ( registerOk == true ) {
                // TODO: Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else {
                // Mostrar alerta
                mostrarAlerta(context, 'Registro incorrecto', registerOk);
              }
            },
          )
          
        ],
      ),
    );
  }
}