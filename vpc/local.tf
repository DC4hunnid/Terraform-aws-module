locals {
  main_tags = {
    Name    = var.vpc_name
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  public_route_tags = {
    Name    = "servicequik-public"
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  private_route_tags = {
    Name    = "servicequik-private"
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  eip_tags = {
    Name    = "servicequik-eip"
  }
}
