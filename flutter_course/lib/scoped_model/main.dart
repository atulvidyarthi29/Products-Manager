import 'package:flutter_course/scoped_model/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with ConnectProductsModel, UserModel, ProductModel, UtilityModel {}
