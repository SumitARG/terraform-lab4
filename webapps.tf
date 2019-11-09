resource "azurerm_resource_group" "webapps" {
    name        = "webapps"
    location    = "${var.loc}"
    tags        = "${var.tags}"
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    count               = "${length(var.webapplocs)}"
    name                = "plan-free-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "citadel" {
    count               = "${length(var.webapplocs)}"
    name                = "webapp-${random_string.webapprnd.result}-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    app_service_plan_id = "${element(azurerm_app_service_plan.free.*.id, count.index)}"
}

output "webapp_ids" {
  value = "${azurerm_app_service.citadel.*.id}"
}

provider "azurerm" {
  subscription_id = "32c32163-f026-41ed-9503-3b0ee6ec5540"
  client_id       = "b9543670-34cb-410d-ad75-fb29e77964cc"
  client_secret   = "Jg-xsz_p7Ru/5TOiRke_F1fsimnVUVJ8"
  tenant_id       = "f66ccb58-5436-40de-ae8b-e951e03cb2b3"
}
