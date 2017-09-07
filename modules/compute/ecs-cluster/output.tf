output "cluster_name" {
    value = "${aws_ecs_cluster.main.name}"
    description = "The name of the cluster"
}

output "cluster_id" {
    value = "${aws_ecs_cluster.main.id}"
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
}

output "ami_id" {
    value = "${data.aws_ami.ecs_ami.id}"
    description = "ID of the selected ECS AMI"
}
