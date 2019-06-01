# Environment variables are composed into the container definition at output generation time. See outputs.tf for more information.
locals {
  container_definition = {
    command                = var.command
    cpu                    = var.cpu > 0 ? var.cpu : null
    dependsOn              = var.depends
    disableNetworking      = var.disable_networking
    dnsSearchDomains       = var.dns_search_domains
    dnsServers             = var.dns_servers
    dockerLabels           = var.docker_labels
    dockerSecurityOptions  = var.docker_security_options
    entryPoint             = var.entrypoint
    environment            = var.environment
    essential              = var.essential
    extraHosts             = var.extra_hosts
    gpu                    = var.gpu > 0 ? var.gpu : null
    healthCheck            = var.healthcheck
    hostname               = var.hostname
    image                  = var.image
    interactive            = var.interactive
    links                  = var.links
    linuxParameters        = var.linux_parameters
    logConfiguration       = var.log_configuration
    memory                 = var.memory > 0 ? var.memory : null
    memoryReservation      = var.memory_reservation > 0 ? var.memory_reservation : null
    mountPoints            = var.mount_points
    name                   = var.name
    portMappings           = var.port_mappings
    privileged             = var.privileged
    psuedoTerminal         = var.psuedo_terminal
    readonlyRootFilesystem = var.readonly_root_filesystem
    repositoryCredentials  = var.repository_credentials
    secrets                = var.secrets
    startTimeout           = var.start_timeout > 0 ? var.start_timeout : null
    stopTimeout            = var.stop_timeout > 0 ? var.stop_timeout : null
    systemControls         = var.system_controls
    ulimits                = var.ulimits
    user                   = var.user
    volumesFrom            = var.volumes_from
    workingDirectory       = var.working_directory
  }
}
