import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practical_task/providers/profile_provider.dart';
import 'package:practical_task/utils/string_utils.dart';
import 'package:practical_task/views/shared/appbar.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ref = Provider.of<ProfileProvider>(context, listen: false);
      ref.getProfile();
    });
  }

  profileInfoWidget() {
    var ref = Provider.of<ProfileProvider>(context, listen: true);
    return ref.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Image.network(
                          ref.profileDetails!.results.first.picture.large,
                          height: 160.0,
                          width: 160.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "${ref.profileDetails!.results.first.name.title} ${ref.profileDetails!.results.first.name.first} ${ref.profileDetails!.results.first.name.last}",
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "${DateFormat().add_yMMMd().add_jm().format(ref.profileDetails!.results.first.dob.date)} (DOB)",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            ref.profileDetails!.results.first.email,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  CupertinoIcons.calendar,
                                  color: Colors.black54,
                                  size: 20.0,
                                ),
                              ),
                              Text(
                                "Since ${DateTime.now().difference(ref.profileDetails!.results.first.registered.date).inDays} Days",
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                "${ref.profileDetails!.results.first.location.city}, ${ref.profileDetails!.results.first.location.country}",
                                style: const TextStyle(fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: StringUtils.profile,
        back: true,
      ),
      body: profileInfoWidget(),
    );
  }
}
