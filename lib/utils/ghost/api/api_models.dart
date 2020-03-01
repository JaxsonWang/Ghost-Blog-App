class PagesResponse {
  final List<PostPage> pages;
  final Meta meta;

  PagesResponse({this.pages, this.meta});

  factory PagesResponse.fromJson(Map<String, dynamic> json) {
    return PagesResponse(
      meta: Meta.fromJson(json['meta']),
      pages: json['pages']
          .map<PostPage>((postPageJson) => PostPage.fromJson(postPageJson))
          .toList(),
    );
  }
}

class PageResponse {
  final List<PostPage> pages;

  PageResponse({this.pages});

  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      pages: json['pages']
          .map<PostPage>((postPageJson) => PostPage.fromJson(postPageJson))
          .toList(),
    );
  }
}

class PostsResponse {
  final List<PostPage> posts;
  final Meta meta;

  PostsResponse({this.posts, this.meta});

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      meta: Meta.fromJson(json['meta']),
      posts: json['posts']
          .map<PostPage>((postPageJson) => PostPage.fromJson(postPageJson))
          .toList(),
    );
  }
}

class PostResponse {
  final List<PostPage> posts;

  PostResponse({this.posts});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      posts: json['posts']
          .map<PostPage>((postPageJson) => PostPage.fromJson(postPageJson))
          .toList(),
    );
  }
}

class AuthorsResponse {
  final List<Author> authors;
  final Meta meta;

  AuthorsResponse({this.authors, this.meta});

  factory AuthorsResponse.fromJson(Map<String, dynamic> json) {
    return AuthorsResponse(
      meta: Meta.fromJson(json['meta']),
      authors: json['authors']
          .map<Author>((authorJson) => Author.fromJson(authorJson))
          .toList(),
    );
  }
}

class AuthorResponse {
  final List<Author> authors;

  AuthorResponse({this.authors});

  factory AuthorResponse.fromJson(Map<String, dynamic> json) {
    return AuthorResponse(
      authors: json['authors']
          .map<Author>((authorJson) => Author.fromJson(authorJson))
          .toList(),
    );
  }
}

class TagsResponse {
  final List<Tag> tags;
  final Meta meta;

  TagsResponse({this.tags, this.meta});

  factory TagsResponse.fromJson(Map<String, dynamic> json) {
    return TagsResponse(
      meta: Meta.fromJson(json['meta']),
      tags: json['tags']
          .map<Tag>((authorJson) => Tag.fromJson(authorJson))
          .toList(),
    );
  }
}

class TagResponse {
  final List<Tag> tags;

  TagResponse({this.tags});

  factory TagResponse.fromJson(Map<String, dynamic> json) {
    return TagResponse(
      tags: json['tags'].map<Tag>((tagJson) => Tag.fromJson(tagJson)).toList(),
    );
  }
}

class SettingsResponse {
  final Settings settings;

  SettingsResponse({this.settings});

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
      settings: Settings.fromJson(json['settings']),
    );
  }
}

class Settings {
  final String title;
  final String description;
  final String logo;
  final String icon;
  final String coverImage;
  final String facebook;
  final String twitter;
  final String lang;
  final String timezone;
  final String ghostHead;
  final String ghostFoot;
  final List<NavigationItem> navigation;
  final String codeinjectionHead;
  final String codeinjectionFoot;

  Settings(
      {this.title,
      this.description,
      this.logo,
      this.icon,
      this.coverImage,
      this.facebook,
      this.twitter,
      this.lang,
      this.timezone,
      this.ghostHead,
      this.ghostFoot,
      this.navigation,
      this.codeinjectionHead,
      this.codeinjectionFoot});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      title: json['title'],
      description: json['description'],
      logo: json['logo'],
      icon: json['icon'],
      coverImage: json['cover_image'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      lang: json['lang'],
      timezone: json['timezone'],
      ghostHead: json['ghost_head'],
      ghostFoot: json['ghost_foot'],
      navigation: json['navigation'] != null
          ? json['navigation']
              .map<NavigationItem>((item) => NavigationItem.fromJson(item))
              .toList()
          : null,
      codeinjectionHead: json['codeinjection_head'],
      codeinjectionFoot: json['codeinjection_foot'],
    );
  }
}

class NavigationItem {
  final String label;
  final String url;

  NavigationItem({this.label, this.url});

  factory NavigationItem.fromJson(Map<String, dynamic> json) {
    return NavigationItem(
      label: json['label'],
      url: json['url'],
    );
  }
}

