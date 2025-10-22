import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/logic/cubits/favourite/fav_cubit.dart';
import 'package:websiteme/logic/cubits/favourite/fav_states.dart';
import 'package:websiteme/widgets/product_card.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourites')),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            if (state.favourites.isEmpty) {
              return const Center(child: Text('No favourites yet.'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.favourites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, i) =>
                  ProductCard(product: state.favourites[i]),
            );
          } else if (state is FavouriteError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
