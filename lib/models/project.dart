typedef OpenFunction = Function(bool dcUp);

class Project {
  final String label;
  final bool dockerized;

  /// if `dockerized` was false the `dcUp` boolean parameter will always be false
  final OpenFunction open;

  const Project({
    required this.label,
    required this.dockerized,
    required this.open,
  });
}
