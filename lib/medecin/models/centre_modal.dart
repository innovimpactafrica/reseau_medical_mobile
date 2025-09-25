class Disponibilite {
  String centreName;
  String jour;
  String heureDebut;
  String heureFin;
  String dureeConsultation;

  Disponibilite({
    required this.centreName,
    required this.jour,
    required this.heureDebut,
    required this.heureFin,
    required this.dureeConsultation,
  });
}

class Centre {
  String name;
  String address;
  bool active;
  List<Disponibilite> disponibilites;

  Centre({
    required this.name,
    required this.address,
    required this.active,
    required this.disponibilites,
  });
}
