// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product_provider.dart';
// import '../core/constants/app_colors.dart';

// class CustomSearchBar extends StatefulWidget {
//   const CustomSearchBar({super.key});

//   @override
//   State<CustomSearchBar> createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   final _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 600),
//       child: TextField(
//         controller: _controller,
//         decoration: InputDecoration(
//           hintText: 'Search products...',
//           prefixIcon: const Icon(Icons.search),
//           suffixIcon: _controller.text.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () {
//                     _controller.clear();
//                     context.read<ProductProvider>().setSearchQuery('');
//                   },
//                 )
//               : null,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: const BorderSide(color: AppColors.border),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: const BorderSide(color: AppColors.border),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: const BorderSide(color: AppColors.primary, width: 2),
//           ),
//           filled: true,
//           fillColor: AppColors.background,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         ),
//         onChanged: (value) {
//           context.read<ProductProvider>().setSearchQuery(value);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;

  const CustomSearchBar({super.key, this.onSearchChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged?.call('');
                    setState(() {}); // عشان نحدث واجهة البحث بعد المسح
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        onChanged: (value) {
          widget.onSearchChanged?.call(value);
          setState(() {}); // لتحديث ظهور زر المسح
        },
      ),
    );
  }
}
