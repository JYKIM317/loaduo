import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateStaticPostModel {
  Future<void> uploadData({
    required Map<String, dynamic> data,
    required Map<String, dynamic> character,
    required String address,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .set(data);

    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('JoinCharacter')
        .doc(data['raidLeader'])
        .set(character);
  }

  Future<void> linkStaticPost({
    required String uid,
    required String address,
  }) async {
    List<dynamic> addressList = [];
    try {
      final db = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('MyPosts')
          .doc('StaticPost')
          .get();
      addressList = await db.get('address');
    } catch (e) {
      debugPrint(e.toString());
    }
    addressList.add(address);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('MyPosts')
        .doc('StaticPost')
        .set({'address': addressList});
  }

  Future<void> setChattingAddress({
    required String address,
    required String uid,
    required Map<String, dynamic> info,
    required String title,
    required String subtitle,
  }) async {
    await FirebaseDatabase.instance.ref('Chatting/Static/$address').set({
      'Messages': {},
      'info': info,
      'raid': {
        'title': title,
        'subtitle': subtitle,
      },
    }).then((_) async {
      DateTime now = DateTime.now();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Chattings')
          .doc('Chatting Static $address')
          .set({
        'resentMessageTime': now,
        'resentCheckTime': now,
      });
    });
  }
}
