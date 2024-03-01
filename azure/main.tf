

module "rg" {
    source = "./modules/rg"
}


module "storage" {
    source = "./modules/storage"
    rg_name = module.rg.rg_eus_name
    rg_loc = module.rg.rg_eus_loc
}


module "budget" {
    source = "./modules/budget"
    rg_name = module.rg.rg_eus_name
    rg_id = module.rg.rg_eus_id
} 