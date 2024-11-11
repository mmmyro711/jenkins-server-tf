# Route53 - A Record
# resource "aws_route53_record" "a_record" {
#   zone_id = data.aws_route53_zone.kloudgate_hosted_zone.zone_id
#   name    = var.a_record_name
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.myjenkins_server.public_ip]
# }

# # Route53 - A Record (www)
# resource "aws_route53_record" "www_record" {
#   zone_id = data.aws_route53_zone.kloudgate_hosted_zone.zone_id
#   name    = "www.${var.a_record_name}"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.myjenkins_server.public_ip]
# }