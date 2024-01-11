<nav class="navbar navbar-dark bg-dark bg-gradient navbar-expand-lg navbar-expand-md my-3">
	<div class="container-fluid">
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
			<ul class="nav navbar-nav menus">		
				<li class="nav-item"><a class="nav-link" href="index.php" id="index_menu">Ana Sayfası</a></li>
				<li class="nav-item"><a class="nav-link" href="customer.php" id="customer_menu">Müşteri</a></li>
				<li class="nav-item"><a class="nav-link" href="category.php" id="category_menu">Kategori</a></li>
				<li class="nav-item"><a class="nav-link" href="brand.php" id="brand_menu">Marka</a></li>
				<li class="nav-item"><a class="nav-link" href="supplier.php" id="supplier_menu">Tedarikçi</a></li>
				<li class="nav-item"><a class="nav-link" href="product.php" id="product_menu">Ürün</a></li>
				<li class="nav-item"><a class="nav-link" href="purchase.php" id="purchase_menu">Satın almak</a></li>
				<li class="nav-item"><a class="nav-link" href="order.php" id="order_menu">Siparişler</a></li>			
			</ul>
		</div>
		<ul class="nav navbar-nav">
			<li class="dropdown position-relative">
				<button type="button" class="badge bg-light border px-3 text-dark rounded-pill dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
					<span class="badge badge-pill bg-danger count"></span> 
					<?php echo $_SESSION['name']; ?>
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					<li><a class="dropdown-item" href="action.php?action=logout">Çıkış Yap</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>