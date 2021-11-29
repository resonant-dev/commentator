local template = import 'templates/default.libsonnet';

function()
  local name = std.extVar('name');
  local ns = std.extVar('ns');
  local env = std.extVar('environment');

  template.App(
    std.join('-', [env, name]),
    'ghcr.io/resonant-dev/commentator:latest',
    [
        'commentator.sbx1.resonant.dev',
    ],
    {
      PORT: '4000',
      POOL_SIZE: '10'
    }
  )
