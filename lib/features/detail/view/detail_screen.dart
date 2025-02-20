import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:bilsoft_srlm/features/detail/cubit/detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  final StokEntity stok;

  const DetailScreen({super.key, required this.stok});

  static Route<void> route(StokEntity stok) {
    return MaterialPageRoute<void>(
      builder: (_) => DetailScreen(stok: stok),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(SharedPreferencesService(), stok.id),
      child: _DetailView(stok: stok),
    );
  }
}

class _DetailView extends StatelessWidget {
  final StokEntity stok;

  const _DetailView({required this.stok});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildStockStats(colorScheme),
                      const SizedBox(height: 16),
                      _buildRiskLimitCard(context, state, colorScheme),
                      _buildDetailsSection(colorScheme),
                      _buildPricingSection(colorScheme),
                      _buildAdditionalInfoSection(colorScheme),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(context, state),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar.large(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Hero(
          tag: 'stok_${stok.id}',
          child: Text(
            stok.ad,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockStats(ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildStatItem(
              icon: Icons.inventory,
              label: 'Bakiye',
              value: stok.bakiye.toString(),
              color: colorScheme.primary,
            ),
            _buildStatDivider(),
            _buildStatItem(
              icon: Icons.arrow_upward,
              label: 'Giriş',
              value: stok.giris.toString(),
              color: Colors.green,
            ),
            _buildStatDivider(),
            _buildStatItem(
              icon: Icons.arrow_downward,
              label: 'Çıkış',
              value: stok.cikis.toString(),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _buildRiskLimitCard(
    BuildContext context,
    DetailState state,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Text(
                  'Risk Limiti',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state is DetailLoaded)
              Text(
                '${state.riskLimit}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            if (state is DetailLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, DetailState state) {
    return FloatingActionButton.extended(
      onPressed: () => _showRiskLimitBottomSheet(context, state),
      icon: const Icon(Icons.edit),
      label: const Text('Risk Limitini Güncelle'),
    );
  }

  void _showRiskLimitBottomSheet(BuildContext context, DetailState state) {
    int currentLimit = (state is DetailLoaded) ? state.riskLimit : 0;
    final controller = TextEditingController(text: currentLimit.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<DetailCubit>(),
        child: Builder(
          builder: (bottomSheetContext) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Risk Limitini Güncelle',
                  style: Theme.of(bottomSheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Yeni Risk Limiti',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(bottomSheetContext),
                      child: const Text('İptal'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () async {
                        final newLimit = int.tryParse(controller.text) ?? 0;
                        await bottomSheetContext
                            .read<DetailCubit>()
                            .updateRiskLimit(newLimit);
                        if (context.mounted) {
                          Navigator.pop(bottomSheetContext);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, List<Widget> children, ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(ColorScheme colorScheme) {
    return _buildInfoCard(
      'Ürün Detayları',
      [
        _buildInfoRow('Barkod', stok.barkod),
        _buildInfoRow('Grup', stok.grup),
        _buildInfoRow('Birim', stok.birim),
        if (stok.stokRafi != null)
          _buildInfoRow('Raf', stok.stokRafi.toString()),
      ],
      colorScheme,
    );
  }

  Widget _buildPricingSection(ColorScheme colorScheme) {
    return _buildInfoCard(
      'Fiyatlandırma',
      [
        _buildInfoRow('Alış Fiyatı', '₺${stok.aFiyat.toStringAsFixed(2)}'),
        _buildInfoRow('Satış Fiyatı', '₺${stok.sFiyat.toStringAsFixed(2)}'),
        _buildInfoRow('KDV Oranı', '%${stok.kdvOran}'),
        _buildInfoRow('KDV Dahil', stok.kdvDahil),
      ],
      colorScheme,
    );
  }

  Widget _buildAdditionalInfoSection(ColorScheme colorScheme) {
    return _buildInfoCard(
      'Diğer Bilgiler',
      [
        _buildInfoRow('Kullanıcı', stok.kullaniciAdi),
        _buildInfoRow('Şube', stok.subeAdi),
      ],
      colorScheme,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
