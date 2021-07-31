import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pages_samples/social_media/models/post_model.dart';

class PostsCarousel extends StatelessWidget {
  final PageController pageController;
  final String title;
  final List<Post> posts;

  const PostsCarousel(
      {Key? key,
      required this.pageController,
      required this.title,
      required this.posts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Text(this.title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0))),
      Container(
          height: 400.0,
          child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: this.pageController,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPost(context, index);
              }))
    ]);
  }

  Widget _buildPost(BuildContext context, int index) {
    Post post = posts[index];

    return AnimatedBuilder(
      animation: this.pageController,
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (this.pageController.position.haveDimensions) {
          value = this.pageController.page! - index;
          value = (1 - (value.abs() * 0.25)).clamp(0.0, 1.0);
        }
        return Center(
            child: SizedBox(
                height: Curves.easeInOut.transform(value) * 400.0,
                child: child));
      },
      child: Stack(children: [
        Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0)
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                    height: 400.0,
                    width: 300.0,
                    image: AssetImage(post.imageUrl!),
                    fit: BoxFit.cover))),
        Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Container(
                padding: EdgeInsets.all(12.0),
                height: 110.0,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600)),
                      Text(post.location!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15.0)),
                      SizedBox(height: 6.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(CupertinoIcons.heart_fill,
                                  color: Colors.redAccent),
                              SizedBox(width: 6.0),
                              Text(post.likes.toString(),
                                  style: TextStyle(fontSize: 15.0))
                            ]),
                            Row(children: [
                              Icon(
                                CupertinoIcons.chat_bubble_fill,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 6.0),
                              Text(post.comments.toString(),
                                  style: TextStyle(fontSize: 15.0))
                            ])
                          ])
                    ])))
      ]),
    );
  }
}
