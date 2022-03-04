import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'modal.dart';

class ProfileCard extends StatelessWidget {
  Profile profile;

  ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: GestureDetector(
                  onTap: () => launch(profile.profilePicUrl),
                  child: Image(
                    image: NetworkImage(profile.profilePicUrl),
                  ),
                ),
              ),
              Text(
                '${profile.post}\nPosts',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              Text(
                '${profile.followers}\nFollowers',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              Text(
                '${profile.following}\nFollowing',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                profile.bio,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}

const textStyle = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
