import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_constants.dart';
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

            // نستخدم ResponsiveLayout لتحديد شكل الجريد حسب الجهاز
            return ResponsiveLayout(
              mobile: _buildGrid(context, state, crossAxisCount: 2, aspectRatio: 0.6),
              tablet: _buildGrid(context, state, crossAxisCount: 3, aspectRatio: 0.63),
              desktop: _buildGrid(context, state, crossAxisCount: 5, aspectRatio: 0.7),
            );
          } else if (state is FavouriteError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, FavouriteLoaded state,
      {required int crossAxisCount, required double aspectRatio}) {
    return Padding(
      padding: Responsive.pagePadding(context),
      child: GridView.builder(
        itemCount: state.favourites.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: Responsive.spacing(context, 16),
          mainAxisSpacing: Responsive.spacing(context, 16),
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (context, i) =>
            ProductCard(product: state.favourites[i]),
      ),
    );
  }
}
