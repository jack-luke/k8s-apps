pools{
    main = {
        backends = {
            "memcached-0.memcached-headless.memcached.svc.cluster.local:11211",
            "memcached-1.memcached-headless.memcached.svc.cluster.local:11211",
            "memcached-2.memcached-headless.memcached.svc.cluster.local:11211",
        }
    }
}
routes{
    default = route_direct{ child = "main" }
}