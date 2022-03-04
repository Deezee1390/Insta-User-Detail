import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_followers/profile_card.dart';

import 'modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool isProfile = false;
  dynamic profile;

  Future<List> getRequest(value) async {
    var url = Uri.parse('https://www.instagram.com/$value/?__a=1');

    final response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    String bio = json['graphql']['user']['biography'];
    String profilePicUrl = json['graphql']['user']['profile_pic_url_hd'];
    String followers = json['graphql']['user']['edge_followed_by']['count'];
    String following = json['graphql']['user']['edge_follow']['count'];
    String post =
        json['graphql']['user']['edge_owner_to_timeline_media']['count'];

    return [bio, profilePicUrl, followers, following, post];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insta Follower'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.url,
            onSubmitted: (value) {
              if (value != null) {
                getRequest(value).then((profiles) {
                  profile = profile(profiles[0], profiles[1], profiles[2],
                      profiles[4], profiles[3]);
                  setState(() {
                    isProfile = true;
                  });
                });
              } else {}
            },
          ),
          GestureDetector(
            onTap: () {
              if (_controller.text != null) {
                getRequest(_controller.text).then((profiles) {
                  profile = profile(profiles[0], profiles[1], profiles[2],
                      profiles[4], profiles[3]);
                  setState(() {
                    isProfile = true;
                  });
                });
              } else {
                profile = profile('-', 0, 0, 0, '');
              }
            },
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
          ),
          isProfile ? ProfileCard(profile: profile) : Container(),
        ],
      ),
    );
  }
}
