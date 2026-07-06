import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_detail/product_detail_bloc.dart';
import '../../bloc/product_detail/product_detail_state.dart';
import '../../pages/product/product_form_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().load(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Detail'),

            actions: [
              if (state.product != null)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormPage(
                          product: state.product!,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),

          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.product == null
                  ? const Center(child: Text('Product not found'))
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.product!.name,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(state.product!.description),
                          const SizedBox(height: 8),
                          Text('Price: \$${state.product!.price}'),
                          const SizedBox(height: 8),
                          Text(
                            'Updated: ${state.product!.updatedAt}',
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}