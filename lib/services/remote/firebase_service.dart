import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_mobile_app/models/response/address_response.dart';
import 'package:ecommerce_mobile_app/models/response/category_response.dart';
import 'package:ecommerce_mobile_app/models/response/product_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseService(this._firebaseAuth, this._firebaseFirestore);

  /// Create a new account with email/password and store user profile in Firestore.
  Future<void> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    /// authen create account
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    final now = FieldValue.serverTimestamp();

    /// store user profile in Firestore
    await _firebaseFirestore.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  /// Sign in with email/password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Fetch all categories from Firestore.
  Future<List<CategoryResponseModel>> getCategories() async {
    final snapshot = await _firebaseFirestore.collection('categories').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return CategoryResponseModel.fromJson(data);
    }).toList();
  }

  /// Fetch all top selling products from Firestore.
  Future<List<ProductResponseModel>> getTopSellingProducts() async {
    final snapshot = await _firebaseFirestore.collection('Top Selling').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final oldPriceValue = data['oldPrice'];

      return ProductResponseModel.fromJson({
        'id': doc.id,
        'name': data['name'] as String? ?? '',
        'image': data['image'] as String? ?? '',
        'price': data['price'] ?? 0,
        'oldPrice': oldPriceValue is num ? oldPriceValue : null,
        'isFavorite': data['isFavorite'] as bool? ?? false,
      });
    }).toList();
  }

  /// Get current user UID.
  String get currentUid => _firebaseAuth.currentUser!.uid;

  /// Fetch all addresses for the current user.
  Future<List<AddressResponseModel>> getAddresses() async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .doc(currentUid)
        .collection('address')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return AddressResponseModel.fromJson(data);
    }).toList();
  }

  /// Add a new address for the current user.
  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUid)
        .collection('address')
        .add({
          'streetAddress': streetAddress,
          'city': city,
          'state': state,
          'zipCode': zipCode,
        });
  }

  /// Update an existing address.
  Future<void> updateAddress({
    required String addressId,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUid)
        .collection('address')
        .doc(addressId)
        .update({
          'streetAddress': streetAddress,
          'city': city,
          'state': state,
          'zipCode': zipCode,
        });
  }
}
