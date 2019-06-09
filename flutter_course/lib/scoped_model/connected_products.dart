import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(
      String title, String description, double price, String image) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        id: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
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

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void updateProduct(
      String title, String description, double price, String image) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        id: selectedProduct.id);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleFavoriteStatus() {
    final Product selectedProduct = _products[selectedProductIndex];
    Product newProd = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: !selectedProduct.isFavorite,
      userEmail: selectedProduct.userEmail,
      id: selectedProduct.id,
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
