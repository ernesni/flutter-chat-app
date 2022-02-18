import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/chat_message.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}
//para sincronizar las animaciones
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox( height: 3 ),
            Text( 'Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12) )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _, i) => _messages[i],
                reverse: true,
              )
            ),

            Divider( height: 1 ),

            Container(
              color: Colors.white,
              child: _inputChat(),
            )

          ],
        )
     ),
   );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0),
        child: Row(
          children: [

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( String texto ){
                  setState(() {
                    if ( texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    }else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            //Botón de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS 
              ? CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _estaEscribiendo 
                        ? () => _handleSubmit( _textController.text.trim() )
                        : null
                )

                : Container(
                  margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                  child: IconTheme(
                    data: IconThemeData( color: Colors.blue[400]),
                    child: IconButton(
                      //Para quitar el material del botón que se ve de fondo
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon( Icons.send ), 
                      onPressed: _estaEscribiendo 
                        ? () => _handleSubmit( _textController.text.trim() )
                        : null
                    ),
                  ),
                )
            )

          ],
        ),
      )
    );

  }

  _handleSubmit( String texto ) {
    if ( texto.length == 0) return;
    //Para limpiar la caja de texto
    _textController.clear();
    //Para no perder el foco
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: '123',
      //para que aparezaca el this tenemos que tener => with TickerProviderStateMixin
      animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 200 ))
    );
    _messages.insert(0, newMessage);
    //Para que dispare el proceso de animacion
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //Para limpiar la pantalla al cerrar el chat
    
    // TODO: off del socket

    for ( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }
    super.dispose();
  }

}