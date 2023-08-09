import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.sourceName,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${news.author}: ",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: news.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage,
                  imageBuilder: (context, imageProvider) => SizedBox(
                    width: double.infinity,
                    height: 210,
                    child: Image.network(
                      news.urlToImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SizedBox(
                    width: double.infinity,
                    height: 210,
                    child: Image.network(
                      'https://st3.depositphotos.com/3223379/13698/i/600/depositphotos_136985036-stock-photo-words-news-on-digital-blue.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                "By ${news.sourceName}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Posted on ${Methods.convertDateHour(news.publishedAt)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  news.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  news.content,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              InkWell(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "full news at ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: news.url,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => launchUrl(Uri.parse(news.url)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
