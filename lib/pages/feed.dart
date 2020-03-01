import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/ghost_api.dart';
import '../pages/post.dart';
import '../widgets/drawer.dart';

class FeedPage extends StatefulWidget {

  static final String route = '/';

  @override
  State createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  bool _isLoading = false;

  ScrollController _controller;
  List<PostPage> _posts = <PostPage>[];
  bool _initialLoad = false;
  int _maxPosts = 99999;
  int _filterMaxPosts = 99999;

  Tag _filterTag;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchNextPage();
    });
    _controller = ScrollController()..addListener(_scrollListener);
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  bool _allPostsLoaded() {
    return _posts.length >= _filterMaxPosts;
  }

  void _fetchNextPage() async {
    if (!_allPostsLoaded()) {
      setState(() {
        _isLoading = true;
      });

      final List<PostPageInclude> _includes = [PostPageInclude.authors, PostPageInclude.tags];
      final int _limit = 5;
      final GhostContentAPIClient client = GhostContentAPIProvider.of(context);
      final List<FilterExpression> _filters = List<FilterExpression>();

      if (_filterTag != null) {
        _filters.add(FilterExpression(property: "tags", value: _filterTag.slug));
      }

      PostsResponse response = await client.getPosts(includes: _includes, page: _page, limit: _limit, filters: _filters);

      setState(() {
        if (!_initialLoad) {
          _maxPosts = response.meta.pagination.total;
        }

        _initialLoad = true;
        _posts.addAll(response.posts);
        _filterMaxPosts = response.meta.pagination.total;
        _page++;
        _isLoading = false;
      });
    }
  }

  void _loadTag(Tag tag) {
    setState(() {
      _page = 1;
      _posts = <PostPage>[];
      _filterTag = tag;
    });
    _fetchNextPage();
  }

  void _showFilters(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: GhostContentAPIProvider.of(context).getTags(includes: [TagInclude.countPosts]),
          builder: (BuildContext context, AsyncSnapshot<TagsResponse> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("筛选失败，请稍后再重试！"),
              );
            }

            if (snapshot.hasData) {
              List<Tag> tags = snapshot.data.tags;

              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("全部文章"),
                    subtitle: Text("共有 " + _maxPosts.toString() + " 篇文章",),
                    onTap: () {
                      _loadTag(null);
                      Navigator.pop(context);
                    },
                  ),

                  Divider(),

                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: tags.length,
                    itemBuilder: (BuildContext context, int index) {
                      Tag tag = tags[index];
                      return ListTile(
                        title: Text(tag.name),
                        subtitle: Text("该目录下有 " + tag.count.posts.toString() + " 篇文章"),
                        onTap: () {
                          _loadTag(tag);
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Widget _buildEndOfFeedWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0,),
      child: Center(
        child: Text(
          "没有更多内容！",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      height: 100,
      child: _isLoading ? Center(child: CircularProgressIndicator(),) : Container(),
    );
  }

  Widget _buildFilterHeading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0,),
      child: Column(
        children: <Widget>[
          Text(
            _filterTag.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2,
          ),

          SizedBox(height: 6.0,),

          Text(
            "该目录下有 " + _filterTag.count.posts.toString() + " 篇文章",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }

  Widget _buildPost(BuildContext context, PostPage post) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Post(post: post);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0,),
              child: Text(post.title, style: Theme.of(context).textTheme.title,),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20.0,),
              child: Row(
                children: <Widget>[
                  Text(post.primaryTag.name + " | " + DateFormat('yyyy-MM-dd').format(post.publishedAt)),
                ],
              ),
            ),

            Text(post.excerpt + "..."),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, FeedPage.route),
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  _showFilters(context);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "淮城一只猫",
                  style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1.0, 1.0), blurRadius: 1.0,),
                      ]
                  ),
                ),
                centerTitle: true,
                background: Image.asset(
                  'assets/img/abstract.jpg',
                  fit: BoxFit.cover,
                ),
              ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _filterTag == null ? Container() : _buildFilterHeading(),

                ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildPost(context, _posts[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),

                _allPostsLoaded()
                    ? _buildEndOfFeedWidget()
                    : _buildLoadingWidget(),
              ]
            ),
          )
        ],
      )
    );
  }
}