class PostPage {
  final String id;
  final String uuid;
  final String title;
  final String slug;
  final String html;
  final String commentId;
  final String featureImage;
  final bool featured;
  final bool page;
  final String metaTitle;
  final String metaDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String customExcerpt;
  final String codeinjectionHead;
  final String codeinjectionFoot;
  final String ogImage;
  final String ogTitle;
  final String ogDescription;
  final String twitterImage;
  final String twitterTitle;
  final String twitterDescription;
  final String customTemplate;
  final String canonicalUrl;
  final List<Tag> tags;
  final List<Author> authors;
  final Author primaryAuthor;
  final Tag primaryTag;
  final String url;
  final String excerpt;

  PostPage(
      {this.id,
      this.uuid,
      this.title,
      this.slug,
      this.html,
      this.commentId,
      this.featureImage,
      this.featured,
      this.page,
      this.metaTitle,
      this.metaDescription,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.customExcerpt,
      this.codeinjectionHead,
      this.codeinjectionFoot,
      this.ogImage,
      this.ogTitle,
      this.ogDescription,
      this.twitterImage,
      this.twitterTitle,
      this.twitterDescription,
      this.customTemplate,
      this.canonicalUrl,
      this.tags,
      this.authors,
      this.primaryAuthor,
      this.primaryTag,
      this.url,
      this.excerpt});

  factory PostPage.fromJson(Map<String, dynamic> json) {
    return PostPage(
      id: json['id'],
      uuid: json['uuid'],
      title: json['title'],
      slug: json['slug'],
      html: json['html'],
      commentId: json['comment_id'],
      featureImage: json['feature_image'],
      featured: json['featured'],
      page: json['page'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      publishedAt: DateTime.parse(json['published_at']),
      customExcerpt: json['custom_excerpt'],
      codeinjectionHead: json['codeinjection_head'],
      codeinjectionFoot: json['codeinjection_foot'],
      ogImage: json['og_image'],
      ogTitle: json['og_title'],
      ogDescription: json['og_description'],
      twitterImage: json['twitter_image'],
      twitterTitle: json['twitter_title'],
      twitterDescription: json['twitter_description'],
      customTemplate: json['custom_template'],
      canonicalUrl: json['canonical_url'],
      tags: json['tags'] != null
          ? json['tags'].map<Tag>((tagJson) => Tag.fromJson(tagJson)).toList()
          : null,
      authors: json['authors'] != null
          ? json['authors']
              .map<Author>((authorJson) => Author.fromJson(authorJson))
              .toList()
          : null,
      primaryAuthor: json['primary_author'] != null
          ? Author.fromJson(json['primary_author'])
          : null,
      primaryTag: json['primary_tag'] != null
          ? Tag.fromJson(json['primary_tag'])
          : null,
      url: json['url'],
      excerpt: json['excerpt'],
    );
  }
}

class Tag {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String featureImage;
  final String visibility;
  final String metaTitle;
  final String metaDescription;
  final String url;
  final Count count;

  Tag(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.featureImage,
      this.visibility,
      this.metaTitle,
      this.metaDescription,
      this.url,
      this.count});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      featureImage: json['feature_image'],
      visibility: json['visibility'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      url: json['url'],
      count: json['count'] != null ? Count.fromJson(json['count']) : null,
    );
  }
}

class Author {
  final String id;
  final String name;
  final String slug;
  final String profileImage;
  final String coverImage;
  final String bio;
  final String website;
  final String location;
  final String facebook;
  final String twitter;
  final String metaTitle;
  final String metaDescription;
  final String url;
  final Count count;

  Author(
      {this.id,
      this.name,
      this.slug,
      this.profileImage,
      this.coverImage,
      this.bio,
      this.website,
      this.location,
      this.facebook,
      this.twitter,
      this.metaTitle,
      this.metaDescription,
      this.url,
      this.count});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      profileImage: json['profile_image'],
      coverImage: json['cover_image'],
      bio: json['bio'],
      website: json['website'],
      location: json['location'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      url: json['url'],
      count: json['count'] != null ? Count.fromJson(json['count']) : null,
    );
  }
}

class Meta {
  final Pagination pagination;

  Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int pages;
  final int total;
  final int next;
  final int prev;

  Pagination(
      {this.page, this.limit, this.pages, this.total, this.next, this.prev});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      pages: json['pages'],
      total: json['total'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}

class Count {
  final int posts;

  Count({this.posts});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      posts: json['posts'],
    );
  }
}
