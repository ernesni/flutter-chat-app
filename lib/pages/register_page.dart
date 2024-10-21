import 'package:chat/widgets/button_blue.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
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

   const _Form( { Key? key } )
       : super(key: key);

  @override
   _FormState createState() =>  _FormState();

}

class  _FormState extends State<_Form>{

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context){

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
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
            text: 'Ingrese',
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          )
          
        ],
      ),
    );
  }
}