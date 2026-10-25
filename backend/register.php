<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

function respond(int $statusCode, string $status, string $message): void
{
    http_response_code($statusCode);
    echo json_encode(
        ["status" => $status, "message" => $message],
        JSON_UNESCAPED_UNICODE
    );
    exit;
}

if ($_SERVER["REQUEST_METHOD"] === "OPTIONS") {
    http_response_code(204);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    respond(405, "error", "Gunakan metode POST.");
}

$data = json_decode(file_get_contents("php://input"));

if (
    !is_object($data) ||
    !isset($data->nama, $data->email, $data->password, $data->role) ||
    !is_string($data->nama) ||
    !is_string($data->email) ||
    !is_string($data->password) ||
    !is_string($data->role)
) {
    respond(400, "error", "Data tidak lengkap atau format JSON tidak valid.");
}

$nama = trim($data->nama);
$email = trim($data->email);
$password = $data->password;
$role = trim($data->role);

if ($nama === "" || $email === "" || $password === "" || $role === "") {
    respond(400, "error", "Data tidak boleh kosong.");
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    respond(400, "error", "Format email tidak valid.");
}

if (!in_array($role, ["guru", "siswa"], true)) {
    respond(400, "error", "Role harus guru atau siswa.");
}

if (!preg_match('/[A-Z]/', $password) || !preg_match('/[0-9]/', $password)) {
    respond(400, "error", "Password harus mengandung huruf kapital dan angka.");
}

$host = getenv("DB_HOST") ?: "localhost";
$username = getenv("DB_USER") ?: "root";
$databaseName = getenv("DB_NAME") ?: "todolist";
$databasePassword = getenv("DB_PASSWORD") ?: "";

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    $database = new mysqli($host, $username, $databasePassword, $databaseName);
    $database->set_charset("utf8mb4");

    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    $statement = $database->prepare(
        "INSERT INTO users (nama, email, password, role) VALUES (?, ?, ?, ?)"
    );
    $statement->bind_param("ssss", $nama, $email, $hashedPassword, $role);
    $statement->execute();

    respond(201, "success", "Akun berhasil dibuat.");
} catch (mysqli_sql_exception $exception) {
    if ($exception->getCode() === 1062) {
        respond(409, "error", "Email sudah terdaftar.");
    }

    error_log("Register database error: " . $exception->getMessage());
    respond(500, "error", "Terjadi kesalahan pada database.");
}
