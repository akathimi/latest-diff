# latest-diff
A helm 3 plugin that lists the installed charts with their respective latest appversion and chartversion.
Make sure that your helm repos are present for the chart you are listing.


## Installation

```
helm plugin install https://github.com/akathimi/latest-diff
```

## Usage

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

**Colors:**
* Green: Chart/App version is the same as latest.
* Yellow: Chart/App version is older than latest.
* Red: Chart was not found in any of the help repositories added.

## *TODO*
* Add help output
