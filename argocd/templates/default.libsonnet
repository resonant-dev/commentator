{
  _Object(apiVersion, kind, name):: {
    local this = self,
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name + '-' + std.asciiLower(kind),
      namespace: 'default',
      labels: { name: std.join("-", std.split(this.metadata.name, ":")) },
      annotations: {},
    },
  },

  Deployment(name, image, port=4000): $._Object('apps/v1', 'Deployment', name) {
    local appName = std.join('-', [name, 'app']),
    local config = std.join('-', [name, 'configmap']),
    local secrets = std.join('-', [name, 'secrets']),

    spec: {
      replicas: 1,
      revisionHistoryLimit: 1,
      selector: {
        matchLabels: {
          app: appName
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
    local appName = std.join('-', [name, 'app']),
    spec: {
      ports: [
        {
          port: port,
          targetPort: targetPort
        },
      ],
      selector: {
        app: appName
      },
    },
  },

  IngressCRD(name, routes, port=4000): $._Object('traefik.containo.us/v1alpha1', 'IngressRoute', name) {
    local service = std.join('-', [name, 'service']),

    spec: {
      entryPoints: [
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
    $.Deployment(name, image),
    $.Service(name),
    $.IngressCRD(name, routes),
    $.ConfigMap(name, config),
  ],
}
