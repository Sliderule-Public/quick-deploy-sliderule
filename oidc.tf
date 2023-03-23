data "tls_certificate" "adt_eks_cert" {
  url = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  count           = var.create_oidc_provider == true ? 1 : 0
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.adt_eks_cert.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_iam_openid_connect_provider" "main" {
  count = var.create_oidc_provider == true ? 0 : 1
  url   = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
}

locals {
  oidc_arn = var.create_oidc_provider == true ? aws_iam_openid_connect_provider.main[0].arn : data.aws_iam_openid_connect_provider.main[0].arn
  oidc_url = var.create_oidc_provider == true ? aws_iam_openid_connect_provider.main[0].url : data.aws_iam_openid_connect_provider.main[0].url
}