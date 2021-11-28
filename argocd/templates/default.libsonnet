{
  _Object(apiVersion, kind, name):: {
    local this = self,
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name + '-' + std.asciiLower(kind),
      labels: { name: std.join("-", std.split(this.metadata.name, ":")) },
      annotations: {},
    },
  },

  Deployment(name, image, port=4000):
  local appName = std.join('-', [name, 'app']);
  local config = std.join('-', [name, 'config']);
  local secrets = std.join('-', [name, 'secrets']);

  $._Object('apps/v1', 'Deployment', name) {
    spec: {
      replicas: 1,
      revisionHistoryLimit: 1,
      selector: {
        matchLabels: {
          app: name
        },
      },
      template: {
        metadata: {
          labels: {
            app: name
          },
        },
        spec: {
          containers: [
            {
              name: appName,
              image: image,
              imagePullPolicy: 'Always',
              ports: [
                { containerPort: port },
              ],
              envFrom: [
                {
                  secretRef: { name: secrets },
                },
                {
                  configMapRef: { name: config },
                },
              ],
            },
          ],
        },
      },
    },
  },

  ConfigMap(name, data): $._Object('v1', 'ConfigMap', name) {
    data: data,
  },

  Service(name, port=4000, targetPort=port, app=name): $._Object('v1', 'Service', name) {
    spec: {
      ports: [
        {
          port: port,
          targetPort: targetPort
        },
      ],
      selector: {
        app: app
      },
    },
  },

  IngressCRD(name, routes=[name], service=name, port=4000): $._Object('traefik.containo.us/v1alpha1', 'IngressRoute', name) {
    spec: {
      entrypoints: [
        'websecure',
        'web'
      ],
      tls: {
        certResolver: 'le'
      },
      routes: std.map(function(route) {
          kind: 'Rule',
          match: 'Host(`' + route + '`)',
          services:
            [
              {
                name: service,
                port: port
              },
            ],
        },
        routes),
    },
  },

  App(name, image, routes, config): [
    Deployment(name, image),
    Service(name),
    IngressCRD(name, routes),
    ConfigMap(name, config),
  ],
}
