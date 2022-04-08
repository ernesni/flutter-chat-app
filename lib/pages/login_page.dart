import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/helpers/mostar_alerta.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';



class LoginPage extends StatelessWidget {

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
                  title: 'Messenger',
                ),
        
                _Form(),
        
                Labels(
                  ruta: 'register', 
                  textPregunta: 'No tienes cuenta?', 
                  textLink: 'Crea una ahora!'
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
            textBtn: 'ingrese',
            onPressed: authService.autenticando ? (){} : () async {
              //Va a quitar el foco de donde quiera que esté y también va a ocultar el teclado
              FocusScope.of(context).unfocus();
              //listen: false -> para que no intente redibujar por defecto, solo se necesita una referencia
              //final authService = Provider.of<AuthService>(context, listen: false);
              final loginOk = await authService.login( emailCtrl.text.trim(), passCtrl.text.trim() );

              if(loginOk){
                //TODO: Conectar a nuestro socket server
                
                //para que no puedan regresar al login (pushReplacementNamed)
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                //mostar alerta
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }
            },
          )

        ],
      ),
    );
  }
}
