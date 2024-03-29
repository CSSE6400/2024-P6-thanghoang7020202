# Description: This file contains the configuration for autoscaling the ECS service based on CPU utilization.
resource "aws_appautoscaling_target" "todo" { 
  max_capacity        = 2 # max number of ECS instances
  min_capacity        = 1 
  resource_id         = "service/taskoverflow/taskoverflow" 
  scalable_dimension  = "ecs:service:DesiredCount" 
  service_namespace   = "ecs" 
} 
 
# autoscaling policy
resource "aws_appautoscaling_policy" "todo-cpu" { 
  name                = "todo-cpu" 
  policy_type         = "TargetTrackingScaling" 
  resource_id         = aws_appautoscaling_target.todo.resource_id 
  scalable_dimension  = aws_appautoscaling_target.todo.scalable_dimension 
  service_namespace   = aws_appautoscaling_target.todo.service_namespace 
 
  target_tracking_scaling_policy_configuration { 
    predefined_metric_specification { 
      predefined_metric_type  = "ECSServiceAverageCPUUtilization" 
    } 
 
    target_value              = 20 # 20% CPU utilization
  } 
}