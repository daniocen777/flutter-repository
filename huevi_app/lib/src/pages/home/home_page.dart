import 'package:flutter/material.dart';
import 'package:huevi_app/src/pages/home/widgets/home_header.dart';
import 'package:huevi_app/src/pages/home/widgets/item.dart';
import 'package:huevi_app/src/pages/videos/videos_page.dart';

class HomePage extends StatefulWidget {
  static final route = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          HomeHeader(),
          ItemHome(
            imagePath: 'assets/images/home/milechi.jpg',
            title: 'Milechi',
            description:
                'Video completo de Milechi, nada que el de 8 minutos, acá tenemos el de 12. Pajas aseguradas.',
          ),
          ItemHome(
            imagePath: 'assets/images/home/trio.jpg',
            title: 'Trío',
            description:
                'Mira el trío con Daniela Dancourt. Mira los encantos de Daniela y las mierdas que son Jorge y Ricardo. Sorprende que tengan flacas.',
            onPressed: () {
              Navigator.pushNamed(context, VideosPage.route);
            },
          ),
          ItemHome(
            imagePath: 'assets/images/home/chupa2.jpg',
            title: 'Los chupa pingas',
            description:
                'Mira las ocurrencias de los esclavos, sobre todo del lisiado, más conocido como "pisa hueco".',
          ),
          ItemHome(
            imagePath: 'assets/images/home/martin.jpg',
            title: 'Sección Martpin Mendoza',
            description:
                'Este huevón no necesita introducción, sólo mira su sección, la máxima.',
          ),
          ItemHome(
            imagePath: 'assets/images/home/encerrona.jpg',
            title: 'Entradas Para La Encerrona',
            description:
                'HABLANDO HUEVADAS – LA ENCERRONA SHOW EXCLUSIVO ONLINE',
          ),
          ItemHome(
            imagePath: 'assets/images/home/entradas.jpg',
            title: 'La Escuelita',
            description:
                'ENSEÑANDO HUEVADAS, CLASES DE STAND UP COMEDY, INICIA: LUNES 07 DE SEPTIEMBRE',
          ),
          ItemHome(
              imagePath: 'assets/images/home/videos.svg',
              title: 'Video Privados',
              description:
                  'Sí, tenemos video caletas, si eres un chucha, esta sección es para ti.',
              isSvg: true),
          ItemHome(
            imagePath: 'assets/images/home/cabros.jpg',
            title: 'Cabros',
            description:
                'Mira la primera vez que nos cachamos. Sólo para los que tienen estómagos poderosos.',
          ),
        ],
      ),
    );
  }
}
