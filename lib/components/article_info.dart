import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qiita_app/data/article.dart';
import 'package:intl/intl.dart';

class ArticleInfo extends StatelessWidget {
  const ArticleInfo({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final createdAt = dateFormat.format(DateTime.parse(article.createdAt));
    final userName =
        article.userName.isNotEmpty ? article.userName : "@${article.userId}";
    return SizedBox(
      height: 148,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(4),
          Row(
            children: [
              _UserIcon(imageUrl: article.userImageUrl),
              const Gap(4),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 16,
                        ),
                        Text(article.likesCount.toString()),
                        const Gap(16),
                        Text("createdAt: $createdAt"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            article.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(article.tags.take(3).join(","), maxLines: 1),
        ],
      ),
    );
  }
}

class _UserIcon extends StatelessWidget {
  const _UserIcon({required this.imageUrl});
  final String imageUrl;

  static const double size = 48;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.fitHeight,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error_outline, size: size, color: Colors.red),
      ),
    );
  }
}
