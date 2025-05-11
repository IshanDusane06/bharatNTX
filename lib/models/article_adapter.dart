import 'package:hive/hive.dart';
import 'article.dart';

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 0;

  @override
  Article read(BinaryReader reader) {
    final map = reader.readMap();
    return Article(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      userId: map['userId'] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer.writeMap({
      'id': obj.id,
      'title': obj.title,
      'body': obj.body,
      'userId': obj.userId,
    });
  }
}
