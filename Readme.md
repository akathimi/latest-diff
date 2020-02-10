# Installation

```
helm 3 plugin install https://github.com/akathimi/latest-diff
```

# Usage

To get latest app/chart version for current namespace:
```
helm latest-diff
```
To get latest app/chart version for a specific namespace:
```
helm latest-diff -n <namespace>
```
To get latest app/chart version for all deployed charts:
```
helm latest-diff --all-namespaces
```

# TODO
* Add help output
