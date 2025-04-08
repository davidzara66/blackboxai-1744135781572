import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_manager/models/transaction_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Transactions Collection
  final CollectionReference _transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  // Add new transaction
  Future<void> addTransaction(Transaction transaction) async {
    await _transactionsCollection.doc(transaction.id).set(transaction.toMap());
  }

  // Update transaction
  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionsCollection.doc(transaction.id).update(transaction.toMap());
  }

  // Delete transaction
  Future<void> deleteTransaction(String transactionId) async {
    await _transactionsCollection.doc(transactionId).delete();
  }

  // Get transactions stream
  Stream<List<Transaction>> get transactions {
    return _transactionsCollection
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
       I'll now create the database service since firebase_options.dart was successfully created:

<create_file>
<path>lib/services/database_service.dart</path>
<content>
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_manager/models/transaction_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Transactions Collection
  final CollectionReference _transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  // Add new transaction
  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _transactionsCollection.add(transaction.toMap());
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  // Get all transactions
  Stream<List<Transaction>> getTransactions() {
    return _transactionsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Transaction.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionsCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }

  // Sales/Purchases Collection
  final CollectionReference _salesPurchasesCollection =
      FirebaseFirestore.instance.collection('salesPurchases');

  // Add new sale/purchase
  Future<void> addSalePurchase(SalePurchase transaction) async {
    try {
      await _salesPurchasesCollection.add(transaction.toMap());
    } catch (e) {
      throw Exception('Failed to add sale/purchase: $e');
    }
  }

  // Get all sales/purchases
  Stream<List<SalePurchase>> getSalesPurchases() {
    return _salesPurchasesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SalePurchase.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Inventory Collection
  final CollectionReference _inventoryCollection =
      FirebaseFirestore.instance.collection('inventory');

  // Add inventory item
  Future<void> addInventoryItem(InventoryItem item) async {
    try {
      await _inventoryCollection.doc(item.id).set(item.toMap());
    } catch (e) {
      throw Exception('Failed to add inventory item: $e');
    }
  }

  // Update inventory
  Future<void> updateInventory(String productId, double quantityChange) async {
    try {
      await _inventoryCollection.doc(productId).update({
        'quantity': FieldValue.increment(-quantityChange),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update inventory: $e');
    }
  }

  // Get inventory stream
  Stream<List<InventoryItem>> getInventory() {
    return _inventoryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return InventoryItem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
