import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/boton_azul.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/helpers/mostar_alerta.dart';



class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          //para que le de el efecto rebote cuando se hace scroll
          physics: BouncingScrollPhysics(),
          child: Container(
            //para que tome el 90% del tamaño de la pantalla
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                
                Logo(
                  title: 'Registro',
                ),
        
                _Form(),
        
                Labels(
                  ruta: 'login',
                  textPregunta: 'Ya tienes una cuenta?', 
                  textLink: 'Ingresa ahora!'
                ),
        
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w300))
                
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  const _Form({ Key? key }) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          BotonAzul(
            textBtn: 'Crear cuenta',
            onPressed: authService.autenticando ? (){} : () async {
              FocusScope.of(context).unfocus();

              final registroOk =  await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
              if ( registroOk == true ){
                //TODO: Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Registro incorrecto', registroOk);
              }
            },
          )

        ],
      ),
    );
  }
}