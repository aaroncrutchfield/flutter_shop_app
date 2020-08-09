import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop_app/models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formStateKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();

    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formStateKey.currentState.validate();
    if (!isValid) return;
    _formStateKey.currentState.save();
    print(_editedProduct.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formStateKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (titleInput) {
                  if (titleInput.isEmpty) {
                    return 'Please return a value';
                  }
                  return null;
                },
                onSaved: (titleInput) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: titleInput,
                  price: _editedProduct.price,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (priceInput) {
                  if (priceInput.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(priceInput) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(priceInput) <= 0) {
                    return 'Please enter a price greater than \$0';
                  }
                  return null;
                },
                onSaved: (priceInput) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  price: double.parse(priceInput),
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                validator: (descriptionInput) {
                  if (descriptionInput.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (descriptionInput.length < 10) {
                    return 'Description should be at least 10 characters';
                  }
                  return null;
                },
                onSaved: (descriptionInput) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  description: descriptionInput,
                  imageUrl: _editedProduct.imageUrl,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (urlInput) {
                        if (urlInput.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if(!urlInput.startsWith('http') && !urlInput.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        return null;
                      },
                      onSaved: (urlInput) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        imageUrl: urlInput,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
