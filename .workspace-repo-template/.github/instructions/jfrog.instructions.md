---
applyTo: "**/.jfrog/**,**/artifactory/**,**/*jfrog*"
---

# JFrog Instructions

> Conventions for JFrog Artifactory integration.

## Configuration Structure

```
.jfrog/
├── projects/
│   └── <project>.yaml     # Project configuration
└── config.yaml            # Global JFrog CLI config
```

## Repository Types

| Type | Purpose | Naming |
|------|---------|--------|
| local | Internal artifacts | `<team>-<type>-local` |
| remote | Proxy external repos | `<source>-remote` |
| virtual | Aggregate repositories | `<team>-<type>` |

## Naming Conventions

```
<team>-<artifact-type>-<repo-type>

Examples:
- platform-npm-local
- platform-nuget-local
- npmjs-remote
- platform-npm (virtual)
```

## Build Integration

### Maven

```xml
<distributionManagement>
    <repository>
        <id>artifactory</id>
        <url>${env.ARTIFACTORY_URL}/platform-maven-local</url>
    </repository>
</distributionManagement>
```

### npm

```json
{
  "publishConfig": {
    "registry": "https://artifactory.example.com/artifactory/api/npm/platform-npm-local/"
  }
}
```

### .NET

```xml
<packageSources>
    <add key="Artifactory" value="https://artifactory.example.com/artifactory/api/nuget/v3/platform-nuget" />
</packageSources>
```

## CLI Commands

```bash
# Configure CLI
jf config add --url=$ARTIFACTORY_URL --access-token=$ARTIFACTORY_TOKEN

# Upload artifact
jf rt upload "target/*.jar" platform-maven-local/com/example/

# Download artifact
jf rt download "platform-maven-local/com/example/*.jar" ./libs/

# Build publish
jf rt build-publish my-build 1.0.0
```

## Credential Management

- Never hardcode credentials
- Use environment variables or CLI config
- Prefer access tokens over passwords
- Rotate tokens regularly

```bash
# Environment variables
export ARTIFACTORY_URL=https://artifactory.example.com/artifactory
export ARTIFACTORY_TOKEN=<token>
```

## CI/CD Integration

```yaml
# GitHub Actions example
- name: Setup JFrog CLI
  uses: jfrog/setup-jfrog-cli@v3
  env:
    JF_URL: ${{ secrets.ARTIFACTORY_URL }}
    JF_ACCESS_TOKEN: ${{ secrets.ARTIFACTORY_TOKEN }}
```

## Anti-Patterns

- ❌ Hardcoded credentials in config files
- ❌ Using anonymous access for private repos
- ❌ Mixing artifact types in single repository
- ❌ Publishing snapshots to release repository
- ❌ Ignoring artifact cleanup policies
