import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/screens/Questions/Pages.dart';
import 'package:guide_shark/screens/Results.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:guide_shark/services/ApiService.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'package:guide_shark/core/Questions.dart';
import 'package:guide_shark/common/widgets/BottomNavbar.dart';
import 'package:guide_shark/data/MedicalData.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';
import 'package:guide_shark/data/MedicalDataState.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  MedicalDataCubit _createCubit(BuildContext context) {
    final cubit = MedicalDataCubit();
    final initialPages = Questions.getQuestions(cubit);

    cubit.emit(cubit.state.copyWith(pages: initialPages));
    return cubit;
  }

  void _pageControllerListener(BuildContext context, MedicalDataState state) {
    if (_pageController.hasClients && _pageController.page != state.currentPageIndex) {
      _pageController.jumpToPage(state.currentPageIndex);
    }
  }

  Widget _buildContent(BuildContext context, MedicalDataState state) {
    final cubit = context.read<MedicalDataCubit>();

    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: Pages.buildPages(context, state, _pageController, cubit)),
            _buildNavigationButtons(context, state),
          ],
        ),
        if (isLoading) Container(color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, MedicalDataState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildBackButton(context, state), _buildNextOrSubmitButton(context, state)],
    );
  }

  Widget _buildBackButton(BuildContext context, MedicalDataState state) {
    final cubit = context.read<MedicalDataCubit>();
    return ElevatedButton(
      onPressed:
          isLoading
              ? null
              : state.currentPageIndex > 0
              ? () => _navigateToPreviousPage(cubit)
              : null,
      child: const Text('<'),
    );
  }

  Widget _buildNextOrSubmitButton(BuildContext context, MedicalDataState state) {
    final cubit = context.read<MedicalDataCubit>();
    final isLastPage = state.currentPageIndex >= state.pages.length - 1;

    return ElevatedButton(
      onPressed:
          isLoading
              ? null
              : isLastPage
              ? () => _handleFormSubmission(context, cubit)
              : () => _navigateToNextPage(cubit),
      child: Text(isLastPage ? 'Submit' : '>'),
    );
  }

  void _navigateToPreviousPage(MedicalDataCubit cubit) {
    cubit.previousPage();
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _navigateToNextPage(MedicalDataCubit cubit) {
    cubit.nextPage();
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> _handleFormSubmission(BuildContext context, MedicalDataCubit cubit) async {
    final finalData = cubit.getFormData();
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _apiService.submitMedicalData(finalData);

      setState(() {
        isLoading = false;
      });

      print(response);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Form Submitted!'), backgroundColor: Colors.green));

      Navigator.push(context, MaterialPageRoute(builder: (context) => Results(diagnosis: response)));
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: AppStyles.paddingScreen,
              child: BlocConsumer<MedicalDataCubit, MedicalDataState>(
                listener: _pageControllerListener,
                builder: _buildContent,
              ),
            ),
            // bottomNavigationBar: BottomNavbar.bottomNavigationBar,
          );
        },
      ),
    );
  }
}
