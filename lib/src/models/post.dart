import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
part 'post.g.dart';
part 'post.serializer.g.dart';

@serializable
abstract class _PostInfo extends Model {
  static final DateFormat _fmt = new DateFormat.yMMMMd();

  @required
  String get title;

  @required
  String get description;

  String get stub;

  List<String> get categories;

  String get htmlContent;

  String get dateString => _fmt.format(createdAt);
}
