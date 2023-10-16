# flutter
preranut flutter database



  /// return url link string
  static String urlLink(String text, RegExpMatch match) =>
      text.substring(match.start, match.end);
  

  /// Split text message into substring and categorize sub-string by message
  /// or url type.
  static List<Tuple2<String, TextMessageType>> separateTextMessage({
    required String inputTextMessage,
  }) {
    final exp = RegExp(ChatConstants.urlRegex);
    var tempInput = inputTextMessage;
    final urlMatchesLength = exp.allMatches(inputTextMessage).toList().length;
    const startStringIndex = 0;
    final stringList = <Tuple2<String, TextMessageType>>[];

    /// no url is found returns normal message type
    if (urlMatchesLength == 0) {
      stringList.add(
        Tuple2(inputTextMessage, TextMessageType.normalText),
      );
      return stringList;
    }

    for (var i = 0; i < urlMatchesLength; i++) {
      var normalText = '';
      var linkText = '';
      final urlMatches = exp.allMatches(tempInput).toList();

      /// case find only single url without normal text.
      if (urlMatches.length == 1) {
        final urlMatches = exp.allMatches(tempInput).toList();
        if (tempInput.substring(urlMatches.first.start, urlMatches.first.end) ==
            tempInput) {
          stringList.add(
            Tuple2(tempInput, TextMessageType.link),
          );
          return stringList;
        }
      }

      /// case normal text is in front of url
      if (startStringIndex < urlMatches.first.start) {
        normalText = tempInput.substring(
          startStringIndex,
          urlMatches.first.start,
        );
        linkText = urlLink(tempInput, urlMatches.first);
        if (normalText.isNotEmpty) {
          stringList.add(Tuple2(normalText, TextMessageType.normalText));
        }
        stringList.add(
          Tuple2(linkText, validateLinkType(linkText)),
        );
        tempInput = tempInput.substring(
          urlMatches.first.end,
          tempInput.length,
        );
        continue;
      }

      /// case url is in front of normal text
      else {
        linkText = urlLink(tempInput, urlMatches.first);
        normalText = tempInput.substring(
          urlMatches.first.end,
          i < urlMatchesLength ? urlMatches[1].start : tempInput.length,
        );
        stringList.add(Tuple2(linkText, validateLinkType(linkText)));

        if (normalText.isNotEmpty) {
          stringList.add(Tuple2(normalText, TextMessageType.normalText));
        }
        if (normalText.trim().isEmpty) {
          tempInput = tempInput.substring(linkText.length + normalText.length);
          continue;
        } else {
          tempInput = tempInput.substring((linkText + normalText).length - 1);
          continue;
        }
      }
    }

    /// fix when total substring count is odd number
    if (tempInput.isNotEmpty) {
      stringList.add(
        Tuple2(tempInput, TextMessageType.normalText),
      );
    }
    return stringList;
  }
