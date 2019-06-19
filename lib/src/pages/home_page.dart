import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'dart:io';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScansTodos,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map), 
          title: Text('Mapas'),    
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  _scanQR(BuildContext context) async {
    //https://www.google.com
    //geo:-34.921690702443165,-57.95414343317873

    String futureString;
    //String futureString = 'geo:-34.921690702443165,-57.95414343317873';
    //String futureString = 'https://www.google.com';

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    // print('futureString: $futureString');

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      // final scan2 = ScanModel(valor: 'geo:-34.921690702443165,-57.95414343317873');
      // scansBloc.agregarScan(scan2);

      if( Platform.isIOS ){
        Future.delayed(Duration(microseconds: 750), (){
          utils.abrirScan(context, scan);
        });
      }

      utils.abrirScan(context, scan);
    }
  }
}
