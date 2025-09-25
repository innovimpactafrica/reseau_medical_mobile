import 'package:flutter/material.dart';
import '../models/centre_modal.dart';

class CentreCard extends StatelessWidget {
  final Centre centre;
  final ValueChanged<bool> onToggleActive;

  const CentreCard({
    Key? key,
    required this.centre,
    required this.onToggleActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 📷 Icône
          Container(
            padding: const EdgeInsets.all(6),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/afil.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),

          // 📝 Infos centre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🏷 Titre + Statut + Switch sur la même ligne
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        centre.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      centre.active ? "Actif" : "Inactif",
                      style: TextStyle(
                        color: centre.active ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: centre.active,
                        onChanged: onToggleActive,
                      ),
                    ),
                  ],
                ),

                // 📍 Adresse
                const SizedBox(height: 2),
                Text(
                  centre.address,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
