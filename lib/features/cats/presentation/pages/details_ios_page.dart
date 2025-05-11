import 'package:flutter/cupertino.dart';

import '../../domain/entities/breed.dart';

class CatDetailsIOSPage extends StatelessWidget {
  const CatDetailsIOSPage({super.key, required this.breed});
  final Breed breed;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageContainerHeight = screenHeight * 0.5;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(breed.name, style: TextStyle(fontFamily: 'Inter')),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: imageContainerHeight,
                child: Hero(
                  tag: breed.id,
                  transitionOnUserGestures: true,
                  child: Image.network(
                    breed.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageContainerHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  16.0,
                  16.0,
                  MediaQuery.of(context).padding.bottom + 16.0,
                ),
                child: CatDetailsWidget(breed: breed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatDetailsWidget extends StatelessWidget {
  const CatDetailsWidget({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Raza: ${breed.name}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Tiempo de vida: ${breed.lifeSpan} años',
          style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
        ),
        SizedBox(height: 16),
        Text(
          breed.description,
          style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          'Temperamento: ${breed.temperament}',
          style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
        ),
        SizedBox(height: 16),
        Text(
          'Origen: ${breed.origin}',
          style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
