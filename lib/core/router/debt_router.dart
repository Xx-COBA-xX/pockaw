import 'package:go_router/go_router.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/debt/presentation/screens/debt_details_screen.dart';
import 'package:pockaw/features/debt/presentation/screens/debt_form_screen.dart';
import 'package:pockaw/features/debt/presentation/screens/debt_screen.dart';

class DebtRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.debtList,
      builder: (context, state) => const DebtScreen(),
    ),
    GoRoute(
      path: '${Routes.debtDetails}/:debtId',
      builder: (context, state) {
        final debtId =
            int.tryParse(state.pathParameters['debtId'] ?? '') ?? 0;
        return DebtDetailsScreen(debtId: debtId);
      },
    ),
    GoRoute(
      path: '${Routes.debtForm}/edit/:debtId',
      builder: (context, state) {
        final debtId = int.tryParse(state.pathParameters['debtId'] ?? '');
        return DebtFormScreen(debtId: debtId);
      },
    ),
    GoRoute(
      path: Routes.debtForm,
      builder: (context, state) => const DebtFormScreen(),
    ),
  ];
}
