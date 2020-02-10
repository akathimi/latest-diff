#!/bin/bash
green=$(tput setaf 2)
yellow=$(tput setaf 3)
red=$(tput setaf 1)
current_info='/tmp/helm_diff.tmp'

if [ -z $1 ]; then
    $HELM_BIN ls -a >$current_info
elif [ "$1" = "--all-namespaces" ]; then
    $HELM_BIN ls -a --all-namespaces>$current_info
else
    echo "Unknown arg $1" && exit 1
fi
current_charts=$(cat $current_info | awk '{print $9}' | sed -n '1!p')
current_appversions=($(cat $current_info | awk '{print $10}' | sed -n '1!p'))
current_releases=($(cat $current_info | awk '{print $1}' | sed -n '1!p'))
printf "%-28s   %-28s  %15s  %15s  %15s  %15s\n" "CHART_NAME" "RELEASE" "CHART_VERSION" "APP_VERSION" "LATEST_CHART_VERSION" "LATEST_APP_VERSION"
echo "------------------------------------------------------------------------------------------------------------------------------------"
i=0
for chart in $current_charts; do
    tmp=$(echo $chart | perl -pe 's/\d//g' | cut -f1 -d".")
    chart_name=${tmp::-1}

    chart_version=$(echo $chart | grep -Po "(?<=$chart_name-)[^;]+")

    app_version=${current_appversions[$i]}
    release_name=${current_releases[$i]}
    latest_chartversion=$($HELM_BIN search repo $chart_name | awk '{print $2}' | sed -n '1!p' | head -n 1)
    latest_appversion=$($HELM_BIN search repo $chart_name | awk '{print $3}' | sed -n '1!p' | head -n 1)
    if [ ! -z $latest_chartversion ] || [ ! -z $latest_appversion ]; then
        if [ "$app_version" = "$latest_appversion" ] || [ "$chart_version" = "$latest_chartversion" ]; then chart_name="${green}$chart_name"; else chart_name="${yellow}$chart_name"; fi
    else
        chart_name="${red}$chart_name"
    fi
    printf "%-28s   %-28s   %15s   %15s   %15s   %15s\n" "$chart_name" "$release_name" "$chart_version" "$app_version" "$latest_chartversion" "$latest_appversion"

    i=$(($i + 1))
done
