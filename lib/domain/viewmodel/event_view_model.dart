import 'package:bawo/data/core/view_state.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/data/repository/user_repository.dart';
import 'package:bawo/domain/viewmodel/base/base_view_model.dart';
import 'package:bawo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bawo/utils/string_extension.dart';
import '../../main.dart';

class EventViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();

  List<Article> recentArticles = [];
  List<Article> favoriteArticles = [];
  Set<int> favoriteIds = Set();
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;

  ViewState _eventsState = ViewState.Idle;
  ViewState get eventsState => _eventsState;

  String errorMessage = "";

    void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  Future<void> getRecentArticles() async {
    try {
      setViewState(ViewState.Loading);
      await Future.delayed(Duration(seconds: 5));
      final author = Author("Name", "avatar");
      var items = List<Article>.generate(20, (i) => Article(i, "$i Title", "date", "minRead", "imageArticle", false, markdownData, author, "2021-10-${i}T09:56:42.000Z".formatStringDateType3(), DateTime.now()));
      items.sort((a,b) => b.createdAt.compareTo(a.createdAt));
      recentArticles = items;
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  Future<void> getFavoriteArticles() async {
    try {
      favoriteArticles = await userRepository.getFavoriteArticles();
      favoriteArticles.forEach((element) {
        favoriteIds.add(element.id);
      });
      favoriteArticles.sort((a,b) => b.addedAt.compareTo(a.addedAt));
      notifyListeners();
    } catch (error) {
      setError(error.toString());
    }
  }


  void updateFavorite(Article article) {
      if(favoriteIds.contains(article.id)){
        favoriteIds.remove(article.id);
        article.addedAt = DateTime.now();
        userRepository.removeFavoriteArticle(article);
        Fluttertoast.showToast(
            msg: "Removed from Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Pallet.colorPrimary,
            textColor: Colors.white,
            fontSize: 12.0
        );
        getFavoriteArticles();
      } else {
        favoriteIds.add(article.id);
        article.addedAt = DateTime.now();
        userRepository.saveFavoriteArticle(article);
        Fluttertoast.showToast(
            msg: "Added to Favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Pallet.colorPrimary,
            textColor: Colors.white,
            fontSize: 12.0
        );
        getFavoriteArticles();
      }

      notifyListeners();
  }

}

final markdownData = """
---
__Advertisement :)__

- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
  resize in browser.
- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
  i18n with plurals support and easy syntax.

You will like those projects!

---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++


### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==


### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.


### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

:   Definition 1
with lazy continuation.

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
*here be dragons*
:::
""";