import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class ProfileModel {
  bool? status;
  String? message;
  DataProfileModel? data;
  int? total;

  ProfileModel({this.status, this.message, this.data, this.total});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        status: json['status'],
        message: json['message'],
        data: DataProfileModel.fromJson(json['data']),
        total: json['total']);
  }
}

// ToDo: Tim giai phap remove warning
class DataProfileModel extends Equatable {
  String? refreshToken;
  String? refreshTokenExpiryTime;
  String? avatar;
  String? displayName;
  String? lastName;
  String? firstName;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? passport;
  String? identityCode;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String? lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  DataProfileModel(
      {this.refreshToken,
      this.refreshTokenExpiryTime,
      this.avatar,
      this.displayName,
      this.lastName,
      this.firstName,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.city,
      this.country,
      this.passport,
      this.identityCode,
      this.id,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed = true,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed = true,
      this.twoFactorEnabled = true,
      this.lockoutEnd,
      this.lockoutEnabled = true,
      this.accessFailedCount = 0});

  Uint8List? convertAvatar() {
    try {
      return base64Decode(avatar!);
    } catch (e) {
      return null;
    }
  }

  factory DataProfileModel.fromJson(Map<String, dynamic> json) {
    return DataProfileModel(
        refreshToken: json['refreshToken'],
        refreshTokenExpiryTime: json['refreshTokenExpiryTime'],
        avatar: json['avatar'],
        displayName: json['displayName'],
        lastName: json['lastName'],
        firstName: json['firstName'],
        dateOfBirth: json['dateOfBirth'],
        gender: json['gender'],
        address: json['address'],
        city: json['city'],
        country: json['country'],
        passport: json['passport'],
        identityCode: json['identityCode'],
        id: json['id'],
        userName: json['userName'],
        normalizedUserName: json['normalizedUserName'],
        email: json['email'],
        normalizedEmail: json['normalizedEmail'],
        emailConfirmed: json['emailConfirmed'],
        passwordHash: json['passwordHash'],
        securityStamp: json['securityStamp'],
        concurrencyStamp: json['concurrencyStamp'],
        phoneNumber: json['phoneNumber'],
        phoneNumberConfirmed: json['phoneNumberConfirmed'],
        twoFactorEnabled: json['twoFactorEnabled'],
        lockoutEnd: json['lockoutEnd'],
        lockoutEnabled: json['lockoutEnabled'],
        accessFailedCount: json['accessFailedCount']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'refreshToken': refreshToken,
        'refreshTokenExpiryTime': refreshTokenExpiryTime,
        'avatar': avatar,
        'displayName': displayName,
        'lastName': lastName,
        'firstName': firstName,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'address': address,
        'city': city,
        'country': country,
        'passport': passport,
        'identityCode': identityCode,
        'id': id,
        'userName': userName,
        'normalizedUserName': normalizedUserName,
        'email': email,
        'normalizedEmail': normalizedEmail,
        'emailConfirmed': emailConfirmed,
        'passwordHash': passwordHash,
        'securityStamp': securityStamp,
        'phoneNumber': phoneNumber,
        'concurrencyStamp': concurrencyStamp,
        'phoneNumberConfirmed': phoneNumberConfirmed,
        'twoFactorEnabled': twoFactorEnabled,
        'lockoutEnd': lockoutEnd,
        'lockoutEnabled': lockoutEnabled,
        'accessFailedCount': accessFailedCount,
      };

  DataProfileModel? get clone => DataProfileModel.fromJson(toJson());

  @override
  List<Object?> get props => [
        avatar,
        displayName,
        lastName,
        firstName,
        dateOfBirth,
        gender,
        phoneNumber,
        address,
        city,
        country
      ];
}

class DataToUpdate {
  String? refreshToken;
  String? refreshTokenExpiryTime;
  File? avatar;
  String? displayName;
  String? lastName;
  String? firstName;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? passport;
  String? identityCode;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String? lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  DataToUpdate(
      {this.refreshToken,
      this.refreshTokenExpiryTime,
      this.avatar,
      this.displayName,
      this.lastName,
      this.firstName,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.city,
      this.country,
      this.passport,
      this.identityCode,
      this.id,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed = true,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed = true,
      this.twoFactorEnabled = true,
      this.lockoutEnd,
      this.lockoutEnabled = true,
      this.accessFailedCount = 0});
}
