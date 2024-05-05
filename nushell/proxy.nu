let host_ip = (cat /etc/resolv.conf | grep nameserver | str replace --all 'nameserver' '' | str trim)
let wsl_ip = (ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
let port = 7890
let proxy_http = $"http://($host_ip):($port)"

$env.http_proxy = $proxy_http
$env.HTTP_PROXY = $proxy_http
$env.https_proxy = $proxy_http
$env.HTTPS_PROXY = $proxy_http

git config --global http.https://github.com.proxy $proxy_http
git config --global https.https://github.com.proxy $proxy_http
