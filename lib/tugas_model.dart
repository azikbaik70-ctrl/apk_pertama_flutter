class Tugas {
  final String id;
  final String namaTugas;
  final String mataPelajaran;
  bool isDiserahkan;

  Tugas({
    required this.id,
    required this.namaTugas,
    required this.mataPelajaran,
    this.isDiserahkan = false,
  });
}
