import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:flutter/material.dart';
import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/features/detail/cubit/detail_cubit.dart';
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
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Stok Detay'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                _buildStockStats(),
                _buildRiskLimitSection(context, state),
                _buildDetailsCard(),
                _buildPricingCard(),
                _buildAdditionalInfo(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stok.ad,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kod: ${stok.kod}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildStockStats() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'Bakiye',
              value: stok.bakiye.toString(),
              icon: Icons.inventory,
            ),
          ),
          Expanded(
            child: _StatCard(
              title: 'Giriş',
              value: stok.giris.toString(),
              icon: Icons.arrow_upward,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: _StatCard(
              title: 'Çıkış',
              value: stok.cikis.toString(),
              icon: Icons.arrow_downward,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskLimitSection(BuildContext context, DetailState state) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Risk Limiti',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showRiskLimitDialog(context, state),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (state is DetailLoaded)
              Text('Mevcut Risk Limiti: ${state.riskLimit}'),
            if (state is DetailLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  void _showRiskLimitDialog(BuildContext context, DetailState state) {
    int currentLimit = (state is DetailLoaded) ? state.riskLimit : 0;
    final controller = TextEditingController(text: currentLimit.toString());

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Risk Limiti Güncelle'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Yeni Risk Limiti',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              final newLimit = int.tryParse(controller.text) ?? 0;
              context.read<DetailCubit>().updateRiskLimit(newLimit);
              Navigator.pop(dialogContext);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ürün Detayları',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DetailRow(title: 'Barkod', value: stok.barkod),
            DetailRow(title: 'Grup', value: stok.grup),
            DetailRow(title: 'Birim', value: stok.birim),
            if (stok.stokRafi != null)
              DetailRow(title: 'Raf', value: stok.stokRafi.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fiyatlandırma',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DetailRow(
                title: 'Alış Fiyatı',
                value: '₺${stok.aFiyat.toStringAsFixed(2)}'),
            DetailRow(
                title: 'Satış Fiyatı',
                value: '₺${stok.sFiyat.toStringAsFixed(2)}'),
            DetailRow(title: 'KDV Oranı', value: '%${stok.kdvOran}'),
            DetailRow(title: 'KDV Dahil', value: stok.kdvDahil),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Diğer Bilgiler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DetailRow(title: 'Kullanıcı', value: stok.kullaniciAdi),
            DetailRow(title: 'Şube', value: stok.subeAdi),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon,
                color: color ?? Theme.of(context).primaryColor, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
