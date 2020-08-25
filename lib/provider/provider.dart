import 'package:logisticstrackerapp/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => AuthServices()),
];
