import 'package:flutter/material.dart';

import '../../../core/firebase/firebase_bootstrap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.firebaseState});

  final FirebaseBootstrapResult? firebaseState;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberSession = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Autenticacion pendiente de conectar con Firebase.'),
      ),
    );
  }

  void _showPendingMessage(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action estara disponible proximamente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              children: [
                _Header(colorScheme: colorScheme),
                const SizedBox(height: 28),
                _FirebaseStatusBanner(firebaseState: widget.firebaseState),
                const SizedBox(height: 16),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Inicia sesion',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Entra a tu espacio de documentos.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 22),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            decoration: const InputDecoration(
                              labelText: 'Correo electronico',
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => _submit(),
                            decoration: InputDecoration(
                              labelText: 'Contrasena',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _obscurePassword
                                    ? 'Mostrar contrasena'
                                    : 'Ocultar contrasena',
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberSession,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberSession = value ?? true;
                                  });
                                },
                              ),
                              const Expanded(child: Text('Recordar sesion')),
                              TextButton(
                                onPressed: () =>
                                    _showPendingMessage('Recuperar contrasena'),
                                child: const Text('Olvide mi contrasena'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ElevatedButton.icon(
                            onPressed: _submit,
                            icon: const Icon(Icons.login),
                            label: const Text('Entrar'),
                          ),
                          const SizedBox(height: 14),
                          OutlinedButton(
                            onPressed: () => _showPendingMessage('Registro'),
                            child: const Text('Crear cuenta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Ingresa tu correo.';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Ingresa un correo valido.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Ingresa tu contrasena.';
    }
    if (password.length < 6) {
      return 'Usa al menos 6 caracteres.';
    }
    return null;
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.description_outlined,
            color: colorScheme.onPrimary,
            size: 30,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'DocuWorks',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tu app movil para consultar, organizar y proteger documentos.',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _FirebaseStatusBanner extends StatelessWidget {
  const _FirebaseStatusBanner({required this.firebaseState});

  final FirebaseBootstrapResult? firebaseState;

  @override
  Widget build(BuildContext context) {
    final status = firebaseState;
    final isChecking = status == null;
    final isConfigured = status?.isConfigured ?? false;
    final colorScheme = Theme.of(context).colorScheme;
    final Color backgroundColor;
    final Color foregroundColor;
    final IconData icon;
    final String text;

    if (isChecking) {
      backgroundColor = const Color(0xFFEAF0F6);
      foregroundColor = const Color(0xFF415466);
      icon = Icons.sync;
      text = 'Comprobando Firebase...';
    } else if (isConfigured) {
      backgroundColor = const Color(0xFFE5F4EE);
      foregroundColor = const Color(0xFF176B4D);
      icon = Icons.check_circle_outline;
      text = 'Firebase esta configurado.';
    } else {
      backgroundColor = const Color(0xFFFFF3D8);
      foregroundColor = const Color(0xFF8A5B00);
      icon = Icons.info_outline;
      text = 'Firebase aun no esta configurado.';
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: foregroundColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
