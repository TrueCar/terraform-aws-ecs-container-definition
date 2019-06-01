variable "name" {
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
  type        = string
}

variable "image" {
  description = "The image used to start the container. Images in the Docker Hub registry available by default"
  type        = string
}

variable "essential" {
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = true
}

variable "entrypoint" {
  description = "The entry point that is passed to the container"
  type        = list(string)
  default     = []
}

variable "command" {
  description = "The command that is passed to the container"
  type        = list(string)
  default     = []
}

variable "working_directory" {
  description = "The working directory to run commands inside the container"
  type        = string
  default     = null
}

variable "cpu" {
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  type        = number
  default     = 0
}

variable "memory" {
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  type        = number
  default     = 0
}

variable "memory_reservation" {
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  type        = number
  default     = 0
}

variable "gpu" {
  description = ""
  type        = number
  default     = 0
}

variable "environment" {
  description = "The environment variables to pass to the container. This is a list of maps"
  type = set(object({
    name  = string
    value = string
  }))
  default = []
}

variable "secrets" {
  description = "the secrets to pass to the container. this is a list of maps"
  type = set(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "mount_points" {
  description = ""
  type = set(object({
    sourceVolume  = string
    containerPath = string
    readOnly      = bool
  }))
  default = []
}

variable "volumes_from" {
  type = set(object({
    sourceContainer = string
    readOnly        = bool
  }))
  description = "A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)."
  default     = []
}

variable "links" {
  type        = set(string)
  description = "List of container names this container can communicate with without port mappings."
  default     = []
}

variable "user" {
  description = "The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group"
  type        = string
  default     = null
}

variable "port_mappings" {
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  type = set(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = []
}

variable "healthcheck" {
  description = "A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  type = object({
    command     = string
    interval    = number
    timeout     = number
    retries     = number
    startPeriod = number
  })
  default = null
}

variable "hostname" {
  description = ""
  type        = string
  default     = null
}

variable "dns_search_domains" {
  description = ""
  type        = set(string)
  default     = []
}

variable "dns_servers" {
  type        = set(string)
  description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers."
  default     = []
}

variable "extra_hosts" {
  type = set(object({
    hostname  = string
    ipAddress = string
  }))
  default = []
}

variable "disable_networking" {
  description = ""
  type        = bool
  default     = false
}

variable "privileged" {
  description = ""
  type        = bool
  default     = false
}

variable "readonly_root_filesystem" {
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = false
}

variable "log_configuration" {
  description = ""
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = set(object({
      name      = string
      valueFrom = string
    }))
  })
  default = null
}

variable "ulimits" {
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  type = set(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  default = []
}

variable "repository_credentials" {
  description = "Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  type = object({
    credentialsParameter = string
  })
  default = null
}

variable "depends" {
  type = set(object({
    containerName = string
    condition     = string
  }))
  description = "The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed"
  default     = []
}

variable "start_timeout" {
  description = "Time duration to wait before giving up on resolving dependencies for a container."
  type        = number
  default     = 0
}

variable "stop_timeout" {
  description = "Timeout in seconds between sending SIGTERM and SIGKILL to container"
  type        = number
  default     = 0
}

variable "docker_labels" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "docker_security_options" {
  description = ""
  type        = set(string)
  default     = []
}

variable "linux_parameters" {
  description = ""
  type = object({
    capabilities = object({
      add  = set(string)
      drop = set(string)
    })
    devices = set(object({
      containerPath = string
      hostPath      = string
      permissions   = set(string)
    }))
    initProcessEnabled = bool
    sharedMemorySize   = number
    tmpfs = set(object({
      containerPath = string
      mountOptions  = set(string)
      size          = number
    }))
  })
  default = null
}

variable "system_controls" {
  description = ""
  type = list(object({
    namespace = string
    value     = string
  }))
  default = null
}

variable "interactive" {
  description = ""
  type        = bool
  default     = null
}

variable "psuedo_terminal" {
  description = ""
  type        = bool
  default     = null
}
