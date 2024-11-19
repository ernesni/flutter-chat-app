
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});


  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'test1@test.com', name: 'Maria', idUser: 1),
    Usuario(online: false, email: 'test2@test.com', name: 'Melissa', idUser: 2),
    Usuario(online: true, email: 'test3@test.com', name: 'Fernando', idUser: 3),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(usuario.name, style: const TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black87), 
          onPressed: () { 
            // TODO: Desconectar el socket server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only( right: 10 ),
            child: Icon( Icons.check_circle, color: Colors.blue.shade400 ),
            //child: Icon( Icons.offline_bolt, color: Colors.red ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        //header: WaterDropMaterialHeader(
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _listViewUsuarios(),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => _usuarioListTile( usuarios[index] ), 
      separatorBuilder: (_, index) => const Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile( Usuario usuario ) {
    return ListTile(
        title: Text(usuario.name),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(usuario.name.substring(0,2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green.shade300 : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  _cargarUsuarios() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}