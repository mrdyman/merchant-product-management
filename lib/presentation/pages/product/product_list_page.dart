import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:merchant_product_management/domain/entities/product.dart';
import 'package:merchant_product_management/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:merchant_product_management/presentation/bloc/product_list/product_list_state.dart';
import 'package:merchant_product_management/presentation/pages/product/product_detail_page.dart';
import 'package:merchant_product_management/presentation/pages/product/product_form_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ProductListBloc>().loadProducts();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        context.read<ProductListBloc>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),

      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state.isLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<ProductListBloc>().refresh();
            },
            child: ListView.builder(
              controller: _controller,
              itemCount: state.products.length +
                  (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.products.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final Product product = state.products[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          productId: product.id!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProductFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}