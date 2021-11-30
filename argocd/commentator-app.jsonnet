local template = import 'templates/default.libsonnet';

function(env)
  local name = std.extVar('name');
  local ns = std.extVar('ns');
  local environment = std.extVar('environment');

  template.App(
    std.join('-', [environment, name]),
    'ghcr.io/resonant-dev/commentator:latest',
    [
        'commentator.sbx1.resonant.dev',
    ],
    env
  )
