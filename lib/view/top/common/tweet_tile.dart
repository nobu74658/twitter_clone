import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TweetTile extends StatelessWidget {
  const TweetTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black12),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leftSide(),
          const SizedBox(width: 10),
          _rightSide(),
        ],
      ),
    );
  }

  _leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(
          Icons.favorite,
          color: Colors.grey,
          size: 16,
        ),
        const SizedBox(height: 6),
        CircleAvatar(
          radius: 18,
          backgroundImage:
              CachedNetworkImageProvider("https://placehold.jp/150x150.png"),
        ),
      ],
    );
  }

  _rightSide() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "hirokiさんがいいねしました",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          _postInfoPart(),
          const SizedBox(height: 2),
          Text(
            "hogehhogweogihwohg" * 100,
            maxLines: 10,
            softWrap: true,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 6),
          _likePart(),
        ],
      ),
    );
  }

  _postInfoPart() {
    return Row(
      children: [
        Text(
          "hirokiappdev",
        ),
        Text("2022/02/18 15:10"),
      ],
    );
  }

  _likePart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.favorite_border_outlined,
          size: 16,
        ),
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 16,
        ),
        Text(
          "492",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
