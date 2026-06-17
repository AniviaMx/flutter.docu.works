import 'package:flutter/material.dart';

import '../../core/firebase/firebase_bootstrap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.firebaseState});

  final FirebaseBootstrapResult? firebaseState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isConfigured = firebaseState?.isConfigured ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('DocuWorks'), centerTitle: false),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Gestiona documentos desde tu movil',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Base inicial lista para Android, iOS y servicios de Firebase.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _StatusPanel(isConfigured: isConfigured),
            const SizedBox(height: 20),
            const _NextStepsPanel(),
          ],
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.isConfigured});

  final bool isConfigured;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isConfigured
        ? const Color(0xFFE5F4EE)
        : const Color(0xFFFFF3D8);
    final foregroundColor = isConfigured
        ? const Color(0xFF176B4D)
        : const Color(0xFF8A5B00);

    return Card(
      elevation: 0,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isConfigured ? Icons.check_circle : Icons.info,
              color: foregroundColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isConfigured ? 'Firebase conectado' : 'Firebase pendiente',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isConfigured
                        ? 'La app ya puede iniciar Firebase al abrirse.'
                        : 'Ejecuta flutterfire configure cuando tengas tu proyecto en Firebase Console.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextStepsPanel extends StatelessWidget {
  const _NextStepsPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modulos preparados',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _ModuleRow(
              icon: Icons.lock_outline,
              title: 'Autenticacion',
              subtitle: 'firebase_auth esta listo para login y registro.',
              color: colorScheme.primary,
            ),
            const Divider(height: 24),
            _ModuleRow(
              icon: Icons.description_outlined,
              title: 'Documentos',
              subtitle: 'cloud_firestore esta listo para guardar metadatos.',
              color: colorScheme.secondary,
            ),
            const Divider(height: 24),
            _ModuleRow(
              icon: Icons.cloud_upload_outlined,
              title: 'Archivos',
              subtitle:
                  'firebase_storage esta listo para subir PDFs e imagenes.',
              color: colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(subtitle),
            ],
          ),
        ),
      ],
    );
  }
}
