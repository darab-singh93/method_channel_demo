import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:practical_task/models/profile_details.dart';
import 'package:practical_task/models/random_image.dart';
import 'package:practical_task/services/http_service.dart';
import 'package:practical_task/services/web_service.dart';
import 'http_service_test.mocks.dart';


class MockMethodChannel extends Mock implements MethodChannel {}

@GenerateMocks([http.Client])

void main() {
  group('HttpService', () {
    final client = MockClient();
    late HttpService httpService = HttpService(httpClient: client);

    test('callProfileDetails returns ProfileDetails on success', () async {
      String mockJsonStr = '{"results":[{"gender":"female","name":{"title":"Ms","first":"Mila","last":"Garcia"},"location":{"street":{"number":8960,"name":"Rue des Jardins"},"city":"Amiens","state":"Seine-et-Marne","country":"France","postcode":50507,"coordinates":{"latitude":"-18.3706","longitude":"128.0772"},"timezone":{"offset":"-2:00","description":"Mid-Atlantic"}},"email":"mila.garcia@example.com","login":{"uuid":"c5c6eb0d-7d4b-4b5a-96f5-175d8c8ca814","username":"goldenbutterfly533","password":"video","salt":"ZsRTvOux","md5":"d1a98cd56d1f31113d50ba9691701cb7","sha1":"3b50a325b0ee072dd5e821efa176701861f3c209","sha256":"82a9dbf88773bfa5a1d22c5cf6ce5904e7e4297c3f1641395e897a861eecf2f6"},"dob":{"date":"1965-10-05T17:29:09.245Z","age":57},"registered":{"date":"2019-03-07T02:05:30.186Z","age":4},"phone":"04-57-65-02-67","cell":"06-44-61-31-66","id":{"name":"INSEE","value":"2650919728434 68"},"picture":{"large":"https://randomuser.me/api/portraits/women/50.jpg","medium":"https://randomuser.me/api/portraits/med/women/50.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/50.jpg"},"nat":"FR"}],"info":{"seed":"47ff39542156d1b2","results":1,"page":1,"version":"1.4"}}';
      when(client
          .get(Uri.parse(WebService.profile)))
          .thenAnswer((_) async =>
          http.Response(mockJsonStr, 200));
      // Act
      final result = await httpService.callProfileDetails();
      // Assert
      expect(result, isA<ProfileDetails>());
    });

    test('callRandomImage returns RandomImage on success', () async {

      String mockJsonStr = '{"message":"https:\/\/images.dog.ceo\/breeds\/briard\/n02105251_7056.jpg","status":"success"}';
      when(client
          .get(Uri.parse(WebService.randomImage)))
          .thenAnswer((_) async =>
          http.Response(mockJsonStr, 200));
      // Act
      final result = await httpService.callRandomImage();
      // Assert
      expect(result, isA<RandomImage>());
    });
  });
}

