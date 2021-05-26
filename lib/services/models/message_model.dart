import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageModel {
  String question;
  int questionTimestamp;
  int answerTimeStamp;
  String userUid;
  String productId;
  String answer;
  bool hasAnswer;

  MessageModel(
      {this.hasAnswer,
      this.productId,
      this.question,
      this.questionTimestamp,
      this.answerTimeStamp,
      this.answer,
      this.userUid});

  factory MessageModel.byUid({@required DocumentSnapshot doc}) {
    return MessageModel(
        hasAnswer: doc['has_answer'],
        answer: doc['answer'],
        productId: doc['product_id'],
        question: doc['question'],
        questionTimestamp: doc['question_timestamp'],
        answerTimeStamp: doc['ans_timestamp'],
        userUid: doc.id);
  }
  MessageModel.fromFireStore(
      {@required Map<String, dynamic> map, @required String userUid}) {
    this.answer = map['answer'];
    this.hasAnswer = map['has_answer'];
    this.productId = map['product_id'];
    this.question = map['question'];
    this.userUid = userUid;
    this.answerTimeStamp = map['ans_timestamp'];
    this.questionTimestamp = map['question_timestamp'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['has_answer'] = this.hasAnswer;
    map['answer'] = this.answer;
    map['ans_timestamp'] = this.answerTimeStamp;
    return map;
  }
}
