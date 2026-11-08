class Tugas {
  final String id;
  final String namaTugas;
  final String mataPelajaran;
  bool isDiserhakan;

  Tugas({
    required this.id,
    required this.namaTugas,
    required this.mataPelajaran,
    this.isDiserhakan = false,
});
}