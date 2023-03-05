resource "aws_lb" "nlb" {
  name               = "${var.name}-nlb"
  subnets            = var.subnet_ids
  internal           = true
  load_balancer_type = "network"
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-nlb"
  })
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.name}-tg"
  port        = 3128
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "3128"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}

resource "aws_security_group" "sg" {
  name        = "Allow inboud for Squid Proxy"
  description = "Allow inboud for Squid Proxy"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Squid port"
    from_port   = 3128
    to_port     = 3128
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-Allow_Squid"
  })
}