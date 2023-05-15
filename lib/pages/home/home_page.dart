import 'package:flutter/material.dart';
import 'package:register_of_receivables_front/ui/helper/size_extesions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: context.percentWidth(.33),
            height: 48,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/receivables_list'),
              child: const Text(
                'Lista de cheques e boletos',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: context.percentWidth(.33),
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/people_list'),
              child: const Text(
                'Lista de clientes e vendedores',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
