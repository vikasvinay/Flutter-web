import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class KarmaUser extends Equatable {
   String name;
   String photoUrl;
   String uid;
   double karmaPoints;
   String role;
   Timestamp dob;
   String fcmToken;
   List articlesRead;
   dynamic articlereadKP;
   Timestamp latestMood;
   double moodVal;
   double celebrityKp;
   String countryName;
   double lat;
   double lon;
   int treegift;
   int plantgift;
   int heartgift;
   int giftskpdonated;
   List userfavorite;
   List<String> interests;
   List leadersSupported;
   int quizKp;
  // List followList;
  // var followersList;
   int karmaPointsDonated;
   int leadersAdded;
   Map badgesEarned; //only store the uid and count of badges

  //task categories data
   int reduceKP;
   int reuseKP;
   int recycleKP;
   int reduceTD;
   int reuseTD;
   int recycleTD;
   int totalTaskTD;

  // For vendor data
   bool isVendor;
   int carbonEmiited;
   int carbonOffset;
   int latestCarbonEmitted;
   int latestCarbonOffset;

  // recycle data
   int wasteRecycled;
   double recycleKPearned;
   int recycleGiven;
   int recycleBought;
   int numberOfBids;
   String id;

  // E-commers
   int totalProductsBuy;
   int totalProductsReturn;
   int totalProductsInCart;
  KarmaUser(
      {@required this.name,
      @required this.totalProductsBuy,
      @required this.totalProductsReturn,
      @required this.totalProductsInCart,
      @required this.userfavorite,
      @required this.giftskpdonated,
      @required this.treegift,
      @required this.plantgift,
      @required this.heartgift,
      @required this.latestMood,
      @required this.photoUrl,
      @required this.articlereadKP,
      @required this.articlesRead,
      @required this.moodVal,
      @required this.uid,
      @required this.karmaPoints,
      @required this.role,
      @required this.dob,
      @required this.countryName,
      @required this.lat,
      @required this.lon,
      @required this.interests,
      @required this.quizKp,
      // @required this.followList,
      // @required this.followersList,
      @required this.karmaPointsDonated,
      @required this.leadersSupported,
      @required this.isVendor,
      @required this.carbonEmiited,
      @required this.carbonOffset,
      @required this.latestCarbonEmitted,
      @required this.latestCarbonOffset,
      @required this.badgesEarned,
      @required this.recycleBought,
      @required this.recycleGiven,
      @required this.recycleKPearned,
      @required this.wasteRecycled,
      @required this.recycleKP,
      @required this.recycleTD,
      @required this.reuseKP,
      @required this.reuseTD,
      @required this.reduceKP,
      @required this.reduceTD,
      @required this.totalTaskTD,
      @required this.fcmToken,
      @required this.numberOfBids,
      @required this.id,
      @required this.celebrityKp,
      @required this.leadersAdded});

  KarmaUser.fromFirestore({@required Map<String, dynamic> map}) {

        this.userfavorite= map["userfavorite"] ?? [];
        this.giftskpdonated= map["giftskpdonated"] ?? 0;
        this.treegift= map["treegift"] ?? 0;
        this.plantgift= map["plantgift"] ?? 0;
        this.heartgift= map["heartgift"] ?? 0;
        this.celebrityKp= map["celebrityKp"]?.toDouble() ?? 0.0;
        this.id= map['uid'];
        this.isVendor= map['isVendor'] ?? false;
        this.fcmToken= map['fcmToken'];
        this.moodVal= map['moodVal']?.toDouble() ?? 8.0;
        this.karmaPoints= map['karmaPoints']?.toDouble() ?? 0.0;
        this.name= map['name'];
        this.photoUrl= map['photoUrl'];
        this.role= map['role'];
        this.countryName= map['countryName'];
        this.uid= map['uid'];
        this.dob= map['dob'];
        this.latestMood= map['latestMood'] ?? null;
        this.articlesRead= map['articlesRead'] ?? [];
        this.interests= map['interests'];
        //  followList= map['followList'] ?? [];
        // followersList= map['followersList'] ?? [];
        this.articlereadKP= map['articlereadKP'] ?? 0.0;
        this.karmaPointsDonated= map['karmaPointsDonated'] ?? 0;
        this.leadersSupported= map['leadersSupported'] ?? [];
        this.carbonEmiited= map["carbonEmitted"] ?? map["carbonOffset"] ?? 1;
        this.carbonOffset= map["carbonOffset"] ?? 0;
        this.latestCarbonEmitted= map['latestCarbonEmitted']?.toInt() ??
            map["latestCarbonOffset"]?.toInt() ??
            1;
        this.latestCarbonOffset= map["latestCarbonOffset"] ?? 0;
        this.badgesEarned= map['badgesEarned'] ?? Map<String, dynamic>();
        this.recycleBought= map['recycleBought'] ?? 0;
        this.recycleGiven= map['recycleGiven'] ?? 0;
        this.recycleKPearned= map['recycleKPearned']?.toDouble() ?? 0.0;
        this.wasteRecycled= map['wasteRecycled'] ?? 0;
        this.recycleKP= map["recycleKP"] ?? 0;
        this.recycleTD= map["recycleTD"] ?? 0;
        this.reuseKP= map["reuseKP"] ?? 0;
        this.reuseTD= map["reuseTD"] ?? 0;
        this.reduceKP= map["reduceKP"] ?? 0;
        this.reduceTD= map["reduceTD"] ?? 0;
        this.numberOfBids= map["numberOfBids"] ?? 0;
        this.totalTaskTD= (map["reuseTD"] ?? 0) +
            (map["recycleTD"] ?? 0) +
            (map["reduceTD"] ?? 0);
        this.leadersAdded= map['leadersAdded'] ?? 0;
        this.lat= map["lon"] ?? 0.0;
        this.lon= map["lat"] ?? 0.0;
        this.quizKp= map["quizKp"] ?? 0;
        this.totalProductsBuy= map['totalProductsBuy'] ?? 0;
        this.totalProductsInCart= map['totalProductsInCart'] ?? 0;
        this.totalProductsReturn= map['totalProductsReturn'] ?? 0;
  }

  @override
  List<Object> get props => [
        name,
        totalProductsBuy,
        totalProductsInCart,
        totalProductsReturn,
        celebrityKp,
        userfavorite,
        giftskpdonated,
        treegift,
        plantgift,
        heartgift,
        id,
        moodVal,
        uid,
        role,
        countryName,
        lat,
        lon,
        latestMood,
        badgesEarned.hashCode,
        photoUrl,
        dob,
        articlesRead,
        articlereadKP,
        interests.hashCode,
        //followList.hashCode,
        // followersList.hashCode,
        leadersSupported.hashCode,
        isVendor,
        carbonEmiited,
        carbonOffset,
        recycleBought,
        recycleGiven,
        recycleKPearned,
        wasteRecycled,
        recycleKP,
        recycleTD,
        reuseKP,
        reuseTD,
        reduceKP,
        reduceTD,
        numberOfBids,
        fcmToken,
        quizKp
      ];
}
