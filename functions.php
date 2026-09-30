<?php
require_once __DIR__.'/config.php';
function nav(string $active=''): void { $u=user(); ?>
<header class="topbar"><a class="brand" href="index.php"><span class="brand-mark">J</span><span>Jainam</span><small>CAR RENTAL</small></a><nav>
<a class="<?= $active==='home'?'active':'' ?>" href="index.php">Home</a>
<?php if($u && $u['role']==='customer'): ?><a href="customer.php">My Bookings</a><?php endif; ?>
<?php if($u && $u['role']==='admin'): ?><a class="<?= $active==='admin'?'active':'' ?>" href="admin/index.php">Admin Dashboard</a><?php endif; ?>
<?php if($u): ?><span class="hello">Hi, <?=e($u['name'])?></span><a href="logout.php">Logout</a><?php else: ?><a href="login.php">Login</a><a class="nav-cta" href="register.php">Create account</a><?php endif; ?>
</nav></header>
<?php }
function pageTop(string $title): void { ?><!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><?=e($title)?> | Jainam Car Rental</title><link rel="stylesheet" href="assets/style.css"></head><body><?php }
function pageBottom(): void { ?></body></html><?php }
function adminTop(string $title,string $active=''): void { pageTop($title); $f=getFlash(); ?><div class="admin-shell"><aside class="sidebar"><a class="brand side-brand" href="../index.php"><span class="brand-mark">J</span><span>Jainam</span><small>ADMIN</small></a><a class="side-link <?= $active==='dashboard'?'active':'' ?>" href="index.php">Dashboard</a><a class="side-link <?= $active==='cars'?'active':'' ?>" href="cars.php">Cars & Fleet</a><a class="side-link <?= $active==='bookings'?'active':'' ?>" href="bookings.php">Bookings</a><a class="side-link <?= $active==='feedback'?'active':'' ?>" href="feedback.php">Feedback</a><a class="side-link" href="../index.php">View Website</a><a class="side-link" href="../logout.php">Logout</a></aside><main class="admin-main"><div class="admin-head"><div><p class="eyebrow">JAINAM CAR RENTAL</p><h1><?=e($title)?></h1></div></div><?php if($f): ?><div class="flash <?=$f['type']?>"><?=e($f['message'])?></div><?php endif; ?><?php }
function adminBottom(): void { ?></main></div></body></html><?php }
