import 'package:flutter_course/models/product.dart';
import 'dart:convert';
import 'package:flutter_course/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class ConnectProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://draxe.com/wp-content/uploads/2016/12/Benefits-of-Dark-Chocolate_HEADER.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .post("https://flutter-course-3c7a4.firebaseio.com/products.json",
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> resData = json.decode(response.body);
      final Product newProduct = Product(
          id: resData['name'],
          title: title,
          description: description,
          image:
              'https://draxe.com/wp-content/uploads/2016/12/Benefits-of-Dark-Chocolate_HEADER.jpg',
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

class ProductModel extends ConnectProductsModel {
  bool favMode = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (favMode) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  bool get displayFavMode {
    return favMode;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  void fetchProduct() {
    _isLoading = true;
    notifyListeners();
    http
        .get('https://flutter-course-3c7a4.firebaseio.com/products.json')
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      List<Product> productList = [];
      if (responseData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      responseData.forEach((String productId, dynamic productData) {
        Product fetchedProduct = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
        productList.add(fetchedProduct);
      });
      _products = productList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;
    final String deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductIndex = null;
    notifyListeners();
    http
        .delete(
            'https://flutter-course-3c7a4.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
      _isLoading = true;

      notifyListeners();
    });
  }

  Future<Null> updateProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> updatedProduct = {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };

    return http
        .put(
            'https://flutter-course-3c7a4.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updatedProduct))
        .then((http.Response response) {
      final Product updProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _products[selectedProductIndex] = updProduct;
      _isLoading = false;
      notifyListeners();
    });
  }

  void toggleFavoriteStatus() {
    final Product selectedProduct = _products[selectedProductIndex];
    Product newProd = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: !selectedProduct.isFavorite,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    _products[selectedProductIndex] = newProd;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleDiplayMode() {
    favMode = !favMode;
    notifyListeners();
  }
}

class UserModel extends ConnectProductsModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: "hgfgsjkfh", email: email, password: password);
  }
}

class UtilityModel extends ConnectProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
