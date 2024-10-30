
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:chat/widgets/chat_message.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});


  @override
  State<ChatPage> createState() => _ChatPageState();
}
// with TickerProviderStateMixin Para las animaciones
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
              child: Text('Te', style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 3),
            const Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ) 
            ),

            const Divider(height: 1 ),

            //Todo caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )

          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    texto.trim().isNotEmpty
                    ? _estaEscribiendo = true
                    : _estaEscribiendo = false;
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje' 
                ),
                focusNode: _focusNode,
              ) 
            ),

            //Botón de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                ? CupertinoButton(
                  child: const Text('Enviar'), 
                  onPressed: _estaEscribiendo 
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null, 
                )
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue.shade400),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _estaEscribiendo 
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null, 
                      
                    ),
                  ),
                )

            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto) {
    if(texto.isEmpty) return;
    print( texto );
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      texto: texto, 
      uid: '123',
      // El this lo tenemos porque mezclamos con el TickerProviderS
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0,newMessage);
    // Para disparar la animación
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Off del socket
    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}