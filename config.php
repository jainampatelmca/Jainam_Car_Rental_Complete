<?php
declare(strict_types=1);

const DB_HOST = '127.0.0.1';
const DB_NAME = 'jainam_car_rental';
const DB_USER = 'root';
const DB_PASS = '';

function db(): PDO {
    static $pdo = null;
    if ($pdo instanceof PDO) return $pdo;
    $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4';
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    return $pdo;
}

if (session_status() !== PHP_SESSION_ACTIVE) session_start();

function e(?string $v): string { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function redirect(string $url): never { header('Location: '.$url); exit; }
function flash(string $type, string $message): void { $_SESSION['flash']=['type'=>$type,'message'=>$message]; }
function getFlash(): ?array { $f=$_SESSION['flash']??null; unset($_SESSION['flash']); return $f; }
function csrf(): string { if(empty($_SESSION['csrf'])) $_SESSION['csrf']=bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function verifyCsrf(): void { if(!hash_equals($_SESSION['csrf']??'', $_POST['csrf']??'')){ http_response_code(419); exit('Invalid CSRF token'); } }
function user(): ?array { return $_SESSION['user']??null; }
function isLoggedIn(): bool { return !!user(); }
function isAdmin(): bool { return (user()['role']??'')==='admin'; }
function requireLogin(): void { if(!isLoggedIn()) redirect('login.php'); }
function requireAdmin(): void { if(!isAdmin()) redirect('login.php'); }
function money(float $n): string { return '₹'.number_format($n,2); }
function uploadImage(array $file, string $prefix='car'): ?string {
    if(($file['error']??UPLOAD_ERR_NO_FILE)===UPLOAD_ERR_NO_FILE) return null;
    if($file['error']!==UPLOAD_ERR_OK) throw new RuntimeException('Image upload failed.');
    if($file['size'] > 6*1024*1024) throw new RuntimeException('Image must be under 6 MB.');
    $finfo=new finfo(FILEINFO_MIME_TYPE); $mime=$finfo->file($file['tmp_name']);
    $allowed=['image/jpeg'=>'jpg','image/png'=>'png','image/webp'=>'webp'];
    if(!isset($allowed[$mime])) throw new RuntimeException('Only JPG, PNG or WEBP images are allowed.');
    $name=$prefix.'_'.date('YmdHis').'_'.bin2hex(random_bytes(4)).'.'.$allowed[$mime];
    $dir=__DIR__.'/uploads/cars'; if(!is_dir($dir)) mkdir($dir,0755,true);
    if(!move_uploaded_file($file['tmp_name'],$dir.'/'.$name)) throw new RuntimeException('Could not save uploaded image.');
    return 'uploads/cars/'.$name;
}
function deleteImageFile(?string $url): void { if($url && str_starts_with($url,'uploads/cars/')){ $p=__DIR__.'/'.$url; if(is_file($p)) @unlink($p); } }
function bookingDays(string $pickup,string $return): int { $a=new DateTime($pickup); $b=new DateTime($return); return (int)$a->diff($b)->days; }
