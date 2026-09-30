<?php
require __DIR__.'/config.php'; require __DIR__.'/functions.php';
if(isLoggedIn()) redirect(isAdmin()?'admin/index.php':'index.php');
$error='';
if($_SERVER['REQUEST_METHOD']==='POST'){
 try{ verifyCsrf(); $email=trim($_POST['email']??''); $pass=$_POST['password']??''; $st=db()->prepare('SELECT * FROM users WHERE email=? AND active=1 LIMIT 1'); $st->execute([$email]); $u=$st->fetch();
 if(!$u || !password_verify($pass,$u['password_hash'])) throw new RuntimeException('Invalid email or password.');
 session_regenerate_id(true); $_SESSION['user']=['id'=>(int)$u['id'],'name'=>$u['name'],'email'=>$u['email'],'role'=>$u['role'],'phone'=>$u['phone']];
 redirect($u['role']==='admin'?'admin/index.php':'index.php');
 }catch(Throwable $e){$error=$e->getMessage();}
}
pageTop('Login'); nav(); ?><main class="auth-wrap"><section class="auth-card"><p class="eyebrow">WELCOME BACK</p><h1>Login to Jainam</h1><p class="muted">Customers can manage bookings. Admins can manage the complete fleet.</p><?php if($error): ?><div class="flash error"><?=e($error)?></div><?php endif; ?><form method="post" class="form-grid"><input type="hidden" name="csrf" value="<?=e(csrf())?>"><label>Email<input type="email" name="email" required autocomplete="email"></label><label>Password<input type="password" name="password" required autocomplete="current-password"></label><button class="btn primary" type="submit">Login</button></form><p class="small">New customer? <a href="register.php">Create an account</a></p><p class="small">Demo admin: <b>admin@jainam.com</b> / <b>Admin@123</b></p></section></main><?php pageBottom(); ?>