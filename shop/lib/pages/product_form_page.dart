import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart' show Product;
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
    _imageUrlControler.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final product = argument as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlControler.text = product.imageUrl;

        _isEditing = true;
      }
    }
  }

  void _updateImage() {
    setState(() {});
  }

  bool isValidUrl(String url) {
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValid && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao tentar salvar o produto!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Produto' : 'Adicionar Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Container(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _isLoading,
        child: Opacity(
          opacity: _isLoading ? 0.5 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration: InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (nome) => _formData['name'] = nome ?? '',
                    validator: (nome) {
                      if (nome == null || nome.trim().isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      if (nome.trim().length < 3) {
                        return 'Nome deve ter no mínimo 3 letras';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _formData['price']?.toString(),
                    decoration: InputDecoration(labelText: 'Preço'),
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocus,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    onSaved: (preco) =>
                        _formData['price'] = double.parse(preco ?? '0'),
                    validator: (preco) {
                      final price = double.tryParse(preco ?? '');
                      if (price == null || price <= 0) {
                        return 'Informe um preço válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _formData['description']?.toString(),
                    decoration: InputDecoration(labelText: 'Descrição'),
                    textInputAction: TextInputAction.next,
                    focusNode: _descriptionFocus,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_imageUrlFocus);
                    },
                    onSaved: (descricao) =>
                        _formData['description'] = descricao ?? '',
                    validator: (descricao) {
                      if (descricao == null || descricao.trim().isEmpty) {
                        return 'Descrição é obrigatória';
                      }
                      if (descricao.trim().length < 10) {
                        return 'Descrição deve ter no mínimo 10 letras';
                      }
                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'URL da Imagem',
                          ),
                          focusNode: _imageUrlFocus,
                          controller: _imageUrlControler,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitForm(),
                          onSaved: (imageUrl) =>
                              _formData['imageUrl'] = imageUrl ?? '',
                          validator: (imageUrl) {
                            if (imageUrl == null || imageUrl.isEmpty) {
                              return 'Informe a URL da imagem';
                            }

                            if (!isValidUrl(imageUrl)) {
                              return 'URL inválida';
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: _imageUrlControler.text.isEmpty
                            ? Text('Informe a URL')
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlControler.text),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
