part of 'widget.dart';

class BreedCardItem extends StatelessWidget {
  const BreedCardItem({super.key, required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          Platform.isIOS
              ? CupertinoPageRoute(
                builder: (context) => CatDetailsIOSPage(breed: breed),
              )
              : MaterialPageRoute(
                builder: (context) => CatDetailsPage(breed: breed),
              ),
        );
      },
      child: Card.outlined(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(title: Text(breed.name), trailing: Text('Más...')),
            Hero(
              tag: breed.id,
              transitionOnUserGestures: true,
              child: Image.network(
                loadingBuilder:
                    (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : SizedBox(
                              height: 200,
                              child: Center(
                                child:
                                    Platform.isIOS
                                        ? const CupertinoActivityIndicator()
                                        : const CircularProgressIndicator(),
                              ),
                            ),
                breed.imageUrl.isNotEmpty
                    ? breed.imageUrl
                    : 'https://placehold.co/600x400',

                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text('Country: ${breed.origin}'),
              trailing: Text('Inteligence: ${breed.intelligence}'),
            ),
          ],
        ),
      ),
    );
  }
}
