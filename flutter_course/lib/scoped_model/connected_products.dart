import 'package:flutter_course/models/product.dart';
import 'dart:convert';
import 'package:flutter_course/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class ConnectProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  bool _isLoading = false;
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

  String get selectedProductId {
    return _selProductId;
  }

  bool get displayFavMode {
    return favMode;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  Future<bool> addProduct(
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
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
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
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProduct() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-course-3c7a4.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
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
      // _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final String deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-course-3c7a4.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
      _isLoading = true;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, double price, String image) async {
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
    try {
      final http.Response response = await http.put(
          'https://flutter-course-3c7a4.firebaseio.com/products/${selectedProduct.id}.json',
          body: json.encode(updatedProduct));
      // .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
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
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
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

  void selectProduct(String productId) {
    _selProductId = productId;
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
