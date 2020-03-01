import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show Client;
import '../api/api_models.dart';

const _supportedVersions = ['v3'];

enum AuthorInclude {
  countPosts,
}

enum PostPageInclude {
  authors,
  tags,
}

enum TagInclude {
  countPosts,
}

class FilterExpression {
  final String property;
  final String operator;
  final String value;

  FilterExpression(
      {@required this.property, this.operator = '', @required this.value})
      : assert(property != null, "Property must not be null"),
        assert(operator != null, "Operator must not be null"),
        assert(value != null, "Value must not be null");
}

class GhostContentAPIClient {
  Client client = Client();

  final String url;
  final String version;
  final String contentAPIKey;
  final String ghostPath;

  GhostContentAPIClient({
    Key key,
    @required this.url,
    @required this.version,
    @required this.contentAPIKey,
    this.ghostPath = 'ghost',
  })  : assert(url != null, "URL must not be null"),
        assert(url.startsWith("https://"), "URL must start with https://"),
        assert(!url.endsWith("/"), "URL must not end with /"),
        assert(!ghostPath.startsWith("/") && !ghostPath.endsWith("/"),
            "Ghost Path cannot start or end with /"),
        // todo asset key regex
        assert(version != null && _supportedVersions.contains(version));

  Future<PostsResponse> getPosts({
    List<PostPageInclude> includes,
    List<FilterExpression> filters,
    int limit = 15,
    int page = 1,
  }) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/posts?key=$contentAPIKey&limit=$limit&page=$page';
    endpoint = _appendPostPageIncludes(endpoint, includes);
    endpoint = _appendFilters(endpoint, filters);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PostsResponse.fromJson(body);
    }

    throw Exception('Failed to get posts');
  }

  Future<PostResponse> getPostById(String id,
      {List<PostPageInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/posts/$id/?key=$contentAPIKey';
    endpoint = _appendPostPageIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PostResponse.fromJson(body);
    }

    throw Exception('Failed to get post');
  }

  Future<PostResponse> getPostBySlug(String slug,
      {List<PostPageInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/posts/slug/$slug/?key=$contentAPIKey';
    endpoint = _appendPostPageIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PostResponse.fromJson(body);
    }

    throw Exception('Failed to get post');
  }

  Future<AuthorsResponse> getAuthors({List<AuthorInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/authors?key=$contentAPIKey';
    endpoint = _appendAuthorIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return AuthorsResponse.fromJson(body);
    }

    throw Exception('Failed to get authors');
  }

  Future<AuthorResponse> getAuthorById(String id,
      {List<AuthorInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/authors/$id/?key=$contentAPIKey';
    endpoint = _appendAuthorIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return AuthorResponse.fromJson(body);
    }

    throw Exception('Failed to get author');
  }

  Future<AuthorResponse> getAuthorBySlug(String slug,
      {List<AuthorInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/authors/slug/$slug/?key=$contentAPIKey';
    endpoint = _appendAuthorIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return AuthorResponse.fromJson(body);
    }

    throw Exception('Failed to get author');
  }

  Future<TagsResponse> getTags({List<TagInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/tags?key=$contentAPIKey';
    endpoint = _appendTagIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return TagsResponse.fromJson(body);
    }

    throw Exception('Failed to get tags');
  }

  Future<TagResponse> getTagById(String id, {List<TagInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/tags/$id/?key=$contentAPIKey';
    endpoint = _appendTagIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return TagResponse.fromJson(body);
    }

    throw Exception('Failed to get tag');
  }

  Future<TagResponse> getTagBySlug(String slug,
      {List<TagInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/tags/slug/$slug/?key=$contentAPIKey';
    endpoint = _appendTagIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return TagResponse.fromJson(body);
    }

    throw Exception('Failed to get tag');
  }

  Future<PagesResponse> getPages({List<PostPageInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/pages?key=$contentAPIKey';
    endpoint = _appendPostPageIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PagesResponse.fromJson(body);
    }

    throw Exception('Failed to get pages');
  }

  Future<PageResponse> getPageById(String id,
      {List<PostPageInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/pages/$id/?key=$contentAPIKey';
    endpoint = _appendPostPageIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PageResponse.fromJson(body);
    }

    throw Exception('Failed to get page');
  }

  Future<PageResponse> getPageBySlug(String slug,
      {List<PostPageInclude> includes}) async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/pages/slug/$slug/?key=$contentAPIKey';
    endpoint = _appendPostPageIncludes(endpoint, includes);

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return PageResponse.fromJson(body);
    }

    throw Exception('Failed to get page');
  }

  Future<SettingsResponse> getSettings() async {
    String endpoint =
        '$url/$ghostPath/api/$version/content/settings?key=$contentAPIKey';

    final response = await client.get(endpoint);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return SettingsResponse.fromJson(body);
    }

    throw Exception('Failed to get settings');
  }

  String _appendPostPageIncludes(
      String endpoint, List<PostPageInclude> includes) {
    if (includes != null && includes.length > 0) {
      endpoint += '&include=';
      endpoint += includes
          .map((include) => include
              .toString()
              .toLowerCase()
              .replaceAll('postpageinclude.', ''))
          .join(',');
    }
    return endpoint;
  }

  String _appendAuthorIncludes(String endpoint, List<AuthorInclude> includes) {
    if (includes != null && includes.length > 0) {
      // there's only one enum value right now
      endpoint += '&include=count.posts';
    }
    return endpoint;
  }

  String _appendTagIncludes(String endpoint, List<TagInclude> includes) {
    if (includes != null && includes.length > 0) {
      // there's only one enum value right now
      endpoint += '&include=count.posts';
    }
    return endpoint;
  }

  String _appendFilters(String endpoint, List<FilterExpression> filters) {
    if (filters != null) {
      for (int i = 0; i < filters.length; ++i) {
        FilterExpression filter = filters[i];
        endpoint +=
            '&filter=' + filter.property + ':' + filter.operator + filter.value;
      }
    }
    return endpoint;
  }
}
