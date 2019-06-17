import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
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
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
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

  _scanQR() async {
    String futureString = '';

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    print('futureString: $futureString');

    if (futureString != null) {
      print('Tenemos informacion');
    }
  }
}
