import 'package:bawo/data/core/view_state.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/data/repository/user_repository.dart';
import 'package:bawo/domain/viewmodel/base/base_view_model.dart';
import 'package:bawo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bawo/utils/string_extension.dart';
import '../../main.dart';

class ArticleViewModel extends BaseViewModel {
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
      final items = await userRepository.getRecentArticles();
      items?.sort((a,b) => b.createdAt.compareTo(a.createdAt));
      recentArticles = items ?? [];
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