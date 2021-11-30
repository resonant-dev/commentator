local template = import 'templates/default.libsonnet';

function(name,container,routes,env)
  template.App(
    name,
    container,
    routes,
    env
  )
