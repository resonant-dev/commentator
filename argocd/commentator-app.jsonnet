local template = import 'templates/default.libsonnet';

function(name='commentator', namespace='default', env)
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
