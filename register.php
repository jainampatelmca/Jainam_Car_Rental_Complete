<?php
require __DIR__.'/config.php'; require __DIR__.'/functions.php';
if(isLoggedIn()) redirect('index.php'); $error='';
if($_SERVER['REQUEST_METHOD']==='POST'){
 try{verifyCsrf();$name=trim($_POST['name']??'');$email=trim($_POST['email']??'');$phone=trim($_POST['phone']??'');$p=$_POST['password']??'';$p2=$_POST['password2']??'';
 if(strlen($name)<2||!filter_var($email,FILTER_VALIDATE_EMAIL)||strlen($p)<6||$p!==$p2) throw new RuntimeException('Enter valid details and matching passwords (minimum 6 characters).');
 $st=db()->prepare('SELECT id FROM users WHERE email=?');$st->execute([$email]);if($st->fetch()) throw new RuntimeException('Email is already registered.');
 $st=db()->prepare('INSERT INTO users(name,email,phone,password_hash,role) VALUES(?,?,?,?,\'customer\')');$st->execute([$name,$email,$phone,password_hash($p,PASSWORD_DEFAULT)]);flash('success','Account created. Please log in.');redirect('login.php');
 }catch(Throwable $e){$error=$e->getMessage();}
}
pageTop('Create Account');nav();?><main class="auth-wrap"><section class="auth-card"><p class="eyebrow">CUSTOMER ACCOUNT</p><h1>Create your account</h1><?php if($error): ?><div class="flash error"><?=e($error)?></div><?php endif; ?><form method="post" class="form-grid"><input type="hidden" name="csrf" value="<?=e(csrf())?>"><label>Full name<input name="name" required></label><label>Email<input type="email" name="email" required></label><label>Phone<input name="phone"></label><label>Password<input type="password" name="password" required></label><label>Confirm password<input type="password" name="password2" required></label><button class="btn primary">Create account</button></form><p class="small">Already registered? <a href="login.php">Login</a></p></section></main><?php pageBottom(); ?>