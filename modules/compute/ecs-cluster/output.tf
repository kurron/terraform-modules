output "cluster_name" {
    value = "${aws_ecs_cluster.main.name}"
    description = "The name of the cluster"
}

output "cluster_id" {
    value = "${aws_ecs_cluster.main.id}"
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
}
