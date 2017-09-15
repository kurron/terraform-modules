output "ami_id" {
    value = "${data.aws_ami.ecs_ami.id}"
    description = "ID of the selected ECS AMI"
}

output "instance_ids" {
    value = ["${aws_instance.docker.*.id}"]
    description = "IDs of the Docker instances"
}
