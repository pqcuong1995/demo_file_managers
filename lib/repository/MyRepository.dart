

import 'dart:io';
import 'package:demo_file_manager/database/app_database.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:demo_file_manager/model/User.dart';
import 'package:flutter/services.dart';

abstract class MyRepository{
  final db = AppDatabase.instance;

  Future<void> insertSingleItem(Item item);
  Future<void> savePassword(User user);
  Future<void> insertItems(List<Item> items);
  Future<List<Item>?> getAllItems();
  Future<List<User>?> getAllUser();
  Future<List<Item>> getItemsByCategory(String catIds);
  Future<void> loadGraphFromFile();
  Future<int> updateItem(Item item);
  Future<String> getCategoryName(int categoryId);
  Future<String> getItemsThatCategoryAssigned(int categoryId);
  Future<Item?> readItem(int id);
  Future<void> updateCategoryIdToItems(List<int> itemIds, List<int> categoryIds);
  Future<List<int>> getAssignedCategoryIds(int itemId);

}

class MyRepositoryImpl extends MyRepository{
  @override
  Future<void> insertSingleItem(Item item) {
    return db.insertItem(item);
  }

  Future<File> writeToFile(ByteData data, String path) {
    return File(path).writeAsBytes(data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    ));
  }

  @override
  Future<void> savePassword(User user) {
    return db.savePassword(user);
  }

  @override
  Future<List<User>?> getAllUser() {
    return db.getUser();
  }

  @override
  Future<List<Item>?> getAllItems() {
    // TODO: implement getAllItems
    throw UnimplementedError();
  }

  @override
  Future<List<int>> getAssignedCategoryIds(int itemId) {
    // TODO: implement getAssignedCategoryIds
    throw UnimplementedError();
  }

  @override
  Future<String> getCategoryName(int categoryId) {
    // TODO: implement getCategoryName
    throw UnimplementedError();
  }

  @override
  Future<List<Item>> getItemsByCategory(String catIds) {
    // TODO: implement getItemsByCategory
    throw UnimplementedError();
  }

  @override
  Future<String> getItemsThatCategoryAssigned(int categoryId) {
    // TODO: implement getItemsThatCategoryAssigned
    throw UnimplementedError();
  }

  @override
  Future<void> insertItems(List<Item> items) {
    // TODO: implement insertItems
    throw UnimplementedError();
  }

  @override
  Future<void> loadGraphFromFile() {
    // TODO: implement loadGraphFromFile
    throw UnimplementedError();
  }

  @override
  Future<Item?> readItem(int id) {
    // TODO: implement readItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategoryIdToItems(List<int> itemIds, List<int> categoryIds) {
    // TODO: implement updateCategoryIdToItems
    throw UnimplementedError();
  }

  @override
  Future<int> updateItem(Item item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

}