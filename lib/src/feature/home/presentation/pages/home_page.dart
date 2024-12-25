import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/feature/home/presentation/providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.welcome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildLanguageButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButtons(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LanguageButton(
          languageCode: 'TR',
          locale: Locale('tr'),
        ),
        SizedBox(width: 10),
        _LanguageButton(
          languageCode: 'EN',
          locale: Locale('en'),
        ),
        SizedBox(width: 10),
        _LanguageButton(
          languageCode: 'AR',
          locale: Locale('ar'),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String languageCode;
  final Locale locale;

  const _LanguageButton({
    required this.languageCode,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isSelected = localeProvider.locale == locale;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : null,
        foregroundColor: isSelected ? Colors.white : null,
      ),
      onPressed: () {
        localeProvider.setLocale(locale);
      },
      child: Text(languageCode),
    );
  }
}
