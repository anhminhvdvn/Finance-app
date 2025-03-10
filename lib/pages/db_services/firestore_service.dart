import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/category.dart';
import '../../model/item.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Thêm Category
  Future<void> addCategory(Category category) async {
    DocumentReference ref = _db.collection('categories').doc();
    category.id = ref.id; // Gán ID từ Firestore
    await ref.set(category.toMap());
  }

  // Cập nhật Category
  Future<void> updateCategory(Category category) async {
    await _db
        .collection('categories')
        .doc(category.id)
        .update(category.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    WriteBatch batch = _db.batch();

    // Xóa tất cả các Item thuộc Category này
    QuerySnapshot itemsSnapshot = await _db
        .collection('items')
        .where('categoryId', isEqualTo: categoryId)
        .get();

    for (var doc in itemsSnapshot.docs) {
      batch.delete(doc.reference);
    }

    // Xóa chính Category đó
    batch.delete(_db.collection('categories').doc(categoryId));

    // Thực hiện xóa trong một batch (đồng bộ)
    await batch.commit();
  }

  // Lấy danh sách Categories theo loại
  Stream<List<Category>> getCategories(String type) {
    return _db
        .collection('categories')
        .where('type', isEqualTo: type)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Category.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // Thêm Item
  Future<void> addItem(Item item) async {
    DocumentReference ref = _db.collection('items').doc();
    item.id = ref.id; // Gán ID từ Firestore
    await ref.set(item.toMap());
  }

  // Cập nhật Item
  Future<void> updateItem(Item item) async {
    await _db.collection('items').doc(item.id).update(item.toMap());
  }

  // Xóa Item
  Future<void> deleteItem(String itemId) async {
    await _db.collection('items').doc(itemId).delete();
  }

  // Lấy danh sách Items theo Category
  Stream<List<Item>> getItems(String categoryId) {
    return _db
        .collection('items')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
