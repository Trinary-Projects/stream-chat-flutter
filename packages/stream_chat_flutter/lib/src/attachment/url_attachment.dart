import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// Widget to display URL attachment
class UrlAttachment extends StatelessWidget {
  /// Constructor for creating a [UrlAttachment]
  const UrlAttachment({
    Key? key,
    required this.urlAttachment,
    required this.hostDisplayName,
    required this.messageTheme,
    this.textPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  }) : super(key: key);

  /// Attachment to be displayed
  final Attachment urlAttachment;

  /// Host name
  final String hostDisplayName;

  /// Padding for text
  final EdgeInsets textPadding;

  /// [MessageThemeData] for showing image title
  final MessageThemeData messageTheme;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = StreamChatTheme.of(context);
    return GestureDetector(
      onTap: () {
        final titleLink = urlAttachment.titleLink;
        if (titleLink != null) launchURL(context, titleLink);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (urlAttachment.imageUrl != null)
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: urlAttachment.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    bottom: -1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                        ),
                        color: messageTheme.linkBackgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 8,
                          right: 8,
                        ),
                        child: Text(
                          hostDisplayName,
                          style: chatThemeData.textTheme.bodyBold.copyWith(
                            color: messageTheme.messageLinksStyle?.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
