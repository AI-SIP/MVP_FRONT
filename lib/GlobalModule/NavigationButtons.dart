import 'package:flutter/material.dart';
import 'package:mvp_front/Provider/ProblemsProvider.dart';
import '../Screen/ProblemDetailScreen.dart';

class NavigationButtons extends StatelessWidget {
  final BuildContext context;
  final ProblemsProvider provider;
  final int currentId;

  const NavigationButtons({
    required this.context,
    required this.provider,
    required this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    final problemIds = provider.getProblemIds();
    int currentIndex = problemIds.indexOf(currentId);
    int previousProblemId =
        currentIndex > 0 ? problemIds[currentIndex - 1] : problemIds.last;
    int nextProblemId = currentIndex < problemIds.length - 1
        ? problemIds[currentIndex + 1]
        : problemIds.first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () =>
              navigateToProblem(context, provider, previousProblemId),
          child: Text('이전 문제'),
        ),
        ElevatedButton(
          onPressed: () => navigateToProblem(context, provider, nextProblemId),
          child: Text('다음 문제'),
        ),
      ],
    );
  }

  void navigateToProblem(
      BuildContext context, ProblemsProvider provider, int newProblemId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ProblemDetailScreen(problemId: newProblemId)),
    );
  }
}