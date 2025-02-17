import 'package:bilsoft_srlm/core/service/notification_service.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:bilsoft_srlm/features/detail/view/detail_screen.dart';
import 'package:bilsoft_srlm/features/home/cubit/home_cubit.dart';
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
  SearchType _searchType = SearchType.ad;
  StokFilter _stokFilter = StokFilter.tumStoklar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getStokList(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return switch (state) {
                  HomeLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  HomeLoaded() => Column(
                      children: [
                        _buildSearchBar(context),
                        ElevatedButton(
                            onPressed: () {
                              
                              NotificationService().showNotification(
                                title: 'Bilsoft SRLM',
                                body: 'Stoklar listelendi',
                              );
                            },
                            child: Text('Show Notification')),
                        Expanded(child: _buildStockList(state)),
                      ],
                    ),
                  HomeError() => Center(
                      child: Text(state.message),
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Stok Ara...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<HomeCubit>().searchStok(value, _searchType);
                  },
                ),
              ),
              const SizedBox(width: 8),
              _buildSearchTypeDropdown(),
            ],
          ),
          const SizedBox(height: 8),
          _buildFilterDropdown(context),
        ],
      ),
    );
  }

  Widget _buildSearchTypeDropdown() {
    return DropdownButton<SearchType>(
      value: _searchType,
      items: const [
        DropdownMenuItem(
          value: SearchType.ad,
          child: Text('Ad'),
        ),
        DropdownMenuItem(
          value: SearchType.grup,
          child: Text('Grup'),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _searchType = value;
          });
        }
      },
    );
  }

  Widget _buildFilterDropdown(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<StokFilter>(
        value: _stokFilter,
        isExpanded: true,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(
            value: StokFilter.tumStoklar,
            child: Text('Tüm Stoklar'),
          ),
          DropdownMenuItem(
            value: StokFilter.stoktaOlanlar,
            child: Text('Stokta Olanlar'),
          ),
          DropdownMenuItem(
            value: StokFilter.riskteOlanlar,
            child: Text('Stoğu Riskte Olanlar'),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _stokFilter = value;
            });
            context.read<HomeCubit>().filterStoklar(_stokFilter);
          }
        },
      ),
    );
  }

  Widget _buildStockList(HomeLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.filteredList.length,
      itemBuilder: (context, index) {
        final item = state.filteredList[index];
        return _buildStockCard(context, item);
      },
    );
  }

  Widget _buildStockCard(BuildContext context, StokEntity item) {
    final int kalan = item.giris - item.cikis;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Navigator.of(context).push(DetailScreen.route(item));
          context.read<HomeCubit>().getStokList();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStockHeader(item),
              const SizedBox(height: 12),
              _buildStockInfo(item, kalan),
              const SizedBox(height: 8),
              _buildBarcodeInfo(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockHeader(StokEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            item.ad,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item.grup,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStockInfo(StokEntity item, int kalan) {
    return Row(
      children: [
        _buildStockInfoTile('Giriş', item.giris.toString(), Colors.green),
        const SizedBox(width: 12),
        _buildStockInfoTile('Çıkış', item.cikis.toString(), Colors.red),
        const SizedBox(width: 12),
        _buildStockInfoTile('Kalan', kalan.toString(), Colors.blue),
        const SizedBox(width: 12),
        _buildStockInfoTile(
          'Risk Limit',
          '${item.riskLimit ?? 0}',
          kalan <= (item.riskLimit ?? 0) ? Colors.red : Colors.green,
        ),
      ],
    );
  }

  Widget _buildStockInfoTile(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeInfo(StokEntity item) {
    return Row(
      children: [
        Icon(
          Icons.qr_code,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          item.barkod,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
