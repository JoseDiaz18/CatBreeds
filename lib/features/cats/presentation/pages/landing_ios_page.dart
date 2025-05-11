import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/breed_cubit.dart';
import '../cubit/breed_state.dart';
import '../widgets/widget.dart';

class LandingIOSPage extends StatelessWidget {
  const LandingIOSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<BreedCubit>()..fetchBreeds(),
      child: CupertinoPageScaffold(
        child: BlocBuilder<BreedCubit, BreedState>(
          builder: (context, state) {
            if (state is BreedLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is BreedLoaded) {
              final breeds = state.breeds;
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: const Text('Cat Breeds'),
                  ),
                  SliverToBoxAdapter(child: _buildSearchField(context)),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final breed = breeds[index];
                        return BreedCardItem(breed: breed);
                      }, childCount: breeds.length),
                    ),
                  ),
                ],
              );
            } else if (state is BreedError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}

Widget _buildSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CupertinoTextField(
      placeholder: 'Search for a breed',
      onChanged: (value) {
        context.read<BreedCubit>().filterBreeds(value);
      },
    ),
  );
}
