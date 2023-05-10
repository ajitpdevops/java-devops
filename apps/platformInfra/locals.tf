locals {
    target_group_names = {
        for key, value in var.microservices : "${microservice_name}-TG" => key
    }
}