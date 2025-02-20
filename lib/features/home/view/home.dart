import 'package:bilsoft_srlm/features/detail/view/detail_screen.dart';
import 'package:bilsoft_srlm/features/home/cubit/home_cubit.dart';
import 'package:bilsoft_srlm/features/home/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            HomeLoaded() => ResponsiveLayout(
                mobile: _buildMobileLayout(context, state),
                tablet: _buildTabletLayout(context, state),
              ),
            HomeError() => Center(
                child: Text(state.message),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, HomeLoaded state) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildSliverAppBar(context, state),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildSearchBar(context, state),
              _buildQuickStats(state),
              _buildMonitoringBar(state),
            ],
          ),
        ),
        _buildStockGrid(state),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, HomeLoaded state) {
    return Row(
      children: [
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 48),
              _buildSearchBar(context, state),
              const SizedBox(height: 24),
              _buildQuickStats(state),
              const SizedBox(height: 24),
              _buildMonitoringBar(state),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(context, state),
              _buildStockGrid(state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context, HomeLoaded state) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Stok Takip',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<HomeCubit>().getStokList(),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildQuickStats(HomeLoaded state) {
    final totalStocks = state.stokList.length;
    final riskliStoklar = state.stokList.where((stok) {
      final kalan = stok.giris - stok.cikis;
      return kalan <= (stok.riskLimit ?? 0);
    }).length;
    final guvenliStoklar = totalStocks - riskliStoklar;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hızlı Bakış',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Toplam',
                  value: totalStocks.toString(),
                  color: Colors.blue,
                  icon: Icons.inventory,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  title: 'Güvenli',
                  value: guvenliStoklar.toString(),
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  title: 'Riskli',
                  value: riskliStoklar.toString(),
                  color: Colors.red,
                  icon: Icons.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, HomeLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            onChanged: (value) {
              context.read<HomeCubit>().searchStok(value, state.searchType);
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomFilterChip(
                  label: 'Arama Tipi',
                  value: state.searchType == SearchType.ad ? 'Ad' : 'Grup',
                  onTap: () => _showSearchTypeDialog(context, state),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomFilterChip(
                  label: 'Filtre',
                  value: _getFilterLabel(state.stokFilter),
                  onTap: () => _showFilterDialog(context, state),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFilterLabel(StokFilter filter) {
    return switch (filter) {
      StokFilter.tumStoklar => 'Tümü',
      StokFilter.stoktaOlanlar => 'Stokta',
      StokFilter.riskteOlanlar => 'Riskli',
    };
  }

  void _showSearchTypeDialog(BuildContext context, HomeLoaded state) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetContent(
        title: 'Arama Tipi',
        items: [
          BottomSheetItem(
            title: 'Ad ile Ara',
            isSelected: state.searchType == SearchType.ad,
            onTap: () {
              context.read<HomeCubit>().updateSearchType(SearchType.ad);
              Navigator.pop(context);
            },
          ),
          BottomSheetItem(
            title: 'Grup ile Ara',
            isSelected: state.searchType == SearchType.grup,
            onTap: () {
              context.read<HomeCubit>().updateSearchType(SearchType.grup);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, HomeLoaded state) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetContent(
        title: 'Filtrele',
        items: [
          BottomSheetItem(
            title: 'Tüm Stoklar',
            isSelected: state.stokFilter == StokFilter.tumStoklar,
            onTap: () {
              context.read<HomeCubit>().updateStokFilter(StokFilter.tumStoklar);
              Navigator.pop(context);
            },
          ),
          BottomSheetItem(
            title: 'Stokta Olanlar',
            isSelected: state.stokFilter == StokFilter.stoktaOlanlar,
            onTap: () {
              context
                  .read<HomeCubit>()
                  .updateStokFilter(StokFilter.stoktaOlanlar);
              Navigator.pop(context);
            },
          ),
          BottomSheetItem(
            title: 'Stoğu Riskte Olanlar',
            isSelected: state.stokFilter == StokFilter.riskteOlanlar,
            onTap: () {
              context
                  .read<HomeCubit>()
                  .updateStokFilter(StokFilter.riskteOlanlar);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringBar(HomeLoaded state) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stok Takibi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MonitoringButton(
                  isMonitoring: state.isMonitoring,
                  onPressed: () => context.read<HomeCubit>().startMonitoring(),
                  label: "Başlat",
                  isEnabled: !state.isMonitoring,
                  icon: Icons.play_arrow,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MonitoringButton(
                  isMonitoring: state.isMonitoring,
                  onPressed: () => context.read<HomeCubit>().stopMonitoring(),
                  label: "Durdur",
                  isEnabled: state.isMonitoring,
                  icon: Icons.stop,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockGrid(HomeLoaded state) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 1200
              ? 3
              : MediaQuery.of(context).size.width > 768
                  ? 2
                  : 1,
          childAspectRatio: MediaQuery.of(context).size.width > 768 ? 2.5 : 2.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = state.filteredList[index];
            return StockCard(
              item: item,
              isMonitoring: state.isMonitoring,
              onTap: () async {
                await Navigator.of(context).push(DetailScreen.route(item));
                if (context.mounted) {
                  context.read<HomeCubit>().getStokList();
                }
              },
            );
          },
          childCount: state.filteredList.length,
        ),
      ),
    );
  }
}
