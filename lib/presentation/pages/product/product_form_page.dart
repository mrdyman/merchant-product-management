import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../bloc/product_form/product_form_bloc.dart';
import '../../bloc/product_form/product_form_state.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({
    super.key,
    this.product,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late TextEditingController nameCtrl;
  late TextEditingController descCtrl;
  late TextEditingController priceCtrl;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    nameCtrl = TextEditingController(text: product?.name ?? '');
    descCtrl = TextEditingController(text: product?.description ?? '');
    priceCtrl = TextEditingController(
      text: product?.price.toString() ?? '',
    );

    if (product != null) {
      context.read<ProductFormBloc>()
        ..updateName(product.name)
        ..updateDescription(product.description)
        ..updatePrice(product.price);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Product' : 'Create Product'),
      ),
      body: BlocConsumer<ProductFormBloc, ProductFormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
          }

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (v) =>
                      context.read<ProductFormBloc>().updateName(v),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (v) =>
                      context.read<ProductFormBloc>().updateDescription(v),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: priceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                  onChanged: (v) => context
                      .read<ProductFormBloc>()
                      .updatePrice(double.tryParse(v) ?? 0),
                ),
                const SizedBox(height: 24),

                if (state.isSubmitting)
                  const CircularProgressIndicator()
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isEdit) {
                          context
                              .read<ProductFormBloc>()
                              .submitUpdate(widget.product!.id!);
                        } else {
                          context
                              .read<ProductFormBloc>()
                              .submitCreate();
                        }
                      },
                      child: Text(isEdit ? 'Update' : 'Create'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}