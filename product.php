<?php 
ob_start();
session_start();
include('inc/header.php');
include 'Inventory.php';
$inventory = new Inventory();
$inventory->checkLogin();
?>

<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>		
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
<script src="js/product.js"></script>
<script src="js/common.js"></script>
<?php include('inc/container.php');?>
<div class="container">		
		
	<?php include("menus.php"); ?> 	
	
	<div class="row">
			<div class="col-lg-12">
				<div class="card card-default rounded-0 shadow">
                    <div class="card-header">
                    	<div class="row">
                            <div class="col-lg-10 col-md-10 col-sm-8 col-xs-6">
                            	<h3 class="card-title">Ürün listesi</h3>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6 text-end">
                                <button type="button" name="add" id="addProduct" class="btn btn-primary bg-gradient rounded-0 btn-sm"><i class="far fa-plus-square"></i> ürün ekle</button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row"><div class="col-sm-12 table-responsive">
                            <table id="productList" class="table table-bordered table-striped">
                                <thead><tr>
                                    <th>ID</th>      
									<th>kategori</th>	
									<th>Marka adı</th>									
                                    <th>Ürün adı</th>
									<th>ürün modeli</th>
                                    <th>Miktar</th>
                                    <th>Tedarikçi Adı</th>
                                    <th>Durum</th>
                                    <th>Aksiyon</th>
                                </tr></thead>
                            </table>
                        </div></div>
                    </div>
                </div>
			</div>
		</div>

        <div id="productModal" class="modal fade">
            <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title"><i class="fa fa-plus"></i>ürün ekle </h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form method="post" id="productForm">
                                <input type="hidden" name="pid" id="pid" />
                                <input type="hidden" name="btn_action" id="btn_action" />
                                <div class="form-group">
                                    <label>Kategori Seçiniz</label>
                                    <select name="categoryid" id="categoryid" class="form-select rounded-0" required>
                                        <option value="">Kategori Seçiniz</option>
                                        <?php echo $inventory->categoryDropdownList();?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Marka Seçiniz</label>
                                    <select name="brandid" id="brandid" class="form-select rounded-0" required>
                                        <option value="">Marka Seçiniz</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Ürün adı</label>
                                    <input type="text" name="pname" id="pname" class="form-control rounded-0" required />
                                </div>
                                <div class="form-group">
                                    <label>ürün modeli</label>
                                    <input type="text" name="pmodel" id="pmodel" class="form-control rounded-0" required />
                                </div>
                                <div class="form-group">
                                    <label>Ürün Açıklaması</label>
                                    <textarea name="description" id="description" class="form-control rounded-0" rows="5" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Ürün miktarı</label>
                                    <div class="input-group">
                                        <input type="text" name="quantity" id="quantity" class="form-control rounded-0" required pattern="[+-]?([0-9]*[.])?[0-9]+" /> 
                                        <select name="unit" class="form-select rounded-0" id="unit" required>
                                            <option value="">Birim Seç</option>
                                            <option value="Bags">Çantalar</option>
                                            <option value="Bottles">Şişeler</option>
                                            <option value="Box">Kutu</option>
                                            <option value="Dozens">Düzinelerce</option>
                                            <option value="Feet">Ayak</option>
                                            <option value="Gallon">Galon</option>
                                            <option value="Grams">gram</option>
                                            <option value="Inch">az miktar</option>
                                            <option value="Kg">Kg</option>
                                            <option value="Liters">Litre</option>
                                            <option value="Meter">Metre</option>
                                            <option value="Nos">Nos</option>
                                            <option value="Packet">Paket</option>
                                            <option value="Rolls">Rolls</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Ürün Taban Fiyatı</label>
                                    <input type="text" name="base_price" id="base_price" class="form-control rounded-0" required pattern="[+-]?([0-9]*[.])?[0-9]+" />
                                </div>
                                <div class="form-group">
                                    <label>Ürün Vergisi (%)</label>
                                    <input type="text" name="tax" id="tax" class="form-control rounded-0" required pattern="[+-]?([0-9]*[.])?[0-9]+" />
                                </div>
                                <div class="form-group">
                                    <label>Tedarikçi</label>
                                    <select name="supplierid" id="supplierid" class="form-select rounded-0" required>
                                        <option value="">Tedarikçi Seçin</option>
                                        <?php echo $inventory->supplierDropdownList();?>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" name="action" id="action" class="btn btn-primary rounded-0 btn-sm" value="Add" form="productForm"/>
                            <button type="button" class="btn btn-default border rounded-0 btn-sm" data-bs-dismiss="modal">Kapat</button>
                        </div>
                    </div>
            </div>
        </div>

        <div id="productViewModal" class="modal fade">
            <div class="modal-dialog modal-dialog-centered">
                <form method="post" id="product_form">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title"><i class="fa fa-th-list"></i>Ürün Detayları </h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <Div id="productDetails"></Div>
                        </div>
                        <div class="modal-footer">
                            
                            <button type="button" class="btn btn-default" data-bs-dismiss="modal">Kapat</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
	
</div>	
<?php include('inc/footer.php');?>