import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/utilities/utils.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utilities/colors.dart';
import 'like_antimation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snapshot;
  const PostCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {



  bool isLikeAnimating = false;
  int commentsLength = 0;

  @override
  void initState() {
    
    super.initState();
    getComments();
  }

  void getComments()async{

    try{
QuerySnapshot snap =await FirebaseFirestore.instance.collection("posts").doc(widget.snapshot["postId"]).collection("comments").get();

commentsLength = snap.docs.length;


    }
    catch(e){
      showSnackBar(e.toString(), context);
    }

  }
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(context).getUser();
    return Container(
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16)
                .copyWith(right: 4),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snapshot['profImg']),
                  radius: 16,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snapshot['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'delete',
                              ]
                                  .map((e) => InkWell(
                                        onTap: () {
                                          FirestoreMethods().deletePost(widget.snapshot['postId']);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Text(e),
                                        ),
                                      ))
                                  .toList()),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                widget.snapshot['postId'],
                _user.uid,
                widget.snapshot['likes'],
              );

              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snapshot['photoURL'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snapshot['likes'].contains(_user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(
                          widget.snapshot['postId'],
                          _user.uid,
                          widget.snapshot['likes']);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: widget.snapshot['likes'].contains(_user.uid)
                          ? Colors.red
                          : Colors.white,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentScreen(
                              snap: widget.snapshot,
                            )));
                  },
                  icon: const Icon(
                    Icons.comment_outlined,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border,
                      )),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                    child: Text("${widget.snapshot['likes'].length} Likes",
                        style: Theme.of(context).textTheme.bodyText2)),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                              text: widget.snapshot['username'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "  " + widget.snapshot['description'],
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child:  Text("View all $commentsLength comments",
                        style: TextStyle(color: secondaryColor, fontSize: 16)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      DateFormat()
                          .add_yMMMd()
                          .format(widget.snapshot['datePublished'].toDate()),
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
