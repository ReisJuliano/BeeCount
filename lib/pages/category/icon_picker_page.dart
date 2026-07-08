import 'package:flutter/material.dart';
import '../../widgets/ui/ui.dart';
import '../../l10n/app_localizations.dart';
import '../../styles/tokens.dart';

class IconPickerPage extends StatefulWidget {
  final String? currentIcon;
  final String kind; // expense 或 income
  
  const IconPickerPage({
    super.key,
    this.currentIcon,
    required this.kind,
  });
  
  @override
  State<IconPickerPage> createState() => _IconPickerPageState();
}

class _IconPickerPageState extends State<IconPickerPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedIcon;
  
  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.currentIcon;
    final categories = _getIconCategories();
    _tabController = TabController(length: categories.length, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final categories = _getIconCategories();
    
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeader(
            title: AppLocalizations.of(context)!.iconPickerTitle,
            showBack: true,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedIcon);
                },
                child: Text(AppLocalizations.of(context)!.commonConfirm),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: BeeTokens.textPrimary(context),
              unselectedLabelColor: BeeTokens.textSecondary(context),
              tabs: categories.map((category) => Tab(text: category.name)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                return _IconGrid(
                  icons: category.icons,
                  selectedIcon: _selectedIcon,
                  onIconSelected: (icon) {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  List<_IconCategory> _getIconCategories() {
    if (widget.kind == 'expense') {
      return [
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryDining,
          icons: [
            _IconItem('restaurant', Icons.restaurant, 'Restaurante'),
            _IconItem('local_dining', Icons.local_dining, 'Refeição'),
            _IconItem('fastfood', Icons.fastfood, 'Fast food'),
            _IconItem('local_cafe', Icons.local_cafe, 'Café'),
            _IconItem('local_bar', Icons.local_bar, 'Bar'),
            _IconItem('cake', Icons.cake, 'Bolo'),
            _IconItem('local_pizza', Icons.local_pizza, 'Pizza'),
            _IconItem('icecream', Icons.icecream, 'Sorvete'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryTransport,
          icons: [
            _IconItem('directions_car', Icons.directions_car, 'Carro'),
            _IconItem('directions_bus', Icons.directions_bus, 'Ônibus'),
            _IconItem('directions_subway', Icons.directions_subway, 'Metrô'),
            _IconItem('local_taxi', Icons.local_taxi, 'Táxi'),
            _IconItem('flight', Icons.flight, 'Avião'),
            _IconItem('train', Icons.train, 'Trem'),
            _IconItem('directions_bike', Icons.directions_bike, 'Bicicleta'),
            _IconItem('directions_walk', Icons.directions_walk, 'A pé'),
            _IconItem('local_gas_station', Icons.local_gas_station, 'Combustível'),
            _IconItem('local_parking', Icons.local_parking, 'Estacionamento'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryShopping,
          icons: [
            _IconItem('shopping_cart', Icons.shopping_cart, 'Carrinho'),
            _IconItem('shopping_bag', Icons.shopping_bag, 'Sacola'),
            _IconItem('store', Icons.store, 'Loja'),
            _IconItem('local_mall', Icons.local_mall, 'Shopping'),
            _IconItem('local_grocery_store', Icons.local_grocery_store, 'Mercado'),
            _IconItem('checkroom', Icons.checkroom, 'Roupas'),
            _IconItem('watch', Icons.watch, 'Relógio'),
            _IconItem('diamond', Icons.diamond, 'Joias'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryEntertainment,
          icons: [
            _IconItem('movie', Icons.movie, 'Cinema'),
            _IconItem('music_note', Icons.music_note, 'Música'),
            _IconItem('sports_esports', Icons.sports_esports, 'Jogos'),
            _IconItem('sports_soccer', Icons.sports_soccer, 'Futebol'),
            _IconItem('sports_basketball', Icons.sports_basketball, 'Basquete'),
            _IconItem('theater_comedy', Icons.theater_comedy, 'Diversão'),
            _IconItem('camera_alt', Icons.camera_alt, 'Fotografia'),
            _IconItem('palette', Icons.palette, 'Arte'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryLife,
          icons: [
            _IconItem('home', Icons.home, 'Casa'),
            _IconItem('local_laundry_service', Icons.local_laundry_service, 'Lavanderia'),
            _IconItem('cleaning_services', Icons.cleaning_services, 'Limpeza'),
            _IconItem('plumbing', Icons.plumbing, 'Encanamento'),
            _IconItem('electrical_services', Icons.electrical_services, 'Eletricista'),
            _IconItem('handyman', Icons.handyman, 'Manutenção'),
            _IconItem('pets', Icons.pets, 'Pets'),
            _IconItem('child_care', Icons.child_care, 'Mãe e bebê'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryHealth,
          icons: [
            _IconItem('local_hospital', Icons.local_hospital, 'Hospital'),
            _IconItem('medical_services', Icons.medical_services, 'Médico'),
            _IconItem('local_pharmacy', Icons.local_pharmacy, 'Farmácia'),
            _IconItem('fitness_center', Icons.fitness_center, 'Academia'),
            _IconItem('spa', Icons.spa, 'Estética'),
            _IconItem('psychology', Icons.psychology, 'Psicologia'),
            _IconItem('face', Icons.face, 'Cuidados com a pele'),
            _IconItem('content_cut', Icons.content_cut, 'Cabeleireiro'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryEducation,
          icons: [
            _IconItem('school', Icons.school, 'Escola'),
            _IconItem('library_books', Icons.library_books, 'Livros'),
            _IconItem('computer', Icons.computer, 'Computador'),
            _IconItem('phone', Icons.phone, 'Telefonia'),
            _IconItem('language', Icons.language, 'Idiomas'),
            _IconItem('science', Icons.science, 'Ciência'),
            _IconItem('calculate', Icons.calculate, 'Cálculo'),
            _IconItem('brush', Icons.brush, 'Desenho'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryOther,
          icons: [
            _IconItem('business', Icons.business, 'Negócios'),
            _IconItem('work', Icons.work, 'Trabalho'),
            _IconItem('flash_on', Icons.flash_on, 'Água e luz'),
            _IconItem('wifi', Icons.wifi, 'Internet'),
            _IconItem('phone_android', Icons.phone_android, 'Celular'),
            _IconItem('smoking_rooms', Icons.smoking_rooms, 'Fumo e bebida'),
            _IconItem('favorite', Icons.favorite, 'Doação'),
            _IconItem('category', Icons.category, 'Outros'),
          ],
        ),
      ];
    } else {
      // 收入分类图标
      return [
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryWork,
          icons: [
            _IconItem('work', Icons.work, 'Salário'),
            _IconItem('business_center', Icons.business_center, 'Negócios'),
            _IconItem('engineering', Icons.engineering, 'Técnico'),
            _IconItem('design_services', Icons.design_services, 'Design'),
            _IconItem('agriculture', Icons.agriculture, 'Agricultura'),
            _IconItem('construction', Icons.construction, 'Construção'),
            _IconItem('local_shipping', Icons.local_shipping, 'Logística'),
            _IconItem('restaurant_menu', Icons.restaurant_menu, 'Alimentação'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryFinance,
          icons: [
            _IconItem('account_balance', Icons.account_balance, 'Banco'),
            _IconItem('savings', Icons.savings, 'Poupança'),
            _IconItem('trending_up', Icons.trending_up, 'Investimento'),
            _IconItem('paid', Icons.paid, 'Juros'),
            _IconItem('currency_exchange', Icons.currency_exchange, 'Câmbio'),
            _IconItem('wallet', Icons.wallet, 'Carteira'),
            _IconItem('credit_card', Icons.credit_card, 'Cartão de crédito'),
            _IconItem('account_balance_wallet', Icons.account_balance_wallet, 'Saldo'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryReward,
          icons: [
            _IconItem('card_giftcard', Icons.card_giftcard, 'Presente em dinheiro'),
            _IconItem('redeem', Icons.redeem, 'Bônus'),
            _IconItem('emoji_events', Icons.emoji_events, 'Prêmio'),
            _IconItem('star', Icons.star, 'Avaliação'),
            _IconItem('grade', Icons.grade, 'Nível'),
            _IconItem('loyalty', Icons.loyalty, 'Pontos'),
            _IconItem('volunteer_activism', Icons.volunteer_activism, 'Presente'),
            _IconItem('celebration', Icons.celebration, 'Comemoração'),
          ],
        ),
        _IconCategory(
          name: AppLocalizations.of(context)!.iconCategoryOther,
          icons: [
            _IconItem('receipt_long', Icons.receipt_long, 'Reembolso'),
            _IconItem('part_time', Icons.schedule, 'Bico'),
            _IconItem('undo', Icons.undo, 'Estorno'),
            _IconItem('money', Icons.attach_money, 'Dinheiro'),
            _IconItem('apartment', Icons.apartment, 'Aluguel'),
            _IconItem('handshake', Icons.handshake, 'Parceria'),
            _IconItem('category', Icons.category, 'Outros'),
            _IconItem('help', Icons.help, 'Sem categoria'),
          ],
        ),
      ];
    }
  }
}

class _IconGrid extends StatelessWidget {
  final List<_IconItem> icons;
  final String? selectedIcon;
  final ValueChanged<String> onIconSelected;
  
  const _IconGrid({
    required this.icons,
    required this.selectedIcon,
    required this.onIconSelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];
        final isSelected = selectedIcon == icon.key;
        
        return InkWell(
          onTap: () => onIconSelected(icon.key),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected 
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : null,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : BeeTokens.border(context),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon.iconData,
                  size: 32,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color,
                ),
                const SizedBox(height: 4),
                Text(
                  icon.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IconCategory {
  final String name;
  final List<_IconItem> icons;
  
  const _IconCategory({
    required this.name,
    required this.icons,
  });
}

class _IconItem {
  final String key;
  final IconData iconData;
  final String label;
  
  const _IconItem(this.key, this.iconData, this.label);
}