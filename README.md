# enonic-xp
A Docker image for Enonic XP along with a Helm chart for deploying to Kubernetes

## Running development environment
```
docker-compose up --build
```

## Deploying to Kubernetes
```
helm install ./charts/enonic-xp
```

## Toolbox dump/restore
From a running shell in the container:
```
$XP_ROOT/toolbox/toolbox.sh dump -a su:$XP_SU_PASS -t /tmp/
```

To restore:
```
$XP_ROOT/toolbox/toolbox.sh load -a su:$XP_SU_PASS -s /tmp/
```
